# Code Generation Instructions for Cline

## 📋 Overview

This export is optimized for **Cline** - the autonomous coding agent.

**Cline supports two modes:**
- 🖥️ **VS Code Extension** - Use within VS Code, Cursor, or any VS Code fork
- 💻 **Cline CLI** - Standalone terminal tool (`npm install -g cline`)

**Key Features:**
- **Plan Mode**: Review and approve changes before execution
- **Act Mode**: Execute approved changes automatically
- **MCP Integration**: Connect to ProjexLight MCP server for code review
- **Multi-Model**: Works with Claude, GPT-4, Gemini, and more

## 📁 Context Files

- `.cline/context/requirements.md` - Complete requirements
- `.cline/context/sprint-context.json` - Structured data
- `.cline/context/framework-config.json` - Tech stack configuration
- `.cline/progress/` - Track completion status

## 🚀 Getting Started

### Option 1: VS Code Extension

1. Install Cline extension from VS Code Marketplace
2. Open this project folder in VS Code
3. Click the Cline icon in the sidebar
4. Reference `.cline/instructions/generation-plan.md` in your chat

### Option 2: Cline CLI

```bash
# Install Cline CLI (requires Node.js 20+)
npm install -g cline

# Authenticate
cline auth

# Start interactive session
cd /path/to/this/project
cline

# Or run with specific task
cline "Read .cline/instructions/generation-plan.md and implement the tasks"
```

## ⚠️ Step 0: Create Actionable Instructions (REQUIRED FIRST)

**📌 CRITICAL: Before any code generation, create a comprehensive task breakdown.**

**Create `.cline/instructions/actionable-instructions.md` with:**

1. **Sprint Objectives** - What this sprint accomplishes
2. **Major Tasks** - Break the sprint into 5-10 major implementation tasks
3. **Task Details** - For each major task:
   - Sub-tasks with specific file paths
   - Dependencies between tasks
   - Estimated complexity
   - Acceptance criteria

4. **Implementation Order** - Sequence tasks logically:
   - Database/models first
   - Services and business logic
   - API endpoints
   - Frontend components
   - Integration and testing

## 🎯 Plan & Act Workflow

Cline uses a two-phase approach:

### Phase 1: Plan Mode

```
You: "Implement Task 1 from .cline/instructions/actionable-instructions.md"
Cline: [Reviews task and creates a plan]
Cline: "Here's my plan:
        1. Create UserService.ts
        2. Create userRoutes.ts
        3. Add validation middleware
        Ready to execute?"
```

### Phase 2: Act Mode

```
You: "/act" (or type "yes" to approve)
Cline: [Executes the plan, creating/editing files]
```

## 🔧 Actual Implementation Mode

**You are generating PRODUCTION-READY code:**
- Implement full database schema and migrations
- Create complete API endpoints with validation
- Implement real authentication and authorization
- Add comprehensive error handling
- Follow security best practices

## 🛠️ Framework Configuration

**Tech Stack:**
- Backend: express (typescript)
- Database: undefined
- Frontend: react (typescript)
- Styling: tailwind

**See `.cline/context/framework-config.json` for complete configuration.**

## 📝 Generation Scope

- API Development
- UI Development
- Unit Tests
- DB Schema Design

### API Development Workflow

**⚠️ For EACH API endpoint, follow this mandatory cycle:**

1. Create database model (if needed)
2. Create service layer with business logic
3. Create API route with validation middleware
4. **🚨 IMMEDIATELY create test JSON file** in `tests/api_definitions/`
5. Verify both files created before next endpoint

**This workflow ensures tests exist for every API!**

#### 🚨 CRITICAL: API Test Definition Requirements

**PURPOSE: API Discovery & Documentation for QA Team**

These test definitions serve as **API documentation** and **happy path validation**. The goal is:
- 📋 Document all APIs for the QA team
- ✅ Validate each API works with proper payload structure
- 📊 Update `api_library` table with request/response samples
- 🚀 Enable git push to verify APIs are functional

**IMPORTANT: You only need ONE happy path test case per API - NOT multiple test cases!**

**🚨 MANDATORY WORKFLOW: For EVERY API endpoint (FOLLOW THIS EXACT ORDER):**

