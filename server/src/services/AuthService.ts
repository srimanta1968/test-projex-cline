import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';
import UserModel, { User, CreateUserData } from '../models/User';
import dotenv from 'dotenv';

// Load environment variables
dotenv.config();

export interface LoginCredentials {
  identifier: string; // email or username
  password: string;
}

export interface AuthTokens {
  accessToken: string;
  tokenType: string;
  expiresIn: number;
}

export interface AuthResult {
  user: User;
  tokens: AuthTokens;
}

export interface RegisterData {
  email: string;
  username: string;
  password: string;
  first_name: string;
  last_name: string;
  phone?: string;
}

export class AuthService {
  private static readonly JWT_SECRET: string = process.env.JWT_SECRET || 'fallback-secret-change-in-production';
  private static readonly JWT_EXPIRES_IN: string = process.env.JWT_EXPIRES_IN || '7d';
  private static readonly BCRYPT_ROUNDS = parseInt(process.env.BCRYPT_ROUNDS || '12');

  /**
   * Register a new user
   */
  static async register(userData: RegisterData): Promise<User> {
    const { email, username, password, first_name, last_name, phone } = userData;

    // Validate input
    await this.validateRegistrationData(userData);

    // Check if email or username already exists
    const emailExists = await UserModel.emailExists(email);
    if (emailExists) {
      throw new Error('Email already registered');
    }

    const usernameExists = await UserModel.usernameExists(username);
    if (usernameExists) {
      throw new Error('Username already taken');
    }

    // Hash password
    const passwordHash = await this.hashPassword(password);

    // Create user
    const createData: CreateUserData = {
      email,
      username,
      password_hash: passwordHash,
      first_name,
      last_name
    };

    if (phone) {
      createData.phone = phone;
    }

    try {
      const user = await UserModel.create(createData);
      return user;
    } catch (error) {
      console.error('Error creating user during registration:', error);
      throw new Error('Failed to create user account');
    }
  }

  /**
   * Authenticate user login
   */
  static async login(credentials: LoginCredentials): Promise<AuthResult> {
    const { identifier, password } = credentials;

    // Find user by email or username
    const user = await UserModel.findByEmailOrUsername(identifier);
    if (!user) {
      throw new Error('Invalid credentials');
    }

    // Verify password
    if (!user.password_hash) {
      throw new Error('Invalid credentials');
    }
    const isValidPassword = await this.verifyPassword(password, user.password_hash);
    if (!isValidPassword) {
      throw new Error('Invalid credentials');
    }

    // Generate tokens
    const tokens = this.generateTokens(user);

    return {
      user: this.sanitizeUser(user),
      tokens
    };
  }

  /**
   * Verify JWT token and return user
   */
  static async verifyToken(token: string): Promise<User> {
    try {
      const decoded = jwt.verify(token, this.JWT_SECRET) as jwt.JwtPayload;

      if (!decoded.sub) {
        throw new Error('Invalid token: missing subject');
      }

      const user = await UserModel.findById(decoded.sub);
      if (!user) {
        throw new Error('User not found');
      }

      return this.sanitizeUser(user);
    } catch (error) {
      if (error instanceof jwt.TokenExpiredError) {
        throw new Error('Token expired');
      } else if (error instanceof jwt.JsonWebTokenError) {
        throw new Error('Invalid token');
      }
      throw error;
    }
  }

  /**
   * Refresh access token (if needed in future)
   */
  static async refreshToken(userId: string): Promise<AuthTokens> {
    const user = await UserModel.findById(userId);
    if (!user) {
      throw new Error('User not found');
    }

    return this.generateTokens(user);
  }

  /**
   * Hash password using bcrypt
   */
  private static async hashPassword(password: string): Promise<string> {
    try {
      return await bcrypt.hash(password, this.BCRYPT_ROUNDS);
    } catch (error) {
      console.error('Error hashing password:', error);
      throw new Error('Failed to process password');
    }
  }

  /**
   * Verify password against hash
   */
  private static async verifyPassword(password: string, hash: string): Promise<boolean> {
    try {
      return await bcrypt.compare(password, hash);
    } catch (error) {
      console.error('Error verifying password:', error);
      return false;
    }
  }

  /**
   * Generate JWT tokens
   */
  private static generateTokens(user: User): AuthTokens {
    const payload = {
      sub: user.id,
      email: user.email,
      username: user.username,
      iat: Math.floor(Date.now() / 1000)
    };

    const accessToken = jwt.sign(payload, this.JWT_SECRET, {
      expiresIn: this.JWT_EXPIRES_IN
    } as jwt.SignOptions);

    return {
      accessToken,
      tokenType: 'Bearer',
      expiresIn: this.getExpiresInSeconds()
    };
  }

  /**
   * Get expiration time in seconds
   */
  private static getExpiresInSeconds(): number {
    const expiresIn = this.JWT_EXPIRES_IN;

    if (typeof expiresIn === 'string') {
      const match = expiresIn.match(/^(\d+)([smhd])$/);
      if (match) {
        const value = parseInt(match[1]);
        const unit = match[2];

        switch (unit) {
          case 's': return value;
          case 'm': return value * 60;
          case 'h': return value * 60 * 60;
          case 'd': return value * 60 * 60 * 24;
          default: return 7 * 24 * 60 * 60; // 7 days default
        }
      }
    }

    return 7 * 24 * 60 * 60; // 7 days default
  }

  /**
   * Validate registration data
   */
  private static async validateRegistrationData(data: RegisterData): Promise<void> {
    const { email, username, password, first_name, last_name } = data;

    // Email validation
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(email)) {
      throw new Error('Invalid email format');
    }

    // Username validation
    if (username.length < 3 || username.length > 50) {
      throw new Error('Username must be between 3 and 50 characters');
    }

    const usernameRegex = /^[a-zA-Z0-9_]+$/;
    if (!usernameRegex.test(username)) {
      throw new Error('Username can only contain letters, numbers, and underscores');
    }

    // Password validation
    if (password.length < 8) {
      throw new Error('Password must be at least 8 characters long');
    }

    // Name validation
    if (!first_name.trim() || !last_name.trim()) {
      throw new Error('First name and last name are required');
    }

    if (first_name.length > 100 || last_name.length > 100) {
      throw new Error('Names cannot exceed 100 characters');
    }
  }

  /**
   * Remove sensitive data from user object
   */
  private static sanitizeUser(user: User): User {
    const { password_hash, ...sanitizedUser } = user;
    return sanitizedUser;
  }
}

export default AuthService;
