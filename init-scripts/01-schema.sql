-- Rider App Database Schema
-- Version: 1.0
-- Description: Complete schema for mid-journey ride-sharing platform
 -- Enable UUID extension

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ========================================
-- Core Tables
-- ========================================

CREATE TABLE IF NOT EXISTS ride_requests (id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                                                                      user_id UUID,
                                                                      start_location VARCHAR(255),
                                                                                     end_location VARCHAR(255),
                                                                                                  timestamp TIMESTAMP WITH TIME ZONE,
                                                                                                                                created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
                                                                                                                                                                            updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP);

COMMENT ON TABLE ride_requests IS 'Schema: Rider App Schema - Entity: Ride_requests';


CREATE TABLE IF NOT EXISTS ride_matches (id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                                                                     request_id UUID,
                                                                     driver_id UUID,
                                                                     matched_time VARCHAR(255),
                                                                                  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
                                                                                                                              updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP);

COMMENT ON TABLE ride_matches IS 'Schema: Rider App Schema - Entity: Ride_matches';


CREATE TABLE IF NOT EXISTS ride_costs (id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                                                                   ride_id UUID,
                                                                   total_cost DECIMAL(10,2),
                                                                              split_cost DECIMAL(10,2),
                                                                                         created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
                                                                                                                                     updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP);

COMMENT ON TABLE ride_costs IS 'Schema: Rider App Schema - Entity: Ride_costs';

-- ========================================
-- User Authentication Tables
-- ========================================

CREATE TABLE IF NOT EXISTS users (id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                                                              email VARCHAR(255) UNIQUE NOT NULL,
                                                                                        username VARCHAR(50) UNIQUE NOT NULL,
                                                                                                                    password_hash VARCHAR(255) NOT NULL,
                                                                                                                                               first_name VARCHAR(100) NOT NULL,
                                                                                                                                                                       last_name VARCHAR(100) NOT NULL,
                                                                                                                                                                                              phone VARCHAR(20),
                                                                                                                                                                                                    verified BOOLEAN DEFAULT FALSE,
                                                                                                                                                                                                                             created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
                                                                                                                                                                                                                                                                         updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP);

COMMENT ON TABLE users IS 'User accounts for authentication and profile information';

-- ========================================
-- Ride Management Tables
-- ========================================

CREATE TABLE IF NOT EXISTS rides
  (id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                               creator_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
                                                                                       origin_lat DECIMAL(10,8) NOT NULL,
                                                                                                                origin_lng DECIMAL(11,8) NOT NULL,
                                                                                                                                         origin_address VARCHAR(255) NOT NULL,
                                                                                                                                                                     destination_lat DECIMAL(10,8) NOT NULL,
                                                                                                                                                                                                   destination_lng DECIMAL(11,8) NOT NULL,
                                                                                                                                                                                                                                 destination_address VARCHAR(255) NOT NULL,
                                                                                                                                                                                                                                                                  seats_available INTEGER NOT NULL DEFAULT 3 CHECK (seats_available > 0), price_per_seat DECIMAL(10,2) NOT NULL CHECK (price_per_seat > 0), status VARCHAR(50) DEFAULT 'active' CHECK (status IN ('active',
                                                                                                                                                                                                                                                                                                                                                                                                                                                                  'in_progress',
                                                                                                                                                                                                                                                                                                                                                                                                                                                                  'completed',
                                                                                                                                                                                                                                                                                                                                                                                                                                                                  'cancelled')), created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP);

COMMENT ON TABLE rides IS 'Ride instances created by users';


CREATE TABLE IF NOT EXISTS ride_participants
  (id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                               ride_id UUID NOT NULL REFERENCES rides(id) ON DELETE CASCADE,
                                                                                    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
                                                                                                                                         joined_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
                                                                                                                                                                                    status VARCHAR(50) DEFAULT 'active' CHECK (status IN ('active',
                                                                                                                                                                                                                                          'left',
                                                                                                                                                                                                                                          'removed')), UNIQUE(ride_id, user_id));

COMMENT ON TABLE ride_participants IS 'Users participating in rides';

-- ========================================
-- Payment and Transaction Tables
-- ========================================

CREATE TABLE IF NOT EXISTS transactions
  (id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                               ride_id UUID NOT NULL REFERENCES rides(id) ON DELETE CASCADE,
                                                                                    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
                                                                                                                                         amount DECIMAL(10,2) NOT NULL,
                                                                                                                                                              status VARCHAR(50) DEFAULT 'pending' CHECK (status IN ('pending',
                                                                                                                                                                                                                     'completed',
                                                                                                                                                                                                                     'failed',
                                                                                                                                                                                                                     'refunded')), transaction_type VARCHAR(50) DEFAULT 'payment' CHECK (transaction_type IN ('payment',
                                                                                                                                                                                                                                                                                                              'refund',
                                                                                                                                                                                                                                                                                                              'split')), created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
                                                                                                                                                                                                                                                                                                                                                                     updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP);

