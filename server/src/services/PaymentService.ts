import RideModel from '../models/Ride';
import CostService, { CostBreakdown } from './CostService';

export interface PaymentRequest {
  ride_id: string;
  payment_method: 'card' | 'paypal' | 'apple_pay' | 'google_pay';
  card_token?: string; // For card payments
  paypal_token?: string; // For PayPal
  payment_intent_id?: string; // For Stripe or similar
}

export interface PaymentResult {
  ride_id: string;
  total_amount: number;
  passenger_payments: Array<{
    user_id: string;
    amount: number;
    status: 'completed' | 'pending' | 'failed';
  }>;
  transaction_id: string;
  payment_status: 'completed' | 'pending' | 'failed';
}

export interface TransactionRecord {
  id: string;
  ride_id: string;
  user_id: string;
  amount: number;
  status: 'pending' | 'completed' | 'failed' | 'refunded';
  transaction_type: 'payment' | 'refund' | 'split';
  payment_method: string;
  transaction_id: string; // External payment processor ID
  created_at: Date;
  updated_at: Date;
}

export class PaymentService {
  /**
   * Process payment for a completed ride
   */
  static async processRidePayment(
    userId: string,
    paymentRequest: PaymentRequest
  ): Promise<PaymentResult> {
    const { ride_id, payment_method, card_token } = paymentRequest;

    // Validate ride exists and is completed
    const ride = await RideModel.findById(ride_id);
    if (!ride) {
      throw new Error('Ride not found');
    }

    if (ride.status !== 'completed') {
      throw new Error('Ride must be completed before payment can be processed');
    }

    // Only ride creator can process payment
    if (ride.creator_id !== userId) {
      throw new Error('Only ride creator can process payment');
    }

    // Get all participants (including creator)
    const participants = await RideModel.getParticipants(ride_id);
    const allParticipants = [ride.creator_id, ...participants.map(p => p.user_id)];

    // Calculate cost breakdown
    const costBreakdown = CostService.calculateRideCost(
      ride_id,
      ride.origin,
      ride.destination,
      allParticipants.length
    );

    // Process payment through mock payment processor
    const transactionId = await this.processMockPayment(
      costBreakdown.total_cost,
      payment_method,
      card_token
    );

    // Create passenger payment records
    const passengerPayments = allParticipants.map(participantId => ({
      user_id: participantId,
      amount: costBreakdown.cost_per_passenger,
      status: 'completed' as const
    }));

    // Create transaction records (in a real implementation, this would be stored in DB)
    const transactionRecords = passengerPayments.map((payment, index) => ({
      id: `txn-${Date.now()}-${index}`,
      ride_id,
      user_id: payment.user_id,
      amount: payment.amount,
      status: 'completed' as const,
      transaction_type: 'split' as const,
      payment_method,
      transaction_id: transactionId,
      created_at: new Date(),
      updated_at: new Date()
    }));

    return {
      ride_id,
      total_amount: costBreakdown.total_cost,
      passenger_payments: passengerPayments,
      transaction_id: transactionId,
      payment_status: 'completed'
    };
  }

  /**
   * Mock payment processor (simulates Stripe, PayPal, etc.)
   */
  private static async processMockPayment(
    amount: number,
    paymentMethod: string,
    cardToken?: string
  ): Promise<string> {
    // Simulate payment processing delay
    await new Promise(resolve => setTimeout(resolve, 1000));

    // Simulate occasional payment failures (5% failure rate)
    if (Math.random() < 0.05) {
      throw new Error('Payment processing failed: Insufficient funds');
    }

    // Validate payment method and tokens
    if (paymentMethod === 'card' && !cardToken) {
      throw new Error('Card token required for card payments');
    }

    if (paymentMethod === 'paypal' && !cardToken) {
      throw new Error('PayPal token required for PayPal payments');
    }

    // Generate mock transaction ID
    const transactionId = `mock_txn_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`;

    return transactionId;
  }

  /**
   * Process refund for a ride
   */
  static async processRefund(
    rideId: string,
    userId: string,
    amount: number,
    reason: string = 'Ride cancelled'
  ): Promise<{ transaction_id: string; refund_status: 'completed' | 'pending' }> {
    // Validate ride exists
    const ride = await RideModel.findById(rideId);
    if (!ride) {
      throw new Error('Ride not found');
    }

    // Mock refund processing
    await new Promise(resolve => setTimeout(resolve, 500));

    const refundTransactionId = `refund_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`;

    return {
      transaction_id: refundTransactionId,
      refund_status: 'completed'
    };
  }

  /**
   * Get payment status for a ride
   */
  static async getRidePaymentStatus(rideId: string): Promise<{
    ride_id: string;
    payment_status: 'pending' | 'completed' | 'failed';
    total_amount: number;
    paid_amount: number;
    outstanding_amount: number;
  }> {
    // In a real implementation, this would query the transactions table
    // For now, return mock data
    return {
      ride_id: rideId,
      payment_status: 'completed',
      total_amount: 15.50,
      paid_amount: 15.50,
      outstanding_amount: 0
    };
  }

  /**
   * Validate payment method
   */
  static validatePaymentMethod(method: string): boolean {
    const validMethods = ['card', 'paypal', 'apple_pay', 'google_pay'];
    return validMethods.includes(method);
  }

  /**
   * Calculate fees for payment processing
   */
  static calculateProcessingFees(amount: number, paymentMethod: string): number {
    // Different fees for different payment methods
    const feeRates = {
      card: 0.029, // 2.9% for cards
      paypal: 0.024, // 2.4% for PayPal
      apple_pay: 0.015, // 1.5% for Apple Pay
      google_pay: 0.015 // 1.5% for Google Pay
    };

    const rate = feeRates[paymentMethod as keyof typeof feeRates] || 0.029;
    return Math.round(amount * rate * 100) / 100; // Round to 2 decimal places
  }

  /**
   * Get supported payment methods
   */
  static getSupportedPaymentMethods(): Array<{
    method: string;
    name: string;
    processing_fee_rate: number;
    requires_token: boolean;
  }> {
    return [
      {
        method: 'card',
        name: 'Credit/Debit Card',
        processing_fee_rate: 0.029,
        requires_token: true
      },
      {
        method: 'paypal',
        name: 'PayPal',
        processing_fee_rate: 0.024,
        requires_token: true
      },
      {
        method: 'apple_pay',
        name: 'Apple Pay',
        processing_fee_rate: 0.015,
        requires_token: true
      },
      {
        method: 'google_pay',
        name: 'Google Pay',
        processing_fee_rate: 0.015,
        requires_token: true
      }
    ];
  }

  /**
   * Create payment intent (for Stripe-like integrations)
   */
  static async createPaymentIntent(
    amount: number,
    currency: string = 'usd',
    description: string = 'Ride payment'
  ): Promise<{ client_secret: string; payment_intent_id: string }> {
    // Mock payment intent creation
    const paymentIntentId = `pi_mock_${Date.now()}`;
    const clientSecret = `pi_${paymentIntentId}_secret_mock`;

    return {
      client_secret: clientSecret,
      payment_intent_id: paymentIntentId
    };
  }
}

export default PaymentService;
