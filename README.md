# 🚀 Rigour Vibe: Complete Development Methodology 🧪

**The ultimate hybrid: Vibe Coding's speed + Spec-Then-Code's reliability + Interactive Development**

Rigour Vibe is a comprehensive development methodology that combines the streamlined workflow of Vibe Coding PRD with the rigorous testing and verification approach of Spec-Then-Code. It provides end-to-end coverage from initial planning through implementation to commit, with interactive questioning and adaptive complexity handling.

## 🎯 Philosophy

Traditional approaches force you to choose:
- **Vibe Coding**: Fast but can break complex features
- **Spec-Then-Code**: Rigorous but heavy for straightforward tasks

**Rigour Vibe** adapts to your project's complexity while maintaining quality through incremental testing.

## 🧭 The Rigour Approach

### Core Principles

1. **Start Light, Scale Rigor**: Begin with PRD-style planning, then add testing rigor as complexity demands
2. **Test-Driven Progression**: Every task must have passing tests before moving to the next
3. **Incremental Verification**: Build up a test suite that validates all previous work
4. **Adaptive Detail**: Simple tasks get simple tests, complex tasks get comprehensive specs

### When to Use Rigour Vibe

- **Medium to High Complexity Projects**: More than a single commit but not mission-critical systems
- **Feature Development**: Building substantial features that need reliability
- **Team Collaboration**: Projects where multiple developers or AI agents will work together
- **Iterative Development**: When requirements may evolve but quality can't be compromised

## 🔄 The Complete Rigour Workflow

### Decision Tree: Which Document Type to Start With?

**START HERE:** What type of work are you doing?

#### Path A: Business Feature Development
```
New Feature → User Story → Business Requirements
↓
Use: rvb-create-prd.mdc
Creates: PRD document
↓
Use: rvb-generate-tasks.mdc (reference the PRD)
Creates: Task breakdown based on business requirements
```

#### Path B: Technical Problem Solving  
```
Bug Fix → Performance Issue → Integration → Refactoring
↓
Use: rvb-create-spec.mdc
Creates: Technical specification document
↓
Use: rvb-generate-tasks.mdc (reference the Spec)
Creates: Task breakdown based on technical analysis
```

#### Path C: Complex Business Feature (Hybrid Approach)
```
Complex Business Feature with Technical Challenges
↓
1. Use: rvb-create-prd.mdc (define business requirements)
2. Use: rvb-create-spec.mdc (analyze technical implementation)
↓
Use: rvb-generate-tasks.mdc (reference BOTH documents)
Creates: Comprehensive task breakdown
```

### Sequential Workflow Steps

#### Phase 1: Requirements & Planning
1. **Choose Your Starting Document:**
   - **Business Feature**: `@rvb-create-prd.mdc` → Creates PRD
   - **Technical Problem**: `@rvb-create-spec.mdc` → Creates Spec  
   - **Complex Feature**: Both PRD first, then Spec

2. **Generate Tasks:**
   - `@rvb-generate-tasks.mdc` → Reference your PRD and/or Spec
   - AI creates high-level tasks → waits for your "Go" → creates detailed subtasks

#### Phase 2: Implementation
3. **Execute Tasks:**
   - `@rvb-process-tasks.mdc` → Step-by-step execution with quality gates
   - OR `@rvb-implement-task.mdc` → Individual task implementation

4. **Verify Progress:**
   - `@rvb-verify-progress.mdc` → Continuous quality checks

#### Phase 3: Documentation
5. **Commit Changes:**
   - `@rvb-commit-message.mdc` → Structured commit messages

## 📁 File Structure