**STEP 1️⃣: Create the API Definition JSON FIRST** ⬅️ **DO THIS FIRST BEFORE WRITING ANY CODE!**
   - Location: `tests/api_definitions/{route-name}/{endpoint-name}.json`
   - Include complete sample **payload** with ALL required fields and realistic values
   - Include complete sample **expectedResponse** showing exactly what the API returns
   - This JSON serves as the specification for your API implementation

**STEP 2️⃣: Write the API Code Based on the JSON**
   - Read the JSON definition you just created
   - Implement the API route file (e.g., `server/src/routes/authRoutes.ts`)
   - Ensure your code accepts the exact payload structure defined in JSON
   - Ensure your code returns the exact response structure defined in expectedResponse
   - Add validation middleware matching the payload fields

**STEP 3️⃣: Move to Next API Endpoint and Repeat**

**WHY THIS ORDER MATTERS:**
✅ JSON-first ensures you have a clear API specification before coding
✅ Prevents payload/response structure mismatches
✅ MCP server can immediately use the JSON for automated testing
✅ QA team has API documentation even before code is complete

**File Location:** `tests/api_definitions/{route-name}/{endpoint-name}.json`

**Examples:**
- `tests/api_definitions/auth/register.json`
- `tests/api_definitions/auth/login.json`
- `tests/api_definitions/users/get-user.json`

**JSON Format (ONE HAPPY PATH TEST CASE ONLY):**
```json
{
  "endpoint": "/api/auth/register",
  "method": "POST",
  "description": "Register a new user with email, username, and password",
  "requiresAuth": false,
  "tags": ["auth", "user", "registration"],
  "testCases": [
    {
      "name": "Happy path - successful registration",
      "payload": {
        "email": "user@example.com",
        "username": "testuser",
        "password": "SecurePassword123!",
        "first_name": "John",
        "last_name": "Doe"
      },
      "expectedStatus": 201,
      "expectedResponse": {
        "success": true,
        "message": "User registered successfully"
      }
    }
  ]
}
```

**Why This is Critical:**
- ✅ Git push hook validates APIs are functional
- 📊 Request/response captured and stored in `api_library` table
- 📋 QA team gets visibility into all APIs and required payloads
- 🔒 MCP server will generate unique test data to avoid conflicts

**Required Fields in API Definition JSON:**
- `endpoint`: Full API path (e.g., "/api/auth/register")
- `method`: HTTP method (GET, POST, PUT, PATCH, DELETE)
- `description`: Clear description of what the API does
- `requiresAuth`: true if requires authentication token, false otherwise
- `tags`: Array of category tags (e.g., ["auth", "users"])
- `testCases`: Array with EXACTLY 1 happy path test case containing:
  - `name`: Descriptive test case name (e.g., "Happy path - successful creation")
  - `payload`: **COMPLETE** request body with ALL required fields and realistic valid data
  - `expectedStatus`: Expected success status code (200, 201, 204)
  - `expectedResponse`: **COMPLETE** sample response structure that your API will return

**🚨 CRITICAL: Both payload AND expectedResponse must be complete and realistic!**

**🔍 CRITICAL: Happy Path Test Data Requirements**

When creating the ONE happy path test case:

1. **Read the API's validation middleware carefully**
   - Identify ALL required fields
   - Note validation rules (email format, min/max length, etc.)
   - Include ALL required fields in the payload

2. **Use valid data for ALL fields**
   - All fields must pass validation rules
   - Use realistic sample data
   - DO NOT use placeholder values like "test@test.com"

3. **Standard formats to use:**
   - Email: `user@example.com`, `john.doe@example.com`
   - Phone: `+15550123456` (E.164 format)
   - Date: `1990-05-15` (ISO 8601)
   - Password: `SecurePassword123!` (meets strength requirements)
   - UUID: `123e4567-e89b-12d3-a456-426614174000`

