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
- **Database:** PostgreSQL
- **Authentication:** JWT tokens
- **Testing:** Jest for unit tests, API definition JSON files

---

## Major Implementation Tasks

### Task 0: 🏗️ Project Foundation & Authentication Setup (HIGH PRIORITY)

**Objective:** Establish the core project structure, database connection, and user authentication system.

**Sub-tasks:**

1. **Initialize project with package.json and configuration files**

   - Create package.json with Express, TypeScript, PostgreSQL dependencies
   - Set up tsconfig.json, .gitignore, .env.example
   - Configure Jest for testing
   - Location: `package.json`, `tsconfig.json`, `.env.example`, `jest.config.js`

2. **Set up Express server with TypeScript configuration**

   - Create app.ts with middleware setup (CORS, helmet, rate limiting)
   - Create server.ts for server startup and graceful shutdown
   - Add health check endpoint
   - Location: `server/src/app.ts`, `server/src/server.ts`

3. **Configure database connection and schema**

   - Set up PostgreSQL connection with pg library
   - Create database configuration file
   - Update init-scripts/01-schema.sql with user authentication tables
   - Location: `server/src/config/database.ts`, `init-scripts/01-schema.sql`

4. **Create User model and database migrations**

   - Implement User model with CRUD operations
   - Add proper TypeScript interfaces
   - Handle database connection errors
   - Location: `server/src/models/User.ts`

5. **Implement authentication service (register/login)**

   - Create AuthService with password hashing (bcrypt)
   - Implement JWT token generation and verification
   - Add email/username validation
   - Location: `server/src/services/AuthService.ts`

6. **Create JWT middleware for protected routes**

   - Implement authenticateToken middleware
   - Add optional authentication for public routes
   - Handle token verification errors
   - Location: `server/src/middleware/authMiddleware.ts`

7. **Set up API routes for auth endpoints**

   - Create authRoutes with register, login, me endpoints
   - Add express-validator middleware
   - Implement proper error handling
   - Location: `server/src/routes/authRoutes.ts`

8. **Configure testing framework**
   - Set up Jest with TypeScript support
   - Create basic AuthService unit tests
   - Configure test environment
   - Location: `server/src/__tests__/unit/services/AuthService.test.ts`

**Dependencies:** None
**Estimated Complexity:** High (foundation work)
**Acceptance Criteria:**

- Server starts successfully on configured port
- Database connection is established and tested
- User registration endpoint works (POST /api/auth/register)
- User login endpoint works (POST /api/auth/login)
- JWT authentication middleware validates tokens correctly
- Basic unit tests pass

---

### Task 1: 🚗 Ride Management System

**Objective:** Create the core ride creation, joining, and management functionality.

**Sub-tasks:**

1. **Create Ride model with location tracking**

   - Design Ride table schema with origin/destination
   - Implement Ride model with TypeScript interfaces
   - Add ride status management
   - Location: `server/src/models/Ride.ts`, update `init-scripts/01-schema.sql`

2. **Implement ride creation service**

   - Create RideService for CRUD operations
   - Add ride validation logic
   - Implement ride status updates
   - Location: `server/src/services/RideService.ts`

3. **Build ride matching algorithm (proximity-based)**

   - Create RideMatchService for finding nearby rides
   - Implement location-based matching logic
   - Add distance calculation utilities
   - Location: `server/src/services/RideMatchService.ts`

4. **Create ride joining/leaving functionality**

   - Add ride participant management
   - Implement join/leave business logic
   - Add participant validation
   - Location: update `server/src/services/RideService.ts`

5. **Add real-time ride status updates**
   - Create basic ride status tracking
   - Implement ride completion logic
   - Add ride history management
   - Location: update `server/src/models/Ride.ts`

**Dependencies:** Task 0 (Database, Auth)
**Estimated Complexity:** High (core business logic)
**Acceptance Criteria:**

- Users can create rides with pickup/dropoff locations
- Riders can search and join available rides
- Real-time ride status updates work
- Ride completion marks ride as finished

---

### Task 2: 💰 Cost Calculation & Payment Integration

**Objective:** Implement dynamic cost splitting and basic payment processing.