```
project-root/
├── rigour_vibe/                 # Framework files
│   ├── README.md                # This file
│   ├── QUICK-START.md          # Getting started guide
│   ├── prompts/
│   │   ├── rvb-create-prd.mdc  # Interactive PRD creation with complexity assessment
│   │   ├── rvb-create-spec.mdc # Technical specification for complex problems
│   │   ├── rvb-generate-tasks.mdc # Two-phase task generation with user approval
│   │   ├── rvb-process-tasks.mdc # Step-by-step task execution protocol
│   │   ├── rvb-implement-task.mdc # Test-first task implementation
│   │   ├── rvb-verify-progress.mdc # Progressive verification and regression testing
│   │   └── rvb-commit-message.mdc # Structured commit message generation
│   ├── templates/
│   │   ├── rigour-prd-template.md # PRD template with testing considerations
│   │   ├── task-with-tests.md   # Task template including test requirements
│   │   └── verification-checklist.md # Quality gate checklist
│   └── examples/
│       ├── simple-feature-example/ # Example of light-touch rigour approach
│       └── complex-feature-example/ # Example of full rigorous approach
├── directives/                  # Generated project files (created when using framework)
│   ├── prd/                     # Product Requirements Documents
│   │   └── YYYY-MM-DD_prd_feature-name.md
│   ├── spec/                    # Technical Specifications (NEW)
│   │   └── YYYY-MM-DD_spec_feature-name.md
│   ├── tasks/                   # Task breakdowns and plans
│   │   └── YYYY-MM-DD_task_feature-name.md
│   ├── tests/                   # Test specifications and results
│   │   └── YYYY-MM-DD_test_feature-name_task-id.md
│   └── summaries/               # Implementation summaries and reports
│       └── YYYY-MM-DD_summary_feature-name_task-id.md
└── [your-project-files]/        # Your actual project code
```

## 📋 File Organization System

### Directory Structure
All generated project files are organized in the `../directives/` folder (sibling to rigour_vibe) with the following subfolders:

- **`prd/`** - Product Requirements Documents for business features
- **`spec/`** - Technical Specifications for complex technical problems 
- **`tasks/`** - Task breakdowns and implementation plans  
- **`tests/`** - Test specifications, results, and coverage reports
- **`summaries/`** - Implementation summaries and progress reports

### File Naming Convention
**Format:** `YYYY-MM-DD_<filetype>_<feature-or-task>.md`

**Components:**
- **Date**: ISO format (YYYY-MM-DD) for chronological organization
- **File Type**: `prd`, `spec`, `task`, `test`, or `summary`
- **Feature/Task**: Descriptive identifier (lowercase, hyphen-separated)

**Examples:**
- `2025-07-09_prd_user-authentication.md` (Business requirements)
- `2025-07-09_spec_payment-api-integration.md` (Technical specification)
- `2025-07-09_task_user-authentication.md` (Implementation tasks)
- `2025-07-09_test_user-authentication_login-flow.md` (Test specifications)
- `2025-07-09_summary_user-authentication_task-1-2.md` (Implementation summary)
- `2025-07-09_summary_user-authentication_task-1-2.md`

### Framework vs Project Files
- **Framework files** stay in `rigour_vibe/` (methodology, prompts, templates)
- **Project files** are created in `../directives/` (PRDs, specs, tasks, tests, summaries)
- This separation keeps the framework clean and reusable across projects

## 📋 Document Types & When to Use

### PRD vs Specification
**Use PRD Creation (`rvb-create-prd.mdc`) for:**
- New feature development
- User-facing functionality  
- Business requirement driven changes
- Features with clear user stories

**Use Specification Creation (`rvb-create-spec.mdc`) for:**
- Bug fixes requiring root cause analysis
- Technical refactoring or architectural changes
- Integration with external systems
- Performance optimization
- Security enhancements
- Complex technical problems needing investigation

## 🎚️ Adaptive Rigor Levels

### Level 1: Light Touch (Simple Features)
- Basic PRD with acceptance criteria
- Unit tests for core functionality
- Integration smoke tests
- **Use when**: UI changes, simple CRUD, configuration updates

### Level 2: Balanced Rigor (Standard Features)
- Detailed PRD with edge cases
- Comprehensive unit test coverage
- Integration tests for key workflows
- Error handling verification
- **Use when**: Business logic, API endpoints, data processing

### Level 3: Full Rigor (Complex/Critical Features)
- Comprehensive specification document
- TDD with red-green-refactor cycle
- End-to-end test scenarios
- Performance and security testing
- **Use when**: Authentication, payment processing, data migration

## 🔧 Quality Gates

Each task must pass these gates before proceeding:

### ✅ Task Completion Gate
- [ ] Tests written and initially failing (red)
- [ ] Implementation makes tests pass (green)
- [ ] Code refactored for maintainability
- [ ] All previous tests still pass
- [ ] Code review criteria met

