import RideModel, { Ride, RideWithCreator, CreateRideData, Location } from '../models/Ride';
import UserModel from '../models/User';

export interface CreateRideRequest {
  origin: Location;
  destination: Location;
  seats_available: number;
  price_per_seat: number;
}

export interface JoinRideResponse {
  ride_id: string;
  user_id: string;
  status: string;
  joined_at: string;
  ride: {
    id: string;
    origin: Location;
    destination: Location;
    seats_available: number;
    price_per_seat: number;
    status: string;
  };
}

export class RideService {
  /**
   * Create a new ride
   */
  static async createRide(userId: string, rideData: CreateRideRequest): Promise<Ride> {
    // Validate user exists
    const user = await UserModel.findById(userId);
    if (!user) {
      throw new Error('User not found');
    }

    // Validate ride data
    this.validateRideData(rideData);

    const createData: CreateRideData = {
      creator_id: userId,
      ...rideData
    };

    try {
      const ride = await RideModel.create(createData);
      return ride;
    } catch (error) {
      console.error('Error creating ride:', error);
      throw new Error('Failed to create ride');
    }
  }

  /**
   * Get all rides with optional filtering
   */
  static async getRides(options: {
    status?: 'active' | 'in_progress' | 'completed' | 'cancelled';
    limit?: number;
    offset?: number;
  } = {}): Promise<{ rides: RideWithCreator[]; pagination: { total: number; limit: number; offset: number; has_more: boolean } }> {
    const { limit = 10, offset = 0 } = options;

    try {
      const rides = await RideModel.findAll(options);

      // For now, we'll estimate total count (in production, you'd want a separate count query)
      const hasMore = rides.length === limit;

      return {
        rides,
        pagination: {
          total: rides.length + (hasMore ? 1 : 0), // Rough estimate
          limit,
          offset,
          has_more: hasMore
        }
      };
    } catch (error) {
      console.error('Error getting rides:', error);
      throw new Error('Failed to retrieve rides');
    }
  }

  /**
   * Get ride by ID
   */
  static async getRideById(rideId: string): Promise<Ride | null> {
    try {
      return await RideModel.findById(rideId);
    } catch (error) {
      console.error('Error getting ride by ID:', error);
      throw new Error('Failed to retrieve ride');
    }
  }

  /**
   * Join a ride
   */
  static async joinRide(rideId: string, userId: string): Promise<JoinRideResponse> {
    // Validate ride exists and is active
    const ride = await RideModel.findById(rideId);
    if (!ride) {
      throw new Error('Ride not found');
    }

    if (ride.status !== 'active') {
      throw new Error('Ride is not available for joining');
    }

    // Check if user is the creator
    if (ride.creator_id === userId) {
      throw new Error('Cannot join your own ride');
    }

    // Check if user is already a participant
    const isParticipant = await RideModel.isParticipant(rideId, userId);
    if (isParticipant) {
      throw new Error('Already joined this ride');
    }

    // Check if seats are available
    const participants = await RideModel.getParticipants(rideId);
    const activeParticipants = participants.filter(p => p.status === 'active');

    if (activeParticipants.length >= ride.seats_available) {
      throw new Error('No seats available');
    }

    try {
      // Add participant
      const participant = await RideModel.addParticipant(rideId, userId);

      return {
        ride_id: participant.ride_id,
        user_id: participant.user_id,
        status: participant.status,
        joined_at: participant.joined_at.toISOString(),
        ride: {
          id: ride.id,
          origin: ride.origin,
          destination: ride.destination,
          seats_available: ride.seats_available,
          price_per_seat: ride.price_per_seat,
          status: ride.status
        }
      };
    } catch (error) {
      console.error('Error joining ride:', error);
      throw new Error('Failed to join ride');
    }
  }

  /**
   * Leave a ride
   */
  static async leaveRide(rideId: string, userId: string): Promise<boolean> {
    // Validate ride exists
    const ride = await RideModel.findById(rideId);
    if (!ride) {
      throw new Error('Ride not found');
    }

    // Check if user is a participant
    const isParticipant = await RideModel.isParticipant(rideId, userId);
    if (!isParticipant) {
      throw new Error('Not a participant in this ride');
    }

    try {
      return await RideModel.removeParticipant(rideId, userId);
    } catch (error) {
      console.error('Error leaving ride:', error);
      throw new Error('Failed to leave ride');
    }
  }

  /**
   * Update ride status
   */
  static async updateRideStatus(rideId: string, userId: string, status: Ride['status']): Promise<Ride | null> {
    // Validate ride exists and user is creator
    const ride = await RideModel.findById(rideId);
    if (!ride) {
      throw new Error('Ride not found');
    }

    if (ride.creator_id !== userId) {
      throw new Error('Only ride creator can update status');
    }

    // Validate status transition
    this.validateStatusTransition(ride.status, status);

    try {
      return await RideModel.updateStatus(rideId, status);
    } catch (error) {
      console.error('Error updating ride status:', error);
      throw new Error('Failed to update ride status');
    }
  }

  /**
   * Delete ride
   */
  static async deleteRide(rideId: string, userId: string): Promise<boolean> {
    // Validate ride exists and user is creator
    const ride = await RideModel.findById(rideId);
    if (!ride) {
      throw new Error('Ride not found');
    }

    if (ride.creator_id !== userId) {
      throw new Error('Only ride creator can delete ride');
    }

    if (ride.status !== 'active') {
      throw new Error('Cannot delete ride that is in progress or completed');
    }

    try {
      return await RideModel.delete(rideId);
    } catch (error) {
      console.error('Error deleting ride:', error);
      throw new Error('Failed to delete ride');
    }
  }

  /**
   * Validate ride creation data
   */
  private static validateRideData(data: CreateRideRequest): void {
    const { origin, destination, seats_available, price_per_seat } = data;

    // Validate locations
    this.validateLocation(origin, 'origin');
    this.validateLocation(destination, 'destination');

    // Validate seats
    if (seats_available < 1 || seats_available > 8) {
      throw new Error('Seats available must be between 1 and 8');
    }

    // Validate price
    if (price_per_seat <= 0 || price_per_seat > 1000) {
      throw new Error('Price per seat must be between 0.01 and 1000');
    }

    // Validate locations are different
    if (origin.latitude === destination.latitude && origin.longitude === destination.longitude) {
      throw new Error('Origin and destination cannot be the same location');
    }
  }

  /**
   * Validate location data
   */
  private static validateLocation(location: Location, fieldName: string): void {
    const { latitude, longitude, address } = location;

    if (latitude < -90 || latitude > 90) {
      throw new Error(`${fieldName} latitude must be between -90 and 90`);
    }

    if (longitude < -180 || longitude > 180) {
      throw new Error(`${fieldName} longitude must be between -180 and 180`);
    }

    if (!address || address.trim().length < 10) {
      throw new Error(`${fieldName} address must be at least 10 characters long`);
    }
  }

  /**
   * Validate status transition
   */
  private static validateStatusTransition(currentStatus: Ride['status'], newStatus: Ride['status']): void {
    const validTransitions: Record<Ride['status'], Ride['status'][]> = {
      active: ['in_progress', 'cancelled'],
      in_progress: ['completed', 'cancelled'],
      completed: [], // Cannot change from completed
      cancelled: []  // Cannot change from cancelled
    };

    if (!validTransitions[currentStatus].includes(newStatus)) {
      throw new Error(`Cannot change ride status from ${currentStatus} to ${newStatus}`);
    }
  }
}

export default RideService;
