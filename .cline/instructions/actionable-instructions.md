# Actionable Instructions - Rider App Quick Prototype Sprint

## Sprint Objectives

This sprint creates a **mid-journey ride-sharing platform** where riders can share rides and split costs dynamically. The platform enables real-time ride matching, cost calculation, and payment processing for shared rides that start mid-journey.

**Key Outcomes:**

- User registration and authentication system
- Real-time ride matching algorithm
- Dynamic cost splitting based on distance and passengers
- Basic frontend for ride creation and joining
- Database schema for users, rides, and transactions

## Tech Stack

- **Backend:** Express.js with TypeScript
- **Frontend:** React with TypeScript + Tailwind CSS
- **Database:** PostgreSQL (to be configured)
- **Authentication:** JWT tokens
- **Testing:** Jest for unit tests, API definition JSON files

## Major Tasks Breakdown

### Task 0: 🏗️ Project Foundation & Authentication Setup (HIGH PRIORITY)

**Status:** In Progress
**Estimated Complexity:** Medium
**Dependencies:** None

**Objective:** Establish the core project structure, database connection, and user authentication system.

**Sub-tasks:**

1. Initialize project with package.json and configuration files
2. Set up Express server with TypeScript configuration
3. Configure database connection and schema
4. Create User model and database migrations
5. Implement authentication service (register/login)
6. Create JWT middleware for protected routes
7. Set up API routes for auth endpoints
8. Configure testing framework

**Acceptance Criteria:**

- Server starts successfully on configured port
- Database connection is established and tested
- User registration endpoint works (POST /api/auth/register)
- User login endpoint works (POST /api/auth/login)
- JWT authentication middleware validates tokens correctly

**Files to Generate:**

- package.json, tsconfig.json, .gitignore, .env.example
- server/src/app.ts, server/src/server.ts
- server/src/config/database.ts
- server/src/models/User.ts
- server/src/services/AuthService.ts
- server/src/middleware/authMiddleware.ts
- server/src/routes/authRoutes.ts
- tests/api_definitions/auth/register.json
- tests/api_definitions/auth/login.json
- tests/api_definitions/auth/me.json

---

### Task 1: 🚗 Ride Management System

**Status:** Pending
**Estimated Complexity:** High
**Dependencies:** Task 0 (Database, Auth)

**Objective:** Create the core ride creation, joining, and management functionality.

**Sub-tasks:**

1. Create Ride model with location tracking
2. Implement ride creation service
3. Build ride matching algorithm (proximity-based)
4. Create ride joining/leaving functionality
5. Add real-time ride status updates
6. Implement ride completion logic

**Acceptance Criteria:**

- Users can create rides with pickup/dropoff locations
- Riders can search and join available rides
- Real-time ride status updates work
- Ride completion marks ride as finished

**Files to Generate:**

- server/src/models/Ride.ts
- server/src/services/RideService.ts
- server/src/services/RideMatchService.ts
- server/src/routes/rideRoutes.ts
- tests/api_definitions/rides/\*.json

---

### Task 2: 💰 Cost Calculation & Payment Integration

**Status:** Pending
**Estimated Complexity:** Medium
**Dependencies:** Task 1 (Ride System)

**Objective:** Implement dynamic cost splitting and basic payment processing.

**Sub-tasks:**

1. Create cost calculation algorithm (distance + passengers)
2. Implement payment service integration (Stripe/mock)
3. Build cost splitting logic for shared rides
4. Create transaction tracking
5. Add payment status updates

**Acceptance Criteria:**

- Costs are calculated accurately based on ride metrics
- Payment processing works for ride completion
- Cost splitting distributes charges correctly
- Transaction records are maintained

**Files to Generate:**

- server/src/services/CostService.ts
- server/src/services/PaymentService.ts
- server/src/models/Transaction.ts
- server/src/routes/paymentRoutes.ts
- tests/api_definitions/payments/\*.json

---

### Task 3: 🎨 Frontend User Interface

**Status:** Pending
**Estimated Complexity:** Medium
**Dependencies:** Task 0 (Auth), Task 1 (Rides)

**Objective:** Build the user interface for ride creation, joining, and management.

**Sub-tasks:**

1. Set up React + TypeScript + Tailwind project
2. Create authentication pages (login/register)
3. Build ride creation form
4. Implement ride listing and search
5. Add ride details and joining interface
6. Create user dashboard