### ✅ Feature Completion Gate
- [ ] All task tests passing
- [ ] Integration tests passing
- [ ] Documentation updated
- [ ] Performance acceptable
- [ ] Security considerations addressed

### ✅ Release Readiness Gate
- [ ] Full test suite passing
- [ ] End-to-end scenarios verified
- [ ] Error handling robust
- [ ] Monitoring/logging in place
- [ ] Rollback plan defined

## 🚦 Traffic Light System

**🟢 Green Light**: Simple, low-risk tasks
- Minimal testing requirements
- Focus on velocity
- Quick verification

**🟡 Yellow Light**: Moderate complexity tasks
- Balanced testing approach
- Integration considerations
- Careful verification

**🔴 Red Light**: Complex, high-risk tasks
- Full spec-then-code rigor
- Comprehensive testing
- Multiple verification rounds

## 🎯 Benefits

- **Interactive Planning**: AI asks clarifying questions before starting work
- **Adaptive Complexity**: Automatically scales rigor based on project needs
- **Complete Coverage**: End-to-end workflow from planning to commit
- **Quality Assurance**: Built-in testing and verification at every step
- **Velocity**: Start coding quickly without over-engineering
- **Traceability**: Clear links between requirements, tasks, and implementation
- **Collaboration**: Explicit human-AI coordination points with approval gates
- **Maintainability**: Built-in regression protection and comprehensive documentation
- **Flexibility**: Handles both business features and complex technical problems

## 🔗 Integration with IDEs

### Cursor/Windsurf Workflows
Use the `.mdc` prompts as workflows:
- `rvb create user authentication system`
- `rvb generate tasks for @user-auth-prd.md`
- `rvb implement task 1.1 with tests`

### VS Code Integration
Copy prompts into your workspace as reusable templates.

## 🎉 Getting Started

### Quick Decision Guide

**I want to build a new feature for users**
→ Start with `@rvb-create-prd.mdc`

**I need to fix a bug or technical issue**  
→ Start with `@rvb-create-spec.mdc`

**I'm building something complex with both business and technical challenges**
→ Start with `@rvb-create-prd.mdc`, then `@rvb-create-spec.mdc`

**I want to build a complete app in one shot (prototype/MVP)**
→ Use the **Single-Shot App Workflow** below

### 🚀 Single-Shot App Workflow (MVP/Prototype)

For when you want to build a complete app quickly with minimal overhead:

```
1. @rvb-create-prd.mdc "Build a [app description]"
   → AI asks clarifying questions focused on core features
   → Creates streamlined PRD with Light Touch rigor level
   → Focus on essential features only

2. @rvb-generate-tasks.mdc [reference the PRD]
   → AI creates 3-5 high-level tasks maximum
   → User approves with "Go"
   → AI creates minimal but sufficient subtasks

3. @rvb-process-tasks.mdc
   → Executes all tasks with Light Touch quality gates
   → Minimal testing (smoke tests + core functionality)
   → Fast iteration with user approval gates

4. Optional: @rvb-commit-message.mdc
   → Single commit for the entire app
```

**Single-Shot Characteristics:**
- ✅ Light Touch rigor level (fastest)
- ✅ Core functionality focus
- ✅ Minimal but sufficient testing
- ✅ 3-5 main tasks maximum
- ✅ Same day completion target
- ✅ Prototype/MVP quality standards

### Example Workflows

#### Simple Business Feature
```
1. @rvb-create-prd.mdc "Add user profile editing"
   → Creates: ../directives/prd/2025-07-09_prd_user-profile-editing.md

2. @rvb-generate-tasks.mdc [reference the PRD file]
   → Creates: ../directives/tasks/2025-07-09_task_user-profile-editing.md

3. @rvb-process-tasks.mdc
   → Executes tasks step-by-step with quality gates
```

#### Technical Problem
```
1. @rvb-create-spec.mdc "Database queries are slow on user search"
   → Creates: ../directives/spec/2025-07-09_spec_user-search-performance.md

2. @rvb-generate-tasks.mdc [reference the Spec file]  
   → Creates: ../directives/tasks/2025-07-09_task_user-search-performance.md

3. @rvb-process-tasks.mdc
   → Executes optimization tasks with testing
```

