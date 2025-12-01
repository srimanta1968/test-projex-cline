# Quick Prototype Sprint - Cline Export

## 📦 Export Configuration

- **CLI Tool:** Cline
- **Export Mode:** new_repository
- **Export Scope:** full_sprint
- **Selected Purposes:** api_development, ui_development, unit_tests, db_schema_design

## 📋 Sprint Information

- **Sprint:** Quick Prototype Sprint
- **Project:** Rider App
- **Total Tasks:** 27

## 🔒 Security

This export includes a `.clineignore` file that **protects sensitive files** from AI access:
- `.env` files (environment variables with secrets)
- API keys, credentials, certificates
- Database files and backups
- SSH keys and tokens

**The AI cannot read or modify ignored files.** This is a security feature to prevent accidental exposure of secrets.



## 📁 Initial Project Setup

**Before starting code generation, set up your project:**

```bash
# 1. Copy .gitignore template (IMPORTANT: prevents committing sensitive files)
cp .gitignore.example .gitignore

# 2. Copy environment variables template (customize with your values)
cp .env.example .env

# 3. Edit .env with your actual configuration values
# NEVER commit .env to git - it contains secrets!
```

**🚨 CRITICAL: Your .gitignore includes protection for:**
- `.env` files (secrets and credentials)
- `.projexlight/feedback/logs/` (CLI export logs)
- `mcp-server/feedback/logs/` (MCP server logs)
- `node_modules/`, `dist/`, `build/` (dependencies and build artifacts)
- IDE files (`.vscode/`, `.idea/`)

---

## 🔧 Git Setup (CRITICAL)

**Git is required for progress tracking and pre-commit hooks.**

### Step 1: Verify Git Installation

```bash
# Check if git is installed
git --version
```

**If git is not installed:**
- **Windows:** Download from https://git-scm.com/download/win
- **macOS:** Run `brew install git` or download from https://git-scm.com/download/mac
- **Linux:** Run `sudo apt-get install git` or `sudo yum install git`

### Step 2: Initialize Git Repository

```bash
# The MCP server will auto-initialize git, but you can also do it manually:
git init

# Set your identity (if not already configured)
git config user.name "Your Name"
git config user.email "your.email@example.com"
```

### Step 3: Pre-Commit Hook (Auto-Installed)

The MCP server automatically installs a pre-commit hook that:
1. **Scans for duplicate APIs** before each commit
2. **Updates task progress** if you forget to update status files
3. **Enforces code quality** checks

**If git hooks are not working:**
```bash
# Manually install hooks from the MCP server templates
cp mcp-server-template/templates/pre-commit .git/hooks/pre-commit
cp mcp-server-template/templates/pre-push .git/hooks/pre-push
chmod +x .git/hooks/*
```

### Step 4: Commit After Each Task

**🚨 IMPORTANT:** Commit after completing each sub-task!

```bash
# After each sub-task completion:
git add .
git commit -m "Complete task-N sub-task M: [Brief description]"
git push
```

**Example commit messages:**
```bash
git commit -m "Complete task-0 sub-task 2: Created User model and service"
git commit -m "Complete task-1 sub-task 3: Implemented API routes for products"
```

**Why this matters:**
- Pre-commit hook updates progress if LLM forgot
- Next session knows exactly where to resume
- Your work is backed up to the repository


## 🚀 Quick Start

### First Run (Session 1):

Use the detailed generation plan for the FIRST session only:

```bash
# First time - creates actionable-instructions.md
# Run your CLI tool with .cline/instructions/generation-plan.md
```

### Subsequent Runs (Session 2+):

**⚠️ IMPORTANT:** For all sessions (new or resume), use the same command:

```bash
# Works for both new and resume sessions!
# Run your CLI tool with .cline/instructions/generation-plan.md
```

**Why one file?** The generation-plan.md automatically detects if you're starting fresh or resuming:
- Checks if `..cline/progress/tasks-completed.json` exists
- **If NO**: Runs full planning and starts code generation
- **If YES**: Skips planning, reads progress, continues from where you left off

**No need to remember different commands!** The same file works intelligently for both scenarios.

---

## 🖥️ Cross-Platform Development Server

Your export includes **cross-platform startup scripts** that automatically:
1. Load environment variables from `.env`
2. Install dependencies (npm, pip, composer, etc.)
3. Build/compile your project
4. Start the development server
5. Run health checks

### Start Your Server (Required for Git Push):

**Windows (PowerShell/CMD):**
```powershell
# Start server
.projexlight\scripts\start-server.bat

# Or use PowerShell directly
powershell -ExecutionPolicy Bypass -File .projexlight\scripts\start-server.ps1
```

**macOS / Linux:**
```bash
# Start server
./.projexlight/scripts/start-server.sh

# Stop server
./.projexlight/scripts/stop-server.sh

# Check status
./.projexlight/scripts/server-status.sh
```

