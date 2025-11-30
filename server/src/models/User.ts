import { v4 as uuidv4 } from 'uuid';
import pool from '../config/database';

export interface User {
  id: string;
  email: string;
  username: string;
  password_hash?: string; // Made optional for sanitized responses
  first_name: string;
  last_name: string;
  phone?: string;
  verified: boolean;
  created_at: Date;
  updated_at: Date;
}

export interface CreateUserData {
  email: string;
  username: string;
  password_hash: string;
  first_name: string;
  last_name: string;
  phone?: string;
}

export interface UpdateUserData {
  first_name?: string;
  last_name?: string;
  phone?: string;
  verified?: boolean;
}

export class UserModel {
  /**
   * Create a new user
   */
  static async create(userData: CreateUserData): Promise<User> {
    const { email, username, password_hash, first_name, last_name, phone } = userData;
    const id = uuidv4();
    const now = new Date();

    const query = `
      INSERT INTO users (id, email, username, password_hash, first_name, last_name, phone, verified, created_at, updated_at)
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)
      RETURNING *
    `;

    const values = [
      id,
      email.toLowerCase(),
      username.toLowerCase(),
      password_hash,
      first_name,
      last_name,
      phone || null,
      false, // verified defaults to false
      now,
      now
    ];

    try {
      const result = await pool.query(query, values);
      return result.rows[0];
    } catch (error) {
      console.error('Error creating user:', error);
      throw error;
    }
  }

  /**
   * Find user by ID
   */
  static async findById(id: string): Promise<User | null> {
    const query = 'SELECT * FROM users WHERE id = $1';

    try {
      const result = await pool.query(query, [id]);
      return result.rows[0] || null;
    } catch (error) {
      console.error('Error finding user by ID:', error);
      throw error;
    }
  }

  /**
   * Find user by email
   */
  static async findByEmail(email: string): Promise<User | null> {
    const query = 'SELECT * FROM users WHERE email = $1';

    try {
      const result = await pool.query(query, [email.toLowerCase()]);
      return result.rows[0] || null;
    } catch (error) {
      console.error('Error finding user by email:', error);
      throw error;
    }
  }

  /**
   * Find user by username
   */
  static async findByUsername(username: string): Promise<User | null> {
    const query = 'SELECT * FROM users WHERE username = $1';

    try {
      const result = await pool.query(query, [username.toLowerCase()]);
      return result.rows[0] || null;
    } catch (error) {
      console.error('Error finding user by username:', error);
      throw error;
    }
  }

  /**
   * Find user by email or username (for login)
   */
  static async findByEmailOrUsername(identifier: string): Promise<User | null> {
    const query = 'SELECT * FROM users WHERE email = $1 OR username = $1';

    try {
      const result = await pool.query(query, [identifier.toLowerCase()]);
      return result.rows[0] || null;
    } catch (error) {
      console.error('Error finding user by email or username:', error);
      throw error;
    }
  }

  /**
   * Update user information
   */
  static async update(id: string, updateData: UpdateUserData): Promise<User | null> {
    const { first_name, last_name, phone, verified } = updateData;
    const now = new Date();

    const updateFields: string[] = [];
    const values: any[] = [];
    let paramCount = 1;

    if (first_name !== undefined) {
      updateFields.push(`first_name = $${paramCount++}`);
      values.push(first_name);
    }

    if (last_name !== undefined) {
      updateFields.push(`last_name = $${paramCount++}`);
      values.push(last_name);
    }

    if (phone !== undefined) {
      updateFields.push(`phone = $${paramCount++}`);
      values.push(phone);
    }

    if (verified !== undefined) {
      updateFields.push(`verified = $${paramCount++}`);
      values.push(verified);
    }

    if (updateFields.length === 0) {
      throw new Error('No fields to update');
    }

    updateFields.push(`updated_at = $${paramCount++}`);
    values.push(now);

    values.push(id); // WHERE clause

    const query = `
      UPDATE users
      SET ${updateFields.join(', ')}
      WHERE id = $${paramCount}
      RETURNING *
    `;

    try {
      const result = await pool.query(query, values);
      return result.rows[0] || null;
    } catch (error) {
      console.error('Error updating user:', error);
      throw error;
    }
  }

  /**
   * Delete user
   */
  static async delete(id: string): Promise<boolean> {
    const query = 'DELETE FROM users WHERE id = $1 RETURNING id';

    try {
      const result = await pool.query(query, [id]);
      return (result.rowCount || 0) > 0;
    } catch (error) {
      console.error('Error deleting user:', error);
      throw error;
    }
  }

  /**
   * Get all users (with pagination)
   */
  static async findAll(limit: number = 50, offset: number = 0): Promise<User[]> {
    const query = 'SELECT * FROM users ORDER BY created_at DESC LIMIT $1 OFFSET $2';

    try {
      const result = await pool.query(query, [limit, offset]);
      return result.rows;
    } catch (error) {
      console.error('Error finding all users:', error);
      throw error;
    }
  }

  /**
   * Check if email exists
   */
  static async emailExists(email: string): Promise<boolean> {
    const query = 'SELECT id FROM users WHERE email = $1 LIMIT 1';

    try {
      const result = await pool.query(query, [email.toLowerCase()]);
      return result.rows.length > 0;
    } catch (error) {
      console.error('Error checking email existence:', error);
      throw error;
    }
  }

  /**
   * Check if username exists
   */
  static async usernameExists(username: string): Promise<boolean> {
    const query = 'SELECT id FROM users WHERE username = $1 LIMIT 1';

    try {
      const result = await pool.query(query, [username.toLowerCase()]);
      return result.rows.length > 0;
    } catch (error) {
      console.error('Error checking username existence:', error);
      throw error;
    }
  }
}

export default UserModel;