#### Complex Feature (Hybrid)
```
1. @rvb-create-prd.mdc "Add real-time chat system"
   → Creates: ../directives/prd/2025-07-09_prd_realtime-chat.md

2. @rvb-create-spec.mdc "Implement WebSocket architecture for chat" 
   → Creates: ../directives/spec/2025-07-09_spec_websocket-chat-architecture.md

3. @rvb-generate-tasks.mdc [reference BOTH the PRD and Spec files]
   → Creates: ../directives/tasks/2025-07-09_task_realtime-chat.md
   → Combines business requirements with technical implementation plan

4. @rvb-process-tasks.mdc
   → Executes comprehensive implementation plan
```

### Key Rules

1. **Always generate tasks AFTER creating your requirements documents**
2. **Reference the specific document files when generating tasks**
3. **For complex features, create PRD first (business requirements), then Spec (technical analysis)**
4. **The task generator can reference multiple documents - just mention both files**

### Original Getting Started (Alternative Approach)

### 1. Choose Your Document Type
- **For Business Features**: Use `@rvb-create-prd.mdc`
- **For Technical Problems**: Use `@rvb-create-spec.mdc`

### 2. Planning Phase
**Business Feature Example:**
- `@rvb-create-prd.mdc` → AI asks clarifying questions, then creates PRD
- Creates: `../directives/prd/YYYY-MM-DD_prd_feature-name.md`

**Technical Problem Example:**
- `@rvb-create-spec.mdc` → AI investigates technical requirements
- Creates: `../directives/spec/YYYY-MM-DD_spec_feature-name.md`

### 3. Task Generation
- `@rvb-generate-tasks.mdc` → AI creates high-level tasks, waits for approval, then detailed subtasks
- Creates: `../directives/tasks/YYYY-MM-DD_task_feature-name.md`

### 4. Implementation Phase
**Structured Task Execution:**
- `@rvb-process-tasks.mdc` → Step-by-step execution with quality gates
- AI does one subtask at a time, waits for your approval before proceeding

**Test-First Implementation:**
- `@rvb-implement-task.mdc` → Test-driven development for each task
- Creates: `../directives/tests/YYYY-MM-DD_test_feature-name_task-id.md`
- Creates: `../directives/summaries/YYYY-MM-DD_summary_feature-name_task-id.md`

### 5. Quality & Progress
**Continuous Verification:**
- `@rvb-verify-progress.mdc` → Progressive quality checks and regression testing

**Structured Commits:**
- `@rvb-commit-message.mdc` → Comprehensive commit messages with traceability

## 🚦 Complete Workflow Example

```
1. User: "@rvb-create-prd.mdc I want to add user authentication"
   → AI asks clarifying questions
   → Creates comprehensive PRD with testing strategy

2. User: "@rvb-generate-tasks.mdc [reference to PRD]"
   → AI creates high-level tasks
   → User approves with "Go"
   → AI creates detailed subtasks with test requirements

3. User: "@rvb-process-tasks.mdc"
   → AI implements first subtask
   → Waits for user approval
   → Continues systematically through all tasks

4. User: "@rvb-commit-message.mdc"
   → AI generates structured commit with full traceability
```

## 📚 Learn More

- **Vibe Coding PRD**: For understanding the streamlined planning approach with interactive questioning
- **Spec-Then-Code**: For deep-dive into rigorous development methodology and technical specifications
- **Examples**: See the `examples/` directory for real-world applications

## 🆕 What's New in This Version

### Enhanced Interactive Experience
- **Clarifying Questions**: AI now asks comprehensive questions before creating PRDs or specs
- **Two-Phase Planning**: Task generation gets user approval before detailed breakdown
- **Step-by-Step Execution**: Implementation proceeds one subtask at a time with explicit approval

### Complete Workflow Coverage
- **Dual Document Types**: Both PRDs (business) and Specs (technical) supported
- **Task Processing Protocol**: Structured execution with quality gates and git workflow
- **Commit Message Generation**: Automatic creation of comprehensive, traceable commit messages

### Quality & Traceability
- **Progressive Testing**: Built-in test requirements and regression protection
- **Documentation Generation**: Automatic creation of test specs and implementation summaries
- **Full Traceability**: Clear links from requirements through tasks to commits

---

*Now with complete end-to-end development methodology! 🚀*