### Important Notes:
- **Git Push Requires Running Server**: The pre-push hook will block pushes if your dev server is not running
- **Auto-Detection**: Scripts automatically detect your framework (Express, FastAPI, Spring Boot, etc.)
- **Configuration**: Server settings are in `.projexlight/scripts/server-config.json`
- **Logs**: Startup logs are saved to `.projexlight/logs/server-startup.log`

### Exit Codes (for debugging):
- `0` = Success
- `1` = Dependency installation failed
- `2` = Build/compilation failed (fix syntax/type errors)
- `3` = Server failed to start (check configuration)
- `4` = Health check failed (server not responding)

1. Extract this package to your project directory
2. Review the generation plan: `.cline/instructions/generation-plan.md`
3. Run Cline with the provided instructions
4. Follow the merge strategy guide (if team member export)

## 📁 Package Structure

```
📦 Project Root
├── .projexlight/           # 🔒 READ-ONLY Source of Truth
│   ├── context/
│   │   ├── requirements.md          # ✅ Original requirements & acceptance criteria
│   │   └── sprint-context.json      # Sprint metadata
│   ├── schemas/
│   │   └── user-defined-schemas.sql      # ✅ User database schemas
│   └── config/
│       ├── framework.json           # Tech stack configuration
│       └── export-config.json       # Export settings
│
├── .cline/              # 📝 Cline-Specific Config & Progress
│   ├── instructions/
│   │   ├── generation-plan.md       # Smart instructions (auto-detects new vs resume)
│   │   └── actionable-instructions.md # Generated task breakdown (created in Session 1)
│   ├── progress/
│   │   ├── tasks-completed.json     # Overall progress tracker
│   │   └── major-tasks/
│   │       ├── task-0.json          # Foundation setup
│   │       ├── task-1.json          # Feature tasks
│   │       └── task-N.json
│   ├── logs/
│   │   └── error-session-*.md       # Error logs (if any)
│   └── config/
│       └── (tool-specific configs)
│
├── init-scripts/              # 🆕 Auto-loaded by Docker
│   ├── 01-schema.sql          # Database schema (auto-runs on first start)
│   └── 02-sample-data.sql     # Sample data (if available)
│
└── README.md                   # This file
```

### 🔒 Important: Two Separate Folders

**.projexlight/ (READ-ONLY Source of Truth)**
- Contains original requirements, schemas, and configurations
- ✅ LLMs read from here to understand WHAT to build
- ❌ Never modify these files - they are the source of truth
- All CLI tools (Cline, Goose, Cursor, etc.) reference this same folder

**.cline/ (Cline Config & Progress)**
- Contains Cline-specific instructions and progress tracking
- ✅ LLMs write progress updates here
- ✅ Contains generated task breakdowns
- Each CLI tool has its own config folder (.cline/, .goose/, .cursor/, etc.)
```

## ⚠️ Important Notes

- Cline supports both VS Code Extension and standalone CLI modes
- Uses Plan & Act workflow for structured development
- Native MCP (Model Context Protocol) integration
- Multi-model support (Claude, GPT-4, Gemini, etc.)
- Supports headless browser automation for testing
- Can be used in CI/CD pipelines

### 🗄️ Database Auto-Setup

The `init-scripts/` folder contains SQL files that are **automatically executed** when you first start the Docker container:

1. **01-schema.sql** - Creates all database tables, indexes, and constraints
2. **02-sample-data.sql** - Inserts sample data (if available in your schema)

**How it works:**
- PostgreSQL/MySQL/MariaDB containers automatically run all `.sql` files in `/docker-entrypoint-initdb.d/` on first startup
- Files are executed in alphabetical order (01, 02, etc.)
- This only happens on **first run** when the database volume is empty
- To re-run: `docker-compose down -v` (⚠️ deletes all data) then `docker-compose up -d`


## 🔧 Troubleshooting

### Session Failures & Recovery

**🚨 If your session fails or is interrupted:**

#### Step 1: Assess the Situation
```bash
# Check your progress
cat .cline/progress/tasks-completed.json

# Count generated files
find server client tests -name "*.ts" -o -name "*.tsx" 2>/dev/null | wc -l

