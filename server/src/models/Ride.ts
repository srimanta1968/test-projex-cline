import { v4 as uuidv4 } from 'uuid';
import pool from '../config/database';

export interface Location {
  latitude: number;
  longitude: number;
  address: string;
}

export interface CreateRideData {
  creator_id: string;
  origin: Location;
  destination: Location;
  seats_available: number;
  price_per_seat: number;
}

export interface Ride {
  id: string;
  creator_id: string;
  origin: Location;
  destination: Location;
  seats_available: number;
  price_per_seat: number;
  status: 'active' | 'in_progress' | 'completed' | 'cancelled';
  created_at: Date;
  updated_at: Date;
}

export interface RideWithCreator extends Ride {
  creator: {
    id: string;
    first_name: string;
    last_name: string;
    verified: boolean;
  };
}

export interface RideParticipant {
  id: string;
  ride_id: string;
  user_id: string;
  joined_at: Date;
  status: 'active' | 'left' | 'removed';
}

export class RideModel {
  /**
   * Create a new ride
   */
  static async create(rideData: CreateRideData): Promise<Ride> {
    const { creator_id, origin, destination, seats_available, price_per_seat } = rideData;
    const id = uuidv4();
    const now = new Date();

    const query = `
      INSERT INTO rides (
        id, creator_id,
        origin_lat, origin_lng, origin_address,
        destination_lat, destination_lng, destination_address,
        seats_available, price_per_seat, status, created_at, updated_at
      )
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, 'active', $11, $12)
      RETURNING *
    `;

    const values = [
      id,
      creator_id,
      origin.latitude,
      origin.longitude,
      origin.address,
      destination.latitude,
      destination.longitude,
      destination.address,
      seats_available,
      price_per_seat,
      now,
      now
    ];

    try {
      const result = await pool.query(query, values);
      return this.mapRowToRide(result.rows[0]);
    } catch (error) {
      console.error('Error creating ride:', error);
      throw error;
    }
  }

  /**
   * Find ride by ID
   */
  static async findById(id: string): Promise<Ride | null> {
    const query = 'SELECT * FROM rides WHERE id = $1';

    try {
      const result = await pool.query(query, [id]);
      return result.rows[0] ? this.mapRowToRide(result.rows[0]) : null;
    } catch (error) {
      console.error('Error finding ride by ID:', error);
      throw error;
    }
  }

  /**
   * Get all rides with optional filtering
   */
  static async findAll(options: {
    status?: string;
    limit?: number;
    offset?: number;
  } = {}): Promise<RideWithCreator[]> {
    const { status, limit = 50, offset = 0 } = options;

    let whereClause = '';
    const values: any[] = [];
    let paramCount = 1;

    if (status) {
      whereClause = `WHERE status = $${paramCount++}`;
      values.push(status);
    }

    const query = `
      SELECT
        r.*,
        u.id as creator_id,
        u.first_name,
        u.last_name,
        u.verified
      FROM rides r
      JOIN users u ON r.creator_id = u.id
      ${whereClause}
      ORDER BY r.created_at DESC
      LIMIT $${paramCount++} OFFSET $${paramCount++}
    `;

    values.push(limit, offset);

    try {
      const result = await pool.query(query, values);
      return result.rows.map(row => this.mapRowToRideWithCreator(row));
    } catch (error) {
      console.error('Error finding rides:', error);
      throw error;
    }
  }

  /**
   * Update ride status
   */
  static async updateStatus(id: string, status: Ride['status']): Promise<Ride | null> {
    const query = `
      UPDATE rides
      SET status = $1, updated_at = CURRENT_TIMESTAMP
      WHERE id = $2
      RETURNING *
    `;

    try {
      const result = await pool.query(query, [status, id]);
      return result.rows[0] ? this.mapRowToRide(result.rows[0]) : null;
    } catch (error) {
      console.error('Error updating ride status:', error);
      throw error;
    }
  }

  /**
   * Delete ride
   */
  static async delete(id: string): Promise<boolean> {
    const query = 'DELETE FROM rides WHERE id = $1 RETURNING id';

    try {
      const result = await pool.query(query, [id]);
      return (result.rowCount || 0) > 0;
    } catch (error) {
      console.error('Error deleting ride:', error);
      throw error;
    }
  }

  /**
   * Add participant to ride
   */
  static async addParticipant(rideId: string, userId: string): Promise<RideParticipant> {
    const id = uuidv4();
    const now = new Date();

    const query = `
      INSERT INTO ride_participants (id, ride_id, user_id, joined_at, status)
      VALUES ($1, $2, $3, $4, 'active')
      RETURNING *
    `;

    const values = [id, rideId, userId, now];

    try {
      const result = await pool.query(query, values);
      return this.mapRowToParticipant(result.rows[0]);
    } catch (error) {
      console.error('Error adding ride participant:', error);
      throw error;
    }
  }

  /**
   * Get ride participants
   */
  static async getParticipants(rideId: string): Promise<RideParticipant[]> {
    const query = 'SELECT * FROM ride_participants WHERE ride_id = $1 ORDER BY joined_at ASC';

    try {
      const result = await pool.query(query, [rideId]);
      return result.rows.map(row => this.mapRowToParticipant(row));
    } catch (error) {
      console.error('Error getting ride participants:', error);
      throw error;
    }
  }

  /**
   * Check if user is participant in ride
   */
  static async isParticipant(rideId: string, userId: string): Promise<boolean> {
    const query = 'SELECT id FROM ride_participants WHERE ride_id = $1 AND user_id = $2 AND status = \'active\' LIMIT 1';

    try {
      const result = await pool.query(query, [rideId, userId]);
      return result.rows.length > 0;
    } catch (error) {
      console.error('Error checking ride participation:', error);
      throw error;
    }
  }

  /**
   * Remove participant from ride
   */
  static async removeParticipant(rideId: string, userId: string): Promise<boolean> {
    const query = `
      UPDATE ride_participants
      SET status = 'left', joined_at = CURRENT_TIMESTAMP
      WHERE ride_id = $1 AND user_id = $2 AND status = 'active'
      RETURNING id
    `;

    try {
      const result = await pool.query(query, [rideId, userId]);
      return (result.rowCount || 0) > 0;
    } catch (error) {
      console.error('Error removing ride participant:', error);
      throw error;
    }
  }

  /**
   * Helper method to map database row to Ride interface
   */
  private static mapRowToRide(row: any): Ride {
    return {
      id: row.id,
      creator_id: row.creator_id,
      origin: {
        latitude: parseFloat(row.origin_lat),
        longitude: parseFloat(row.origin_lng),
        address: row.origin_address
      },
      destination: {
        latitude: parseFloat(row.destination_lat),
        longitude: parseFloat(row.destination_lng),
        address: row.destination_address
      },
      seats_available: row.seats_available,
      price_per_seat: parseFloat(row.price_per_seat),
      status: row.status,
      created_at: row.created_at,
      updated_at: row.updated_at
    };
  }

  /**
   * Helper method to map database row to RideWithCreator interface
   */
  private static mapRowToRideWithCreator(row: any): RideWithCreator {
    return {
      ...this.mapRowToRide(row),
      creator: {
        id: row.creator_id,
        first_name: row.first_name,
        last_name: row.last_name,
        verified: row.verified
      }
    };
  }

  /**
   * Helper method to map database row to RideParticipant interface
   */
  private static mapRowToParticipant(row: any): RideParticipant {
    return {
      id: row.id,
      ride_id: row.ride_id,
      user_id: row.user_id,
      joined_at: row.joined_at,
      status: row.status
    };
  }
}

export default RideModel;
