import { Router, Request, Response, NextFunction } from 'express';
import { body, query, param, validationResult } from 'express-validator';
import RideService from '../services/RideService';
import CostService from '../services/CostService';
import PaymentService from '../services/PaymentService';
import RideModel from '../models/Ride';
import { authenticateToken } from '../middleware/authMiddleware';

const router = Router();

// Input validation middleware
const createRideValidation = [
  body('origin.latitude')
    .isFloat({ min: -90, max: 90 })
    .withMessage('Origin latitude must be between -90 and 90'),
  body('origin.longitude')
    .isFloat({ min: -180, max: 180 })
    .withMessage('Origin longitude must be between -180 and 180'),
  body('origin.address')
    .trim()
    .isLength({ min: 10, max: 255 })
    .withMessage('Origin address must be between 10 and 255 characters'),
  body('destination.latitude')
    .isFloat({ min: -90, max: 90 })
    .withMessage('Destination latitude must be between -90 and 90'),
  body('destination.longitude')
    .isFloat({ min: -180, max: 180 })
    .withMessage('Destination longitude must be between -180 and 180'),
  body('destination.address')
    .trim()
    .isLength({ min: 10, max: 255 })
    .withMessage('Destination address must be between 10 and 255 characters'),
  body('seats_available')
    .isInt({ min: 1, max: 8 })
    .withMessage('Seats available must be between 1 and 8'),
  body('price_per_seat')
    .isFloat({ min: 0.01, max: 1000 })
    .withMessage('Price per seat must be between 0.01 and 1000')
];

const getRidesValidation = [
  query('status')
    .optional()
    .isIn(['active', 'in_progress', 'completed', 'cancelled'])
    .withMessage('Status must be one of: active, in_progress, completed, cancelled'),
  query('limit')
    .optional()
    .isInt({ min: 1, max: 100 })
    .withMessage('Limit must be between 1 and 100'),
  query('offset')
    .optional()
    .isInt({ min: 0 })
    .withMessage('Offset must be non-negative')
];

const joinRideValidation = [
  param('id')
    .isUUID()
    .withMessage('Ride ID must be a valid UUID')
];

interface AuthenticatedRequest extends Request {
  user: {
    id: string;
    email: string;
    username: string;
  };
}