**Sub-tasks:**

1. **Create cost calculation algorithm (distance + passengers)**

   - Implement CostService for fare calculation
   - Add distance-based pricing logic
   - Support passenger count splitting
   - Location: `server/src/services/CostService.ts`

2. **Implement payment service integration (Stripe/mock)**

   - Create PaymentService for transaction handling
   - Add payment method validation
   - Implement basic payment flow
   - Location: `server/src/services/PaymentService.ts`

3. **Build cost splitting logic for shared rides**

   - Add Transaction model for payment tracking
   - Implement cost distribution algorithms
   - Add payment status management
   - Location: `server/src/models/Transaction.ts`, update schema

4. **Create transaction tracking**
   - Add transaction history and status
   - Implement payment reconciliation
   - Add audit trail capabilities
   - Location: update `server/src/services/PaymentService.ts`

**Dependencies:** Task 1 (Ride System)
**Estimated Complexity:** Medium
**Acceptance Criteria:**

- Costs are calculated accurately based on ride metrics
- Payment processing works for ride completion
- Cost splitting distributes charges correctly
- Transaction records are maintained

---

### Task 3: 🎨 Frontend User Interface

**Objective:** Build the user interface for ride creation, joining, and management.

**Sub-tasks:**

1. **Set up React + TypeScript + Tailwind project**

   - Create client directory structure
   - Configure Vite for development
   - Set up Tailwind CSS
   - Location: `client/`, `vite.config.ts`, `tailwind.config.js`

2. **Create authentication pages (login/register)**

   - Build login and registration forms
   - Add form validation
   - Implement authentication flow
   - Location: `client/src/pages/Auth/`

3. **Build ride creation form**

   - Create ride creation interface
   - Add location input with maps integration
   - Implement form validation
   - Location: `client/src/pages/Rides/CreateRideForm.tsx`

4. **Implement ride listing and search**

   - Create ride discovery page
   - Add search and filter functionality
   - Display available rides
   - Location: `client/src/pages/Rides/`, `client/src/components/Rides/RideList.tsx`

5. **Add ride details and joining interface**
   - Create ride detail view
   - Implement join/leave ride functionality
   - Add real-time updates
   - Location: `client/src/components/Rides/RideDetail.tsx`

**Dependencies:** Task 0 (Auth), Task 1 (Rides)
**Estimated Complexity:** Medium
**Acceptance Criteria:**

- Users can register and login through the UI
- Ride creation form works with location inputs
- Users can browse and join available rides
- Basic responsive design implemented

---

### Task 4: 🔗 Real-Time Features & Notifications

**Objective:** Add real-time updates and notification system for ride matching.

**Sub-tasks:**

1. **Implement WebSocket connections for real-time updates**

   - Set up Socket.IO server integration
   - Create WebSocket service
   - Handle connection management
   - Location: `server/src/services/WebSocketService.ts`

2. **Create notification service for ride matches**

   - Implement NotificationService
   - Add push notification capabilities
   - Create notification preferences
   - Location: `server/src/services/NotificationService.ts`

3. **Add real-time ride status broadcasting**
   - Broadcast ride updates to participants
   - Implement status change notifications
   - Add real-time location sharing
   - Location: update `server/src/services/RideService.ts`

**Dependencies:** Task 1 (Ride System), Task 3 (Frontend)
**Estimated Complexity:** High
**Acceptance Criteria:**

- Real-time ride matching notifications work
- Users receive updates on ride status changes
- WebSocket connections handle multiple clients
- Notification preferences are configurable

---

### Task 5: 🛡️ Safety & Validation Features

**Objective:** Implement safety features, user verification, and data validation.

**Sub-tasks:**

1. **Add user verification workflow**

   - Create user verification system
   - Add email verification process
   - Implement verification status tracking
   - Location: `server/src/services/UserVerificationService.ts`

2. **Implement safety protocols and emergency contacts**

   - Add emergency contact management
   - Create safety reporting system
   - Implement ride safety features
   - Location: `server/src/services/SafetyService.ts`

3. **Create user reporting system**
   - Add user feedback and reporting
   - Implement moderation capabilities
   - Create reporting workflows
   - Location: update `server/src/services/SafetyService.ts`