**Acceptance Criteria:**

- Users can register and login through the UI
- Ride creation form works with location inputs
- Users can browse and join available rides
- Basic responsive design implemented

**Files to Generate:**

- client/src/App.tsx, client/src/main.tsx
- client/src/components/Auth/\*.tsx
- client/src/components/Rides/\*.tsx
- client/src/services/api.ts
- client/public/index.html

---

### Task 4: 🔗 Real-Time Features & Notifications

**Status:** Pending
**Estimated Complexity:** High
**Dependencies:** Task 1 (Ride System), Task 3 (Frontend)

**Objective:** Add real-time updates and notification system for ride matching.

**Sub-tasks:**

1. Implement WebSocket connections for real-time updates
2. Create notification service for ride matches
3. Add real-time ride status broadcasting
4. Build push notification system
5. Implement location tracking updates

**Acceptance Criteria:**

- Real-time ride matching notifications work
- Users receive updates on ride status changes
- Location tracking updates in real-time
- Notification preferences are configurable

**Files to Generate:**

- server/src/services/NotificationService.ts
- server/src/services/WebSocketService.ts
- client/src/services/websocket.ts
- server/src/routes/notificationRoutes.ts

---

### Task 5: 🛡️ Safety & Validation Features

**Status:** Pending
**Estimated Complexity:** Medium
**Dependencies:** Task 0-4

**Objective:** Implement safety features, user verification, and data validation.

**Sub-tasks:**

1. Add user verification workflow
2. Implement safety protocols and emergency contacts
3. Create user reporting system
4. Add comprehensive input validation
5. Implement rate limiting and security measures

**Acceptance Criteria:**

- User verification process is implemented
- Emergency contact system works
- User reporting functionality is available
- All inputs are properly validated

**Files to Generate:**

- server/src/services/SafetyService.ts
- server/src/middleware/validation.ts
- server/src/routes/safetyRoutes.ts
- tests/validation/\*.test.ts

---

### Task 6: 🧪 Testing & Integration

**Status:** Pending
**Estimated Complexity:** Medium
**Dependencies:** All previous tasks

**Objective:** Create comprehensive tests and ensure system integration.

**Sub-tasks:**

1. Write unit tests for all services
2. Create integration tests for API endpoints
3. Set up end-to-end testing
4. Performance testing and optimization
5. Documentation completion

**Acceptance Criteria:**

- All API endpoints have corresponding tests
- Integration tests pass
- Code coverage meets minimum requirements
- System performance is acceptable

**Files to Generate:**

- server/src/**tests**/\*_/_.test.ts
- tests/integration/\*.test.ts
- tests/e2e/\*.test.ts
- README.md updates

## Implementation Order

1. **Task 0** - Foundation (Database, Auth) - _Blocking for all others_
2. **Task 1** - Ride Management - _Core business logic_
3. **Task 2** - Cost/Payment - _Monetization features_
4. **Task 3** - Frontend UI - _User experience_
5. **Task 4** - Real-time Features - _Enhanced UX_
6. **Task 5** - Safety Features - _Trust and security_
7. **Task 6** - Testing - _Quality assurance_

## Database Schema Overview

**Core Tables:**

- users (id, email, password_hash, profile_data, created_at)
- rides (id, creator_id, origin, destination, status, created_at)
- ride_participants (ride_id, user_id, joined_at, status)
- transactions (id, ride_id, user_id, amount, status, created_at)

**Supporting Tables:**

- user_verifications, notifications, safety_reports, etc.

## API Endpoints Overview

**Authentication:** `/api/auth/register`, `/api/auth/login`, `/api/auth/me`
**Rides:** `/api/rides` (CRUD), `/api/rides/:id/join`, `/api/rides/:id/leave`
**Payments:** `/api/payments/calculate`, `/api/payments/process`
**Notifications:** `/api/notifications`, `/api/notifications/mark-read`

## Success Metrics

- ✅ Server starts and database connects
- ✅ User registration/login works
- ✅ Ride creation and joining functions
- ✅ Cost calculation is accurate
- ✅ Basic UI allows ride management
- ✅ Real-time notifications work
- ✅ All major user flows tested

---

**Ready for implementation!** Start with Task 0 and proceed sequentially.
