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

### Phase 1: Discovery & Planning
1. **Interactive Requirements Gathering** - AI asks clarifying questions before proceeding
2. **Create Business PRD** - For user-facing features and business requirements
3. **Create Technical Specs** - For complex technical problems and system integrations
4. **Generate Task Breakdown** - Convert requirements into actionable, testable tasks

### Phase 2: Structured Implementation  
5. **Step-by-Step Task Execution** - One sub-task at a time with explicit user approval
6. **Test-First Development** - Write tests before implementation for each task
7. **Quality Gate Verification** - Automated checks before task completion
8. **Progressive Commits** - Structured commit messages with full traceability

### Phase 3: Continuous Verification
9. **Regression Protection** - Ensure new changes don't break existing functionality
10. **Integration Verification** - Test how components work together
11. **Progress Tracking** - Comprehensive documentation and progress summaries

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
