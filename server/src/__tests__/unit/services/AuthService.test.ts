// Mock environment variables before importing AuthService
process.env.JWT_SECRET = 'test-jwt-secret';
process.env.JWT_EXPIRES_IN = '1h';

import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';
import AuthService from '../../../services/AuthService';
import UserModel from '../../../models/User';

// Mock the dependencies
jest.mock('../../../models/User');
jest.mock('bcryptjs');
jest.mock('jsonwebtoken');

const mockUserModel = UserModel as jest.Mocked<typeof UserModel>;
const mockBcrypt = {
  hash: jest.fn(),
  compare: jest.fn(),
};

// Assign the mock functions to the mocked bcrypt module
(bcrypt as any).hash = mockBcrypt.hash;
(bcrypt as any).compare = mockBcrypt.compare;

const mockJwt = jwt as jest.Mocked<typeof jwt>;

describe('AuthService', () => {
  beforeEach(() => {
    jest.clearAllMocks();
  });

  describe('register', () => {
    it('should register a new user successfully', async () => {
      const userData = {
        email: 'test@example.com',
        username: 'testuser',
        password: 'password123',
        first_name: 'John',
        last_name: 'Doe'
      };

      const hashedPassword = 'hashed-password';
      const createdUser = {
        id: 'user-id',
        email: userData.email,
        username: userData.username,
        password_hash: hashedPassword,
        first_name: userData.first_name,
        last_name: userData.last_name,
        verified: false,
        created_at: new Date(),
        updated_at: new Date()
      };

      // Mock the checks
      mockUserModel.emailExists.mockResolvedValue(false);
      mockUserModel.usernameExists.mockResolvedValue(false);
      mockBcrypt.hash.mockResolvedValue(hashedPassword);
      mockUserModel.create.mockResolvedValue(createdUser);

      const result = await AuthService.register(userData);

      expect(mockUserModel.emailExists).toHaveBeenCalledWith(userData.email);
      expect(mockUserModel.usernameExists).toHaveBeenCalledWith(userData.username);
      expect(mockBcrypt.hash).toHaveBeenCalledWith(userData.password, 12);
      expect(mockUserModel.create).toHaveBeenCalledWith({
        email: userData.email,
        username: userData.username,
        password_hash: hashedPassword,
        first_name: userData.first_name,
        last_name: userData.last_name,
        phone: undefined
      });
      expect(result).toEqual(createdUser);
    });

    it('should throw error if email already exists', async () => {
      const userData = {
        email: 'existing@example.com',
        username: 'testuser',
        password: 'password123',
        first_name: 'John',
        last_name: 'Doe'
      };

      mockUserModel.emailExists.mockResolvedValue(true);

      await expect(AuthService.register(userData)).rejects.toThrow('Email already registered');
    });

    it('should throw error if username already exists', async () => {
      const userData = {
        email: 'test@example.com',
        username: 'existinguser',
        password: 'password123',
        first_name: 'John',
        last_name: 'Doe'
      };

      mockUserModel.emailExists.mockResolvedValue(false);
      mockUserModel.usernameExists.mockResolvedValue(true);

      await expect(AuthService.register(userData)).rejects.toThrow('Username already taken');
    });
  });

  describe('login', () => {
    it('should login user successfully', async () => {
      const credentials = {
        identifier: 'test@example.com',
        password: 'password123'
      };

      const user = {
        id: 'user-id',
        email: credentials.identifier,
        username: 'testuser',
        password_hash: 'hashed-password',
        first_name: 'John',
        last_name: 'Doe',
        verified: false,
        created_at: new Date(),
        updated_at: new Date()
      };

      const tokens = {
        accessToken: 'jwt-token',
        tokenType: 'Bearer',
        expiresIn: 3600
      };

      mockUserModel.findByEmailOrUsername.mockResolvedValue(user);
      mockBcrypt.compare.mockResolvedValue(true);
      mockJwt.sign.mockReturnValue('jwt-token' as any);

      const result = await AuthService.login(credentials);

      expect(mockUserModel.findByEmailOrUsername).toHaveBeenCalledWith(credentials.identifier);
      expect(mockBcrypt.compare).toHaveBeenCalledWith(credentials.password, user.password_hash);
      expect(result.user).toEqual({
        id: user.id,
        email: user.email,
        username: user.username,
        first_name: user.first_name,
        last_name: user.last_name,
        verified: user.verified,
        created_at: user.created_at,
        updated_at: user.updated_at
      });
      expect(result.tokens).toEqual(tokens);
    });

    it('should throw error for invalid credentials', async () => {
      const credentials = {
        identifier: 'invalid@example.com',
        password: 'wrongpassword'
      };

      mockUserModel.findByEmailOrUsername.mockResolvedValue(null);

      await expect(AuthService.login(credentials)).rejects.toThrow('Invalid credentials');
    });

    it('should throw error for wrong password', async () => {
      const credentials = {
        identifier: 'test@example.com',
        password: 'wrongpassword'
      };

      const user = {
        id: 'user-id',
        email: credentials.identifier,
        username: 'testuser',
        password_hash: 'hashed-password'
      };

      mockUserModel.findByEmailOrUsername.mockResolvedValue(user as any);
      mockBcrypt.compare.mockResolvedValue(false);

      await expect(AuthService.login(credentials)).rejects.toThrow('Invalid credentials');
    });
  });

  describe('verifyToken', () => {
    it('should verify token successfully', async () => {
      const token = 'valid-jwt-token';
      const decoded = { sub: 'user-id', email: 'test@example.com' };
      const user = {
        id: 'user-id',
        email: 'test@example.com',
        username: 'testuser',
        first_name: 'John',
        last_name: 'Doe',
        verified: false,
        created_at: new Date(),
        updated_at: new Date()
      };

      mockJwt.verify.mockReturnValue(decoded as any);
      mockUserModel.findById.mockResolvedValue(user);

      const result = await AuthService.verifyToken(token);

      expect(mockJwt.verify).toHaveBeenCalledWith(token, 'test-jwt-secret');
      expect(mockUserModel.findById).toHaveBeenCalledWith('user-id');
      expect(result).toEqual({
        id: user.id,
        email: user.email,
        username: user.username,
        first_name: user.first_name,
        last_name: user.last_name,
        verified: user.verified,
        created_at: user.created_at,
        updated_at: user.updated_at
      });
    });

    it('should throw error for invalid token', async () => {
      const token = 'invalid-token';

      mockJwt.verify.mockImplementation(() => {
        throw new jwt.JsonWebTokenError('Invalid token');
      });

      await expect(AuthService.verifyToken(token)).rejects.toThrow('Invalid token');
    });

    it('should throw error for expired token', async () => {
      const token = 'expired-token';

      mockJwt.verify.mockImplementation(() => {
        throw new jwt.TokenExpiredError('Token expired', new Date());
      });

      await expect(AuthService.verifyToken(token)).rejects.toThrow('Token expired');
    });
  });
});