4. **MCP Runtime Behavior (Automatic - You Don't Need to Worry)**
   - 🤖 MCP server will generate UNIQUE test data dynamically
   - 🔗 MCP automatically chains authentication flows (register → login → use token)
   - 📊 MCP captures request/response and updates `api_library` table
   - ✅ Your test will PASS even on repeated runs (no "user already exists" errors)

**🔄 STEP-BY-STEP: Complete Example Workflow**

**Scenario: You need to create a user registration API**

**STEP 1️⃣ - Create the JSON definition FIRST (Before any code!):**

File: `tests/api_definitions/auth/register.json`

```json
{
  "endpoint": "/api/auth/register",
  "method": "POST",
  "description": "Register a new user with email, username, and password",
  "requiresAuth": false,
  "tags": ["auth", "registration"],
  "testCases": [
    {
      "name": "Happy path - successful registration",
      "payload": {
        "email": "user@example.com",
        "username": "johndoe",
        "password": "SecurePass123!",
        "first_name": "John",
        "last_name": "Doe"
      },
      "expectedStatus": 201,
      "expectedResponse": {
        "success": true,
        "message": "User registered successfully",
        "data": {
          "id": "123e4567-e89b-12d3-a456-426614174000",
          "email": "user@example.com",
          "username": "johndoe",
          "first_name": "John",
          "last_name": "Doe",
          "created_at": "2024-01-15T10:30:00Z"
        }
      }
    }
  ]
}
```

**STEP 2️⃣ - Now write the API code based on the JSON:**

File: `server/src/routes/authRoutes.ts`

```typescript
// Read the JSON you created and implement matching validation
router.post('/api/auth/register', [
  body('email').isEmail(),
  body('username').isLength({ min: 3, max: 50 }),
  body('password').isLength({ min: 8 }),
  body('first_name').notEmpty(),
  body('last_name').notEmpty(),
  validate
], async (req, res) => {
  // Return response matching expectedResponse structure in JSON
  const user = await userService.create(req.body);
  res.status(201).json({
    success: true,
    message: "User registered successfully",
    data: {
      id: user.id,
      email: user.email,
      username: user.username,
      first_name: user.first_name,
      last_name: user.last_name,
      created_at: user.created_at
    }
  });
});
```

**STEP 3️⃣ - Verify payload and response match:**
- ✅ Payload fields in JSON match validation middleware
- ✅ Response structure matches expectedResponse in JSON
- ✅ Status code matches expectedStatus (201)
- ✅ MCP server can now test this API using the JSON

**✅ CHECKLIST before moving to next API:**
- [ ] JSON file created FIRST (before writing API code)
- [ ] JSON file in correct location: `tests/api_definitions/{route-file}/{api-name}.json`
- [ ] EXACTLY 1 happy path test case (NOT multiple)
- [ ] Complete `payload` with ALL required fields and realistic values
- [ ] Complete `expectedResponse` showing full API response structure
- [ ] `expectedStatus` is a success code (200, 201, 204)
- [ ] API code written to match the JSON specification

**📊 What Happens Next (Automatic):**
1. MCP server reads your JSON during pre-commit hook
2. MCP updates `api_library` table with sample payload/response
3. QA team can immediately see the API documentation
4. MCP runs the test to verify API works as specified

**GET Endpoints Example (with expectedResponse):**
```json
{
  "endpoint": "/api/users/:id",
  "method": "GET",
  "description": "Get user by ID",
  "requiresAuth": false,
  "tags": ["users"],
  "testCases": [
    {
      "name": "Happy path - get existing user",
      "pathParams": { "id": "123" },
      "expectedStatus": 200,
      "expectedResponse": {
        "success": true,
        "data": {
          "id": "123",
          "email": "user@example.com",
          "username": "johndoe",
          "first_name": "John",
          "last_name": "Doe",
          "created_at": "2024-01-15T10:30:00Z"
        }
      }
    }
  ]
}
```

**Protected Endpoints Example (with expectedResponse):**
```json
{
  "endpoint": "/api/auth/me",
  "method": "GET",
  "description": "Get current user profile",
  "requiresAuth": true,
  "tags": ["auth", "profile"],
  "testCases": [
    {
      "name": "Happy path - get profile with valid token",
      "expectedStatus": 200,
      "expectedResponse": {
        "success": true,
        "data": {
          "id": "user-id-from-token",
          "email": "current.user@example.com",
          "username": "currentuser",
          "profile": {
            "first_name": "Current",
            "last_name": "User",
            "avatar_url": "https://example.com/avatar.jpg"
          }
        }
      }
    }
  ]
}
```

**PUT Endpoints Example (with payload and expectedResponse):**
```json
{
  "endpoint": "/api/users/:id",
  "method": "PUT",
  "description": "Update user information",
  "requiresAuth": true,
  "tags": ["users", "update"],
  "testCases": [
    {
      "name": "Happy path - update user profile",
      "pathParams": { "id": "123" },
      "payload": {
        "first_name": "Jane",
        "last_name": "Smith",
        "email": "jane.smith@example.com"
      },
      "expectedStatus": 200,
      "expectedResponse": {
        "success": true,
        "message": "User updated successfully",
        "data": {
          "id": "123",
          "first_name": "Jane",
          "last_name": "Smith",
          "email": "jane.smith@example.com",
          "updated_at": "2024-01-15T11:00:00Z"
        }
      }
    }
  ]
}
```

**PATCH Endpoints Example (partial update with payload and expectedResponse):**
```json
{
  "endpoint": "/api/users/:id/email",
  "method": "PATCH",
  "description": "Update user email only",
  "requiresAuth": true,
  "tags": ["users", "partial-update"],
  "testCases": [
    {
      "name": "Happy path - update email",
      "pathParams": { "id": "123" },
      "payload": {
        "email": "newemail@example.com"
      },
      "expectedStatus": 200,
      "expectedResponse": {
        "success": true,
        "message": "Email updated successfully",
        "data": {
          "id": "123",
          "email": "newemail@example.com",
          "email_verified": false,
          "updated_at": "2024-01-15T11:30:00Z"
        }
      }
    }
  ]
}
```

**DELETE Endpoints Example (with expectedResponse):**
```json
{
  "endpoint": "/api/users/:id",
  "method": "DELETE",
  "description": "Delete user account",
  "requiresAuth": true,
  "tags": ["users", "delete"],
  "testCases": [
    {
      "name": "Happy path - delete user",
      "pathParams": { "id": "123" },
      "expectedStatus": 200,
      "expectedResponse": {
        "success": true,
        "message": "User deleted successfully",
        "data": {
          "id": "123",
          "deleted_at": "2024-01-15T12:00:00Z"
        }
      }
    }
  ]
}
```

**🎯 Remember: The goal is API documentation and discovery, not comprehensive testing!**
- **All HTTP methods supported:** GET, POST, PUT, PATCH, DELETE
- **Each needs complete sample:** payload (if applicable) and expectedResponse
- **Folder structure:** `tests/api_definitions/{route-file}/{api-name}.json`
- The QA team will create comprehensive test suites later
- You're documenting what APIs exist and their contracts

## 🔗 MCP Server Integration

This project includes ProjexLight MCP server for automated code review.

**How it works:**
1. MCP server runs in Docker (see `docker-compose.yml`)
2. Pre-commit hooks scan code for duplicates and violations
3. Feedback is written to `/feedback/latest.json`
4. Review feedback before committing

**Start MCP Server:**
```bash
docker-compose up -d mcp-server
```

**Check MCP Status:**
```bash
curl http://localhost:8766/health
```

## 📊 Progress Tracking

Update these files as you work:

1. `.cline/progress/tasks-completed.json` - Mark tasks as done
2. `.cline/progress/completion-status.json` - Track overall progress

### ⚠️ CRITICAL: How to Update JSON Files Correctly

**🚨 DO NOT use append commands like `echo >>` - they will corrupt the JSON!**

**CORRECT METHOD:**
1. Read the entire JSON file
2. Modify the specific fields you need to change
3. Write the ENTIRE valid JSON back (overwrite, not append)
4. Ensure proper formatting - valid JSON with no extra characters

## 💡 Cline Best Practices

- **Use Plan Mode First**: Review changes before executing
- **Break Down Tasks**: Smaller, focused tasks work better
- **Reference Context**: Always mention the context files
- **Checkpoint Often**: Use git commits as checkpoints
- **Browser Testing**: Cline can use headless browser for verification

## 🖥️ Cline CLI Tips

```bash
# Run with specific instructions
cline "Implement the UserService from .cline/instructions/actionable-instructions.md"

# Use in scripts/CI
cline --non-interactive "Run tests and fix any failures"

# Multiple instances for parallel work
cline --workspace ./frontend "Build the dashboard component" &
cline --workspace ./backend "Create the API endpoints" &
```

## 🔒 Security Reminders

- Never commit sensitive data (API keys, passwords)
- Use environment variables for configuration
- Validate all user inputs
- Implement proper authentication and authorization
- Follow OWASP security best practices

## 📚 Resources

- Cline Documentation: https://docs.cline.bot/
- Cline CLI: https://docs.cline.bot/cline-cli/overview
- MCP Servers: https://docs.cline.bot/mcp/configuring-mcp-servers
- Framework Docs: Check `.cline/context/framework-config.json` for links

---

**Ready to start!** Use Plan Mode to review, then Act Mode to execute. 🚀