**Dependencies:** Task 0-4
**Estimated Complexity:** Medium
**Acceptance Criteria:**

- User verification process is implemented
- Emergency contact system works
- User reporting functionality is available
- Safety protocols are enforced

---

### Task 6: 🧪 Testing & Integration

**Objective:** Create comprehensive tests and ensure system integration.

**Sub-tasks:**

1. **Write unit tests for all services**

   - Create comprehensive unit test suite
   - Add service layer testing
   - Implement mock data and fixtures
   - Location: `server/src/__tests__/unit/`

2. **Create integration tests for API endpoints**

   - Set up integration test environment
   - Test complete API workflows
   - Add database integration tests
   - Location: `tests/integration/`

3. **Set up end-to-end testing**

   - Create E2E test suite
   - Test user journeys
   - Implement automated browser testing
   - Location: `tests/e2e/`

4. **Documentation completion**
   - Create API documentation
   - Add user guides and tutorials
   - Update README with deployment instructions
   - Location: `docs/`, `README.md`

**Dependencies:** All previous tasks
**Estimated Complexity:** Medium
**Acceptance Criteria:**

- All API endpoints have corresponding tests
- Integration tests pass successfully
- Code coverage meets minimum requirements
- Documentation is complete and accurate

---

## Implementation Order

**Phase 1: Foundation (Week 1)**

1. Task 0: Foundation Setup (Database, Auth, Basic API)

**Phase 2: Core Features (Week 2)** 2. Task 1: Ride Management (CRUD, Matching, Status) 3. Task 2: Cost/Payment (Calculation, Transactions)

**Phase 3: User Experience (Week 3)** 4. Task 3: Frontend UI (Auth, Ride Creation, Discovery) 5. Task 4: Real-Time Features (WebSocket, Notifications)

**Phase 4: Polish & Production (Week 4)** 6. Task 5: Safety Features (Verification, Reporting) 7. Task 6: Testing & Documentation (Unit, Integration, E2E)

## Database Schema Overview

**Core Tables:**

- users (id, email, username, password_hash, first_name, last_name, phone, verified, created_at, updated_at)
- rides (id, creator_id, origin, destination, status, current_location, created_at, updated_at)
- ride_participants (ride_id, user_id, joined_at, status)
- transactions (id, ride_id, user_id, amount, status, created_at)

**Supporting Tables:**

- user_verifications, notifications, safety_reports, ride_history

## API Endpoints Overview

**Authentication:** `/api/auth/register`, `/api/auth/login`, `/api/auth/me`
**Rides:** `/api/rides` (CRUD), `/api/rides/:id/join`, `/api/rides/search`
**Payments:** `/api/payments/calculate`, `/api/payments/process`
**Notifications:** `/api/notifications`, WebSocket events

## Success Metrics

- ✅ Server starts and database connects
- ✅ User registration/login works end-to-end
- ✅ Ride creation and matching functions
- ✅ Cost calculation and payment processing works
- ✅ Real-time updates and notifications work
- ✅ All major user flows are tested

---

## API Test Definition Workflow

For EACH API endpoint created, follow this mandatory workflow:

1. **Create JSON test definition FIRST** in `tests/api_definitions/{route}/{endpoint}.json`
2. **Implement API code** to match the JSON specification exactly
3. **Verify** payload and response match the JSON
4. **Commit** and let MCP server validate

**Example:** For user registration API:

- JSON: `tests/api_definitions/auth/register.json`
- Code: `server/src/routes/authRoutes.ts`

---

## Progress Tracking

- Update `.cline/progress/tasks-completed.json` after each major task
- Update `.cline/progress/major-tasks/task-{N}.json` for sub-task progress
- Commit after each completed sub-task
- Use MCP server for automated testing validation

---

## Quality Standards

- All APIs must have test definitions before implementation
- Database operations must be optimized and secure
- Authentication must use JWT with proper validation
- Input validation on all endpoints
- Error handling must be comprehensive
- Code must follow TypeScript best practices

---

**Ready to begin implementation! Start with Task 0: Foundation Setup.**
