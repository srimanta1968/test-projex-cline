import { Request, Response, NextFunction } from 'express';
import AuthService from '../services/AuthService';

// Extend Express Request interface to include user
declare global {
  namespace Express {
    interface Request {
      user?: any;
    }
  }
}

/**
 * Middleware to authenticate JWT tokens
 * Adds user object to request if token is valid
 */
export const authenticateToken = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<void> => {
  try {
    // Get token from Authorization header
    const authHeader = req.headers.authorization;
    const token = authHeader && authHeader.startsWith('Bearer ')
      ? authHeader.substring(7)
      : null;

    if (!token) {
      res.status(401).json({
        success: false,
        error: 'Access token required'
      });
      return;
    }

    // Verify token and get user
    const user = await AuthService.verifyToken(token);
    req.user = user;

    next();
  } catch (error) {
    const message = error instanceof Error ? error.message : 'Authentication failed';

    if (message === 'Token expired') {
      res.status(401).json({
        success: false,
        error: 'Token expired'
      });
      return;
    }

    res.status(403).json({
      success: false,
      error: 'Invalid token'
    });
  }
};

/**
 * Optional authentication middleware
 * Adds user to request if token is present and valid, but doesn't fail if missing
 */
export const optionalAuth = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<void> => {
  try {
    const authHeader = req.headers.authorization;
    const token = authHeader && authHeader.startsWith('Bearer ')
      ? authHeader.substring(7)
      : null;

    if (token) {
      const user = await AuthService.verifyToken(token);
      req.user = user;
    }

    next();
  } catch (error) {
    // For optional auth, we don't fail on auth errors
    // Just continue without setting req.user
    next();
  }
};

/**
 * Middleware to check if user is authenticated
 * Requires authenticateToken to be called first
 */
export const requireAuth = (
  req: Request,
  res: Response,
  next: NextFunction
): void => {
  if (!req.user) {
    res.status(401).json({
      success: false,
      error: 'Authentication required'
    });
    return;
  }

  next();
};

/**
 * Middleware to check if user owns the resource or is admin
 * Assumes resource has a userId field
 */
export const requireOwnership = (resourceUserIdField: string = 'user_id') => {
  return (req: Request, res: Response, next: NextFunction): void => {
    if (!req.user) {
      res.status(401).json({
        success: false,
        error: 'Authentication required'
      });
      return;
    }

    const resourceUserId = (req as any)[resourceUserIdField] || req.params[resourceUserIdField];

    if (!resourceUserId || resourceUserId !== req.user.id) {
      res.status(403).json({
        success: false,
        error: 'Access denied: insufficient permissions'
      });
      return;
    }

    next();
  };
};

/**
 * Admin-only middleware (for future use)
 */
export const requireAdmin = (
  req: Request,
  res: Response,
  next: NextFunction
): void => {
  if (!req.user) {
    res.status(401).json({
      success: false,
      error: 'Authentication required'
    });
    return;
  }

  // For now, no admin role - this can be extended later
  // if (!req.user.roles || !req.user.roles.includes('admin')) {
  //   res.status(403).json({
  //     success: false,
  //     error: 'Admin access required'
  //   });
  //   return;
  // }

  // Temporarily allow all authenticated users
  next();
};

export default {
  authenticateToken,
  optionalAuth,
  requireAuth,
  requireOwnership,
  requireAdmin
};
