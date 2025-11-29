import { Router, Request, Response } from 'express';
import { body } from 'express-validator';
import { AuthService } from '../services/AuthService';
import { authenticateToken } from '../middleware/authMiddleware';

const router = Router();

// Validation middleware
const registerValidation = [
  body('email').isEmail().normalizeEmail(),
  body('username').isLength({ min: 3, max: 50 }).matches(/^[a-zA-Z0-9_]+$/),
  body('password').isLength({ min: 8 }),
  body('first_name').notEmpty().trim().isLength({ min: 1, max: 50 }),
  body('last_name').notEmpty().trim().isLength({ min: 1, max: 50 })
];

const loginValidation = [
  body('email').isEmail().normalizeEmail(),
  body('password').notEmpty()
];

/**
 * POST /api/auth/register
 * Register a new user
 */
router.post('/register', registerValidation, async (req: Request, res: Response) => {
  try {
    const userData = req.body;

    // Additional validation
    if (!AuthService.validateEmail(userData.email)) {
      return res.status(400).json({
        success: false,
        message: 'Invalid email format'
      });
    }

    const passwordValidation = AuthService.validatePassword(userData.password);
    if (!passwordValidation.isValid) {
      return res.status(400).json({
        success: false,
        message: passwordValidation.message
      });
    }

    const result = await AuthService.register(userData);

    res.status(201).json({
      success: true,
      message: 'User registered successfully',
      data: result
    });
  } catch (error: any) {
    console.error('Registration error:', error);

    if (error.message.includes('already exists') || error.message.includes('taken')) {
      return res.status(409).json({
        success: false,
        message: error.message
      });
    }

    res.status(500).json({
      success: false,
      message: 'Registration failed'
    });
  }
  return;
});

/**
 * POST /api/auth/login
 * Login user
 */
router.post('/login', loginValidation, async (req: Request, res: Response) => {
  try {
    const loginData = req.body;

    const result = await AuthService.login(loginData);

    res.json({
      success: true,
      message: 'Login successful',
      data: result
    });
  } catch (error: any) {
    console.error('Login error:', error);

    if (error.message.includes('Invalid email or password')) {
      return res.status(401).json({
        success: false,
        message: 'Invalid email or password'
      });
    }

    res.status(500).json({
      success: false,
      message: 'Login failed'
    });
  }
  return;
});

/**
 * GET /api/auth/me
 * Get current user profile (protected route)
 */
router.get('/me', authenticateToken, async (req: Request, res: Response) => {
  try {
    if (!req.user?.id) {
      return res.status(401).json({
        success: false,
        message: 'User not authenticated'
      });
    }

    const user = await AuthService.getProfile(req.user.id);

    res.json({
      success: true,
      data: user
    });
  } catch (error: any) {
    console.error('Get profile error:', error);

    if (error.message.includes('User not found')) {
      return res.status(404).json({
        success: false,
        message: 'User not found'
      });
    }

    res.status(500).json({
      success: false,
      message: 'Failed to get user profile'
    });
  }
  return;
});

export default router;
