import pool from '../config/database';

export interface User {
  id: string;
  email: string;
  username: string;
  password_hash: string;
  first_name: string;
  last_name: string;
  created_at: Date;
  updated_at: Date;
}

export interface CreateUserData {
  email: string;
  username: string;
  password_hash: string;
  first_name: string;
  last_name: string;
}

export interface UpdateUserData {
  first_name?: string;
  last_name?: string;
  email?: string;
}

export class UserModel {
  /**
   * Create a new user
   */
  static async create(userData: CreateUserData): Promise<User> {
    const query = `
      INSERT INTO users (email, username, password_hash, first_name, last_name)
      VALUES ($1, $2, $3, $4, $5)
      RETURNING id, email, username, first_name, last_name, created_at, updated_at
    `;

    const values = [
      userData.email,
      userData.username,
      userData.password_hash,
      userData.first_name,
      userData.last_name
    ];

    try {
      const result = await pool.query(query, values);
      return result.rows[0];
    } catch (error) {
      console.error('Error creating user:', error);
      throw new Error('Failed to create user');
    }
  }

  /**
   * Find user by email
   */
  static async findByEmail(email: string): Promise<User | null> {
    const query = `
      SELECT id, email, username, password_hash, first_name, last_name, created_at, updated_at
      FROM users
      WHERE email = $1
    `;

    try {
      const result = await pool.query(query, [email]);
      return result.rows[0] || null;
    } catch (error) {
      console.error('Error finding user by email:', error);
      throw new Error('Failed to find user');
    }
  }

  /**
   * Find user by ID
   */
  static async findById(id: string): Promise<User | null> {
    const query = `
      SELECT id, email, username, password_hash, first_name, last_name, created_at, updated_at
      FROM users
      WHERE id = $1
    `;

    try {
      const result = await pool.query(query, [id]);
      return result.rows[0] || null;
    } catch (error) {
      console.error('Error finding user by ID:', error);
      throw new Error('Failed to find user');
    }
  }

  /**
   * Find user by username
   */
  static async findByUsername(username: string): Promise<User | null> {
    const query = `
      SELECT id, email, username, password_hash, first_name, last_name, created_at, updated_at
      FROM users
      WHERE username = $1
    `;

    try {
      const result = await pool.query(query, [username]);
      return result.rows[0] || null;
    } catch (error) {
      console.error('Error finding user by username:', error);
      throw new Error('Failed to find user');
    }
  }

  /**
   * Update user information
   */
  static async update(id: string, updateData: UpdateUserData): Promise<User | null> {
    const fields = [];
    const values = [];
    let paramIndex = 1;

    if (updateData.first_name !== undefined) {
      fields.push(`first_name = $${paramIndex++}`);
      values.push(updateData.first_name);
    }

    if (updateData.last_name !== undefined) {
      fields.push(`last_name = $${paramIndex++}`);
      values.push(updateData.last_name);
    }

    if (updateData.email !== undefined) {
      fields.push(`email = $${paramIndex++}`);
      values.push(updateData.email);
    }

    if (fields.length === 0) {
      throw new Error('No fields to update');
    }

    fields.push(`updated_at = NOW()`);
    values.push(id); // Add id at the end

    const query = `
      UPDATE users
      SET ${fields.join(', ')}
      WHERE id = $${paramIndex}
      RETURNING id, email, username, first_name, last_name, created_at, updated_at
    `;

    try {
      const result = await pool.query(query, values);
      return result.rows[0] || null;
    } catch (error) {
      console.error('Error updating user:', error);
      throw new Error('Failed to update user');
    }
  }

  /**
   * Delete user
   */
  static async delete(id: string): Promise<boolean> {
    const query = 'DELETE FROM users WHERE id = $1';

    try {
      const result = await pool.query(query, [id]);
      return (result.rowCount ?? 0) > 0;
    } catch (error) {
      console.error('Error deleting user:', error);
      throw new Error('Failed to delete user');
    }
  }
}
