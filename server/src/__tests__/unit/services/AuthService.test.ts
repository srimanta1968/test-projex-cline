import { AuthService } from '../../../services/AuthService';

// Mock the UserModel
jest.mock('../../../models/User', () => ({
  UserModel: {
    findByEmail: jest.fn(),
    findByUsername: jest.fn(),
    create: jest.fn(),
  },
}));

const mockUserModel = require('../../../models/User').UserModel;

describe('AuthService', () => {
  beforeEach(() => {
    jest.clearAllMocks();
  });

  describe('validateEmail', () => {
    it('should return true for valid email', () => {
      expect(AuthService.validateEmail('user@example.com')).toBe(true);
      expect(AuthService.validateEmail('test.email+tag@domain.co.uk')).toBe(true);
    });

    it('should return false for invalid email', () => {
      expect(AuthService.validateEmail('invalid-email')).toBe(false);
      expect(AuthService.validateEmail('@domain.com')).toBe(false);
      expect(AuthService.validateEmail('user@')).toBe(false);
    });
  });

  describe('validatePassword', () => {
    it('should return valid for strong password', () => {
      const result = AuthService.validatePassword('SecurePass123!');
      expect(result.isValid).toBe(true);
    });

    it('should return invalid for password too short', () => {
      const result = AuthService.validatePassword('Short1!');
      expect(result.isValid).toBe(false);
      expect(result.message).toContain('at least 8 characters');
    });

    it('should return invalid for password without uppercase', () => {
      const result = AuthService.validatePassword('securepass123!');
      expect(result.isValid).toBe(false);
      expect(result.message).toContain('uppercase letter');
    });

    it('should return invalid for password without lowercase', () => {
      const result = AuthService.validatePassword('SECUREPASS123!');
      expect(result.isValid).toBe(false);
      expect(result.message).toContain('lowercase letter');
    });

    it('should return invalid for password without number', () => {
      const result = AuthService.validatePassword('SecurePass!');
      expect(result.isValid).toBe(false);
      expect(result.message).toContain('number');
    });
  });

  describe('verifyToken', () => {
    it('should verify valid token', () => {
      const userId = 'test-user-id';
      const token = AuthService['generateToken'](userId);
      const decodedUserId = AuthService.verifyToken(token);
      expect(decodedUserId).toBe(userId);
    });

    it('should throw error for invalid token', () => {
      expect(() => {
        AuthService.verifyToken('invalid-token');
      }).toThrow('Invalid or expired token');
    });
  });
});