// Middleware to handle validation errors
const handleValidationErrors = (req: Request, res: Response, next: NextFunction) => {
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
 * POST /api/rides
 * Create a new ride (requires authentication)
 */
router.post('/', authenticateToken, createRideValidation, handleValidationErrors, async (req: Request, res: Response) => {
  try {
    const userId = (req as any).user.id;
    const rideData = req.body;

    const ride = await RideService.createRide(userId, rideData);

    res.status(201).json({
      success: true,
      message: 'Ride created successfully',
      data: {
        id: ride.id,
        creator_id: ride.creator_id,
        origin: ride.origin,
        destination: ride.destination,
        seats_available: ride.seats_available,
        price_per_seat: ride.price_per_seat,
        status: ride.status,
        created_at: ride.created_at,
        updated_at: ride.updated_at
      }
    });
  } catch (error) {
    const message = error instanceof Error ? error.message : 'Ride creation failed';

    // Handle specific error cases
    if (message.includes('not found') || message.includes('must be') || message.includes('cannot be')) {
      return res.status(400).json({
        success: false,
        error: message
      });
    }

    console.error('Ride creation error:', error);
    res.status(500).json({
      success: false,
      error: 'Internal server error'
    });
  }
});

/**
 * GET /api/rides
 * Get list of rides (public access)
 */
router.get('/', getRidesValidation, handleValidationErrors, async (req: Request, res: Response) => {
  try {
    const options = {
      status: req.query.status as 'active' | 'in_progress' | 'completed' | 'cancelled',
      limit: req.query.limit ? parseInt(req.query.limit as string) : 10,
      offset: req.query.offset ? parseInt(req.query.offset as string) : 0
    };

    const result = await RideService.getRides(options);

    res.status(200).json({
      success: true,
      data: result.rides.map(ride => ({
        id: ride.id,
        creator_id: ride.creator_id,
        origin: ride.origin,
        destination: ride.destination,
        seats_available: ride.seats_available,
        price_per_seat: ride.price_per_seat,
        status: ride.status,
        created_at: ride.created_at,
        updated_at: ride.updated_at,
        creator: ride.creator
      })),
      pagination: result.pagination
    });
  } catch (error) {
    console.error('Get rides error:', error);
    res.status(500).json({
      success: false,
      error: 'Internal server error'
    });
  }
});

/**
 * POST /api/rides/:id/join
 * Join a ride (requires authentication)
 */
router.post('/:id/join', authenticateToken, joinRideValidation, handleValidationErrors, async (req: Request, res: Response) => {
  try {
    const rideId = req.params.id;
    const userId = (req as any).user.id;

    const result = await RideService.joinRide(rideId, userId);

    res.status(200).json({
      success: true,
      message: 'Successfully joined the ride',
      data: result
    });
  } catch (error) {
    const message = error instanceof Error ? error.message : 'Failed to join ride';

    // Handle specific error cases
    if (message.includes('not found') || message.includes('not available') ||
        message.includes('Cannot join') || message.includes('Already joined') ||
        message.includes('No seats')) {
      return res.status(400).json({
        success: false,
        error: message
      });
    }

    console.error('Join ride error:', error);
    res.status(500).json({
      success: false,
      error: 'Internal server error'
    });
  }
});

/**
 * DELETE /api/rides/:id/join
 * Leave a ride (requires authentication)
 */
router.delete('/:id/join', authenticateToken, joinRideValidation, handleValidationErrors, async (req: Request, res: Response) => {
  try {
    const rideId = req.params.id;
    const userId = (req as any).user.id;

    const success = await RideService.leaveRide(rideId, userId);

    if (!success) {
      return res.status(400).json({
        success: false,
        error: 'Failed to leave ride'
      });
    }

    res.status(200).json({
      success: true,
      message: 'Successfully left the ride'
    });
  } catch (error) {
    const message = error instanceof Error ? error.message : 'Failed to leave ride';

    if (message.includes('not found') || message.includes('not a participant')) {
      return res.status(400).json({
        success: false,
        error: message
      });
    }

    console.error('Leave ride error:', error);
    res.status(500).json({
      success: false,
      error: 'Internal server error'
    });
  }
});

/**
 * PUT /api/rides/:id/status
 * Update ride status (requires authentication, creator only)
 */
router.put('/:id/status', authenticateToken, [
  param('id').isUUID().withMessage('Ride ID must be a valid UUID'),
  body('status').isIn(['active', 'in_progress', 'completed', 'cancelled']).withMessage('Invalid status')
], handleValidationErrors, async (req: Request, res: Response) => {
  try {
    const rideId = req.params.id;
    const userId = (req as any).user.id;
    const status = req.body.status;

    const ride = await RideService.updateRideStatus(rideId, userId, status);

    if (!ride) {
      return res.status(404).json({
        success: false,
        error: 'Ride not found'
      });
    }

    res.status(200).json({
      success: true,
      message: 'Ride status updated successfully',
      data: {
        id: ride.id,
        status: ride.status,
        updated_at: ride.updated_at
      }
    });
  } catch (error) {
    const message = error instanceof Error ? error.message : 'Failed to update ride status';

    if (message.includes('not found') || message.includes('only ride creator') || message.includes('Cannot change')) {
      return res.status(400).json({
        success: false,
        error: message
      });
    }

    console.error('Update ride status error:', error);
    res.status(500).json({
      success: false,
      error: 'Internal server error'
    });
  }
});

/**
 * DELETE /api/rides/:id
 * Delete ride (requires authentication, creator only)
 */
router.delete('/:id', authenticateToken, [
  param('id').isUUID().withMessage('Ride ID must be a valid UUID')
], handleValidationErrors, async (req: Request, res: Response) => {
  try {
    const rideId = req.params.id;
    const userId = (req as any).user.id;

    const success = await RideService.deleteRide(rideId, userId);

    if (!success) {
      return res.status(404).json({
        success: false,
        error: 'Ride not found'
      });
    }

    res.status(200).json({
      success: true,
      message: 'Ride deleted successfully'
    });
  } catch (error) {
    const message = error instanceof Error ? error.message : 'Failed to delete ride';

    if (message.includes('not found') || message.includes('only ride creator') || message.includes('Cannot delete')) {
      return res.status(400).json({
        success: false,
        error: message
      });
    }

    console.error('Delete ride error:', error);
    res.status(500).json({
      success: false,
      error: 'Internal server error'
    });
  }
});

/**
 * GET /api/rides/:id/calculate-cost
 * Calculate cost breakdown for a ride (public access)
 */
router.get('/:id/calculate-cost', [
  param('id').isUUID().withMessage('Ride ID must be a valid UUID')
], handleValidationErrors, async (req: Request, res: Response) => {
  try {
    const rideId = req.params.id;

    // Get ride details
    const ride = await RideModel.findById(rideId);
    if (!ride) {
      return res.status(404).json({
        success: false,
        error: 'Ride not found'
      });
    }

    // Get participant count (including creator)
    const participants = await RideModel.getParticipants(rideId);
    const passengerCount = participants.filter(p => p.status === 'active').length + 1; // +1 for creator

    // Calculate cost breakdown
    const costBreakdown = CostService.calculateRideCost(
      rideId,
      ride.origin,
      ride.destination,
      passengerCount
    );

    res.status(200).json({
      success: true,
      data: costBreakdown
    });
  } catch (error) {
    console.error('Calculate cost error:', error);
    res.status(500).json({
      success: false,
      error: 'Internal server error'
    });
  }
});

/**
 * POST /api/rides/:id/payment
 * Process payment for ride completion (requires authentication, creator only)
 */
router.post('/:id/payment', authenticateToken, [
  param('id').isUUID().withMessage('Ride ID must be a valid UUID'),
  body('payment_method').isIn(['card', 'paypal', 'apple_pay', 'google_pay']).withMessage('Invalid payment method'),
  body('card_token').optional().isString().withMessage('Card token must be a string')
], handleValidationErrors, async (req: Request, res: Response) => {
  try {
    const rideId = req.params.id;
    const userId = (req as any).user.id;
    const { payment_method, card_token } = req.body;

    const paymentResult = await PaymentService.processRidePayment(userId, {
      ride_id: rideId,
      payment_method,
      card_token
    });

    res.status(200).json({
      success: true,
      message: 'Payment processed successfully',
      data: paymentResult
    });
  } catch (error) {
    const message = error instanceof Error ? error.message : 'Payment processing failed';

    if (message.includes('not found') || message.includes('must be') ||
        message.includes('only ride creator') || message.includes('Insufficient funds')) {
      return res.status(400).json({
        success: false,
        error: message
      });
    }

    console.error('Payment processing error:', error);
    res.status(500).json({
      success: false,
      error: 'Internal server error'
    });
  }
});

export default router;

//testing// test Sun, Nov 30, 2025  4:32:12 PM
// test Sun, Nov 30, 2025  4:38:41 PM