COMMENT ON TABLE transactions IS 'Payment transactions for rides';

-- ========================================
-- Supporting Tables
-- ========================================

CREATE TABLE IF NOT EXISTS user_verifications
  (id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                               user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
                                                                                    verification_token VARCHAR(255) UNIQUE NOT NULL,
                                                                                                                           token_expires_at TIMESTAMP WITH TIME ZONE NOT NULL,
                                                                                                                                                                     verified_at TIMESTAMP WITH TIME ZONE,
                                                                                                                                                                                                     created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP);

COMMENT ON TABLE user_verifications IS 'Email verification tokens';


CREATE TABLE IF NOT EXISTS notifications
  (id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                               user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
                                                                                    title VARCHAR(255) NOT NULL,
                                                                                                       message TEXT NOT NULL,
                                                                                                                    type VARCHAR(50) DEFAULT 'info' CHECK (type IN ('info',
                                                                                                                                                                    'warning',
                                                                                                                                                                    'error',
                                                                                                                                                                    'success')), read BOOLEAN DEFAULT FALSE,
                                                                                                                                                                                                      created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP);

COMMENT ON TABLE notifications IS 'User notifications';


CREATE TABLE IF NOT EXISTS safety_reports
  (id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                               reporter_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
                                                                                        reported_user_id UUID REFERENCES users(id) ON DELETE
   SET NULL,
       ride_id UUID REFERENCES rides(id) ON DELETE
   SET NULL,
       report_type VARCHAR(50) NOT NULL CHECK (report_type IN ('harassment',
                                                               'unsafe_behavior',
                                                               'payment_issue',
                                                               'other')), description TEXT NOT NULL,
                                                                                           status VARCHAR(50) DEFAULT 'pending' CHECK (status IN ('pending',
                                                                                                                                                  'investigating',
                                                                                                                                                  'resolved',
                                                                                                                                                  'dismissed')), created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
                                                                                                                                                                                                             updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP);

COMMENT ON TABLE safety_reports IS 'Safety and incident reports';

-- ========================================
-- Indexes for Performance
-- ========================================

CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);


CREATE INDEX IF NOT EXISTS idx_users_username ON users(username);


CREATE INDEX IF NOT EXISTS idx_rides_creator_id ON rides(creator_id);


CREATE INDEX IF NOT EXISTS idx_rides_status ON rides(status);


CREATE INDEX IF NOT EXISTS idx_ride_participants_ride_id ON ride_participants(ride_id);


CREATE INDEX IF NOT EXISTS idx_ride_participants_user_id ON ride_participants(user_id);


CREATE INDEX IF NOT EXISTS idx_transactions_ride_id ON transactions(ride_id);


CREATE INDEX IF NOT EXISTS idx_transactions_user_id ON transactions(user_id);


CREATE INDEX IF NOT EXISTS idx_notifications_user_id ON notifications(user_id);


CREATE INDEX IF NOT EXISTS idx_user_verifications_token ON user_verifications(verification_token);


CREATE TABLE IF NOT EXISTS drivers (id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                                                                user_id UUID,
                                                                vehicle_id UUID,
                                                                verification_status VARCHAR(255),
                                                                                    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
                                                                                                                                updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP);

COMMENT ON TABLE drivers IS 'Schema: Rider App Schema - Entity: Drivers';


CREATE TABLE IF NOT EXISTS ride_history (id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                                                                     user_id UUID,
                                                                     ride_id UUID,
                                                                     timestamp TIMESTAMP WITH TIME ZONE,
                                                                                                   created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
                                                                                                                                               updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP);

COMMENT ON TABLE ride_history IS 'Schema: Rider App Schema - Entity: Ride_history';


CREATE TABLE IF NOT EXISTS ride_tracking (id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                                                                      ride_id UUID,
                                                                      location_data VARCHAR(255),
                                                                                    timestamp TIMESTAMP WITH TIME ZONE,
                                                                                                                  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
                                                                                                                                                              updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP);

COMMENT ON TABLE ride_tracking IS 'Schema: Rider App Schema - Entity: Ride_tracking';


CREATE TABLE IF NOT EXISTS ride_feedback (id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                                                                      ride_id UUID,
                                                                      user_id UUID,
                                                                      rating VARCHAR(255),
                                                                             comments VARCHAR(255),
                                                                                      created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
                                                                                                                                  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP);

COMMENT ON TABLE ride_feedback IS 'Schema: Rider App Schema - Entity: Ride_feedback';


CREATE TABLE IF NOT EXISTS messages (id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                                                                 sender_id UUID,
                                                                 receiver_id UUID,
                                                                 content TEXT, timestamp TIMESTAMP WITH TIME ZONE,
                                                                                                             created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
                                                                                                                                                         updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP);

COMMENT ON TABLE messages IS 'Schema: Rider App Schema - Entity: Messages';

