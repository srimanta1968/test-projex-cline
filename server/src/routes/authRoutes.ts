import { Router, Request, Response, NextFunction } from 'express';
import { body, validationResult } from 'express-validator';
import AuthService, { RegisterData, LoginCredentials } from '../services/AuthService';
import { authenticateToken } from '../middleware/authMiddleware';

const router = Router();

// Input validation middleware
const registerValidation = [
  body('email')
    .isEmail()
    .normalizeEmail()
    .withMessage('Please provide a valid email address'),
  body('username')
    .isLength({ min: 3, max: 50 })
    .matches(/^[a-zA-Z0-9_]+$/)
    .withMessage('Username must be 3-50 characters and contain only letters, numbers, and underscores'),
  body('password')
    .isLength({ min: 8 })
    .withMessage('Password must be at least 8 characters long'),
  body('first_name')
    .trim()
    .isLength({ min: 1, max: 100 })
    .withMessage('First name is required and must be less than 100 characters'),
  body('last_name')
    .trim()
    .isLength({ min: 1, max: 100 })
    .withMessage('Last name is required and must be less than 100 characters'),
  body('phone')
    .optional()
    .isMobilePhone('any')
    .withMessage('Please provide a valid phone number')
];

const loginValidation = [
  body('identifier')
    .notEmpty()
    .withMessage('Email or username is required'),
  body('password')
    .notEmpty()
    .withMessage('Password is required')
];

// Middleware to handle validation errors
const handleValidationErrors = (req: any, res: any, next: any) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({
      success: false,
      error: 'Validation failed',
      details: errors.array()
    });
  }
  next();
};

/**
 * POST /api/auth/register
 * Register a new user
 */
router.post('/register', registerValidation, handleValidationErrors, async (req, res) => {
  try {
    const userData: RegisterData = {
      email: req.body.email,
      username: req.body.username,
      password: req.body.password,
      first_name: req.body.first_name,
      last_name: req.body.last_name,
      phone: req.body.phone
    };

    const user = await AuthService.register(userData);

    res.status(201).json({
      success: true,
      message: 'User registered successfully',
      data: {
        id: user.id,
        email: user.email,
        username: user.username,
        first_name: user.first_name,
        last_name: user.last_name,
        verified: user.verified,
        created_at: user.created_at
      }
    });
  } catch (error) {
    const message = error instanceof Error ? error.message : 'Registration failed';

    // Handle specific error cases
    if (message === 'Email already registered' || message === 'Username already taken') {
      return res.status(409).json({
        success: false,
        error: message
      });
    }

    console.error('Registration error:', error);
    res.status(500).json({
      success: false,
      error: 'Internal server error'
    });
  }
});

/**
 * POST /api/auth/login
 * Authenticate user and return tokens
 */
router.post('/login', loginValidation, handleValidationErrors, async (req, res) => {
  try {
    const credentials: LoginCredentials = {
      identifier: req.body.identifier,
      password: req.body.password
    };

    const authResult = await AuthService.login(credentials);

    res.status(200).json({
      success: true,
      message: 'Login successful',
      data: authResult
    });
  } catch (error) {
    const message = error instanceof Error ? error.message : 'Login failed';

    if (message === 'Invalid credentials') {
      return res.status(401).json({
        success: false,
        error: 'Invalid email/username or password'
      });
    }

    console.error('Login error:', error);
    res.status(500).json({
      success: false,
      error: 'Internal server error'
    });
  }
});

/**
 * GET /api/auth/me
 * Get current user profile (requires authentication)
 */
router.get('/me', authenticateToken, async (req, res) => {
  try {
    // User is already attached to req by authenticateToken middleware
    const user = req.user;

    res.status(200).json({
      success: true,
      data: user
    });
  } catch (error) {
    console.error('Get profile error:', error);
    res.status(500).json({
      success: false,
      error: 'Internal server error'
    });
  }
});

/**
 * POST /api/auth/refresh
 * Refresh access token (future implementation)
 */
router.post('/refresh', async (req, res) => {
  // For now, return not implemented
  // In a full implementation, this would validate refresh tokens
  res.status(501).json({
    success: false,
    error: 'Token refresh not implemented'
  });
});

/**
 * POST /api/auth/logout
 * Logout user (client-side token removal)
 */
router.post('/logout', (req, res) => {
  // Since we're using JWT, logout is handled client-side
  // In a future implementation with refresh tokens, we might blacklist tokens
  res.status(200).json({
    success: true,
    message: 'Logged out successfully'
  });
});

export default router;