# View remaining tasks
cat .cline/instructions/actionable-instructions.md
```

#### Step 2: Understand the Error Type

**Network/API Errors** (most common):
- Error: "Request failed: error sending request"
- Error: "Connection timeout"
- Error: "API rate limit exceeded"
- **Action:** Wait 1-5 minutes, then resume

**File System Errors:**
- Error: "Permission denied"
- Error: "File exists"
- **Action:** Fix permissions, remove duplicates, then resume

**Configuration Errors:**
- Error: "API key not found"
- Error: "Invalid configuration"
- **Action:** Check environment variables and API keys

#### Step 3: Resume Session

**🎯 SAME COMMAND AS BEFORE:**
```bash
# Run your CLI tool with .cline/instructions/generation-plan.md
```

**This command will automatically:**
- ✅ Detect that progress files exist
- ✅ Read your current progress
- ✅ Skip all completed sub-tasks
- ✅ Continue from where it stopped
- ✅ NOT create duplicate files
- ✅ Complete remaining work

#### Step 4: If Resume Fails Multiple Times

**After 3 failed resume attempts:**

1. **Check your environment:**
   ```bash
   # Internet connection
   ping -c 3 8.8.8.8

   # API connectivity (for OpenAI)
   curl -I https://api.openai.com/v1/models

   # Check API key is set
   echo $OPENAI_API_KEY

   # Disk space
   df -h .
   ```

2. **Verify progress files are valid:**
   ```bash
   # Check if progress file is valid JSON
   cat .cline/progress/tasks-completed.json | jq .

   # If broken, you may need to regenerate (rare)
   ```

3. **Contact support or continue manually:**
   - Review remaining tasks in `.cline/instructions/actionable-instructions.md`
   - Complete manually or use focused prompts

### Common Issues & Solutions

#### Issue 1: "mkdir: cannot create directory: File exists"
**Cause:** Trying to create folders that already exist
**Solution:**
```bash
# This is usually harmless, just continue with the same command
# Run your CLI tool with .cline/instructions/generation-plan.md
```

#### Issue 2: "Port 5432 already in use"
**Cause:** Local database or another container using the same port
**Solution:** See "Port Conflict Resolution" section above

#### Issue 3: Session creates duplicate files
**Cause:** Progress files were not created or were deleted
**Solution:**
```bash
# The generation-plan.md auto-detects and resumes correctly
# Make sure ..cline/progress/ folder exists with tasks-completed.json
# Run your CLI tool with .cline/instructions/generation-plan.md
```

#### Issue 4: "Cannot find module" or import errors
**Cause:** Dependencies not installed
**Solution:**
```bash
# Install dependencies first
npm install
# or for Python
pip install -r requirements.txt
```

#### Issue 5: Database connection failed
**Cause:** Docker not running or database not started
**Solution:**
```bash
# 1. Check Docker is running
docker ps

# 2. Start database
docker-compose up -d

# 3. Wait 10 seconds for database to initialize

# 4. Verify database is ready
docker-compose logs | tail -20

# 5. Test connection (if applicable)
# TypeScript/JavaScript:
npx ts-node server/src/config/testConnection.ts
# Python:
python server/config/testConnection.py
# Java:
mvn exec:java -Dexec.mainClass="config.TestConnection"
# Go:
go run server/config/testConnection.go
```

#### Issue 6: LLM stopped generating code mid-file
**Cause:** Token limit reached or API timeout
**Solution:** Your progress is saved! Just continue with the same command:
```bash
# Run your CLI tool with .cline/instructions/generation-plan.md
```

### Health Check

**Run this to diagnose issues:**
```bash
# Check all prerequisites
echo "=== Environment Check ==="
echo -n "Node.js: "; node --version 2>/dev/null || echo "NOT FOUND"
echo -n "npm: "; npm --version 2>/dev/null || echo "NOT FOUND"
echo -n "Docker: "; docker --version 2>/dev/null || echo "NOT FOUND"

echo ""
echo "=== API Check ==="
echo -n "API Key Set: "; [ -n "$OPENAI_API_KEY" ] && echo "YES" || echo "NO"

echo ""
echo "=== Progress Check ==="
[ -f ".cline/progress/tasks-completed.json" ] && echo "Progress file: EXISTS" || echo "Progress file: NOT FOUND"
[ -f ".cline/instructions/actionable-instructions.md" ] && echo "Instructions: EXISTS" || echo "Instructions: NOT FOUND"

echo ""
echo "=== Files Generated ==="
find server client tests -name "*.ts" -o -name "*.tsx" 2>/dev/null | wc -l | xargs echo "TypeScript files:"
```

### Getting Help

**Before asking for help, please:**
1. ✅ Run the health check above
2. ✅ Check `.cline/progress/tasks-completed.json`
3. ✅ Review `.cline/logs/` for error logs
4. ✅ Try resuming at least once

**When reporting issues, include:**
- Session ID (shown at start)
- Error message (exact text)
- Output of health check
- Contents of `.cline/progress/tasks-completed.json`
- What you were trying to do

### Remember

**✅ Your progress is ALWAYS saved!**
- Never delete files unless certain they're corrupted
- Always resume using the same `generation-plan.md` command
- Session interruptions are normal and recoverable
- The system tracks your progress automatically in JSON files

## 📚 Documentation

For more information, see:
- [Cline Documentation](https://docs.cline.bot/)
- ProjexLight CLI Export Guide
- Troubleshooting: See analysis at `.cline/logs/` if errors occur

---
**Generated by ProjexLight CLI Export System**
**Export Date:** 2025-11-30T23:12:37.093Z
