export interface CostCalculationRequest {
  distance_km: number;
  passenger_count: number;
  base_fare?: number;
  rate_per_km?: number;
}

export interface CostBreakdown {
  ride_id: string;
  base_fare: number;
  distance_fare: number;
  passenger_count: number;
  total_cost: number;
  cost_per_passenger: number;
  breakdown: {
    distance_km: number;
    rate_per_km: number;
    passenger_split: 'equal';
  };
}

export interface Location {
  latitude: number;
  longitude: number;
}

export class CostService {
  // Default pricing constants
  private static readonly DEFAULT_BASE_FARE = 5.00; // Base fare in dollars
  private static readonly DEFAULT_RATE_PER_KM = 2.20; // Cost per kilometer
  private static readonly MINIMUM_FARE = 8.00; // Minimum total fare

  /**
   * Calculate distance between two locations using Haversine formula
   */
  static calculateDistance(origin: Location, destination: Location): number {
    const R = 6371; // Earth's radius in kilometers

    const dLat = this.toRadians(destination.latitude - origin.latitude);
    const dLon = this.toRadians(destination.longitude - origin.longitude);

    const a =
      Math.sin(dLat / 2) * Math.sin(dLat / 2) +
      Math.cos(this.toRadians(origin.latitude)) *
        Math.cos(this.toRadians(destination.latitude)) *
        Math.sin(dLon / 2) * Math.sin(dLon / 2);

    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));

    return R * c; // Distance in kilometers
  }

  /**
   * Calculate cost breakdown for a ride
   */
  static calculateRideCost(
    rideId: string,
    origin: Location,
    destination: Location,
    passengerCount: number,
    baseFare: number = this.DEFAULT_BASE_FARE,
    ratePerKm: number = this.DEFAULT_RATE_PER_KM
  ): CostBreakdown {
    // Calculate distance
    const distanceKm = this.calculateDistance(origin, destination);

    // Calculate fares
    const distanceFare = distanceKm * ratePerKm;
    const totalCost = Math.max(baseFare + distanceFare, this.MINIMUM_FARE);

    // Split cost equally among all passengers (including driver)
    const costPerPassenger = totalCost / passengerCount;

    return {
      ride_id: rideId,
      base_fare: baseFare,
      distance_fare: distanceFare,
      passenger_count: passengerCount,
      total_cost: totalCost,
      cost_per_passenger: costPerPassenger,
      breakdown: {
        distance_km: Math.round(distanceKm * 100) / 100, // Round to 2 decimal places
        rate_per_km: ratePerKm,
        passenger_split: 'equal'
      }
    };
  }

  /**
   * Calculate cost for an existing ride with current passenger count
   */
  static async calculateRideCostById(rideId: string): Promise<CostBreakdown> {
    // This would need to fetch the ride and passenger data from the database
    // For now, return a placeholder implementation
    throw new Error('Not implemented: calculateRideCostById requires database integration');
  }

  /**
   * Calculate cost distribution among passengers
   */
  static calculatePassengerShares(
    totalCost: number,
    passengerIds: string[],
    splitMethod: 'equal' = 'equal'
  ): Array<{ user_id: string; amount: number }> {
    if (splitMethod !== 'equal') {
      throw new Error('Only equal splitting is currently supported');
    }

    const costPerPassenger = totalCost / passengerIds.length;

    return passengerIds.map(userId => ({
      user_id: userId,
      amount: Math.round(costPerPassenger * 100) / 100 // Round to 2 decimal places
    }));
  }

  /**
   * Validate cost calculation parameters
   */
  static validateCostParameters(params: CostCalculationRequest): void {
    if (params.distance_km <= 0 || params.distance_km > 1000) {
      throw new Error('Distance must be between 0.01 and 1000 km');
    }

    if (params.passenger_count < 1 || params.passenger_count > 10) {
      throw new Error('Passenger count must be between 1 and 10');
    }

    if (params.base_fare !== undefined && (params.base_fare < 0 || params.base_fare > 100)) {
      throw new Error('Base fare must be between 0 and 100');
    }

    if (params.rate_per_km !== undefined && (params.rate_per_km < 0 || params.rate_per_km > 10)) {
      throw new Error('Rate per km must be between 0 and 10');
    }
  }

  /**
   * Convert degrees to radians
   */
  private static toRadians(degrees: number): number {
    return degrees * (Math.PI / 180);
  }

  /**
   * Apply surge pricing multiplier
   */
  static applySurgePricing(baseCost: number, surgeMultiplier: number = 1.0): number {
    if (surgeMultiplier < 1.0 || surgeMultiplier > 5.0) {
      throw new Error('Surge multiplier must be between 1.0 and 5.0');
    }

    return baseCost * surgeMultiplier;
  }

  /**
   * Calculate estimated cost for a potential ride
   */
  static estimateRideCost(
    origin: Location,
    destination: Location,
    estimatedPassengers: number = 2
  ): { estimated_cost: number; distance_km: number; cost_breakdown: CostBreakdown } {
    const distanceKm = this.calculateDistance(origin, destination);
    const costBreakdown = this.calculateRideCost(
      'estimated',
      origin,
      destination,
      estimatedPassengers
    );

    return {
      estimated_cost: costBreakdown.total_cost,
      distance_km: distanceKm,
      cost_breakdown: costBreakdown
    };
  }
}

export default CostService;
