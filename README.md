# 🚀 Rigour Vibe: Streamlined Rigorous Development 🧪

**The best of both worlds: Vibe Coding's speed + Spec-Then-Code's reliability**

Rigour Vibe combines the streamlined workflow of Vibe Coding PRD with the rigorous testing and verification approach of Spec-Then-Code. This methodology provides a balanced approach for development projects that need both velocity and quality assurance.

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

## 🔄 The Rigour Workflow

### Phase 1: Discovery & Planning (Vibe Style)
1. **Create Lightweight PRD** - Define what you're building and why
2. **Generate Task Breakdown** - Break into implementable chunks
3. **Risk Assessment** - Identify which tasks need rigorous testing

### Phase 2: Test-First Implementation (Spec Style)
4. **Write Tests Per Task** - Define success criteria before coding
5. **Implement & Verify** - Code to pass tests, verify all previous tests still pass
6. **Progressive Commits** - Commit only when all tests pass

### Phase 3: Quality Gates
7. **Regression Protection** - Ensure new changes don't break existing functionality
8. **Integration Verification** - Test how components work together
9. **Completion Audit** - Verify all PRD requirements are met

## 📁 File Structure

```
project-root/
├── rigour_vibe/                 # Framework files
│   ├── README.md                # This file
│   ├── QUICK-START.md          # Getting started guide
│   ├── prompts/
│   │   ├── rvb-create-prd.mdc  # Enhanced PRD creation with test planning
│   │   ├── rvb-generate-tasks.mdc # Task generation with test requirements
│   │   ├── rvb-implement-task.mdc # Test-first task implementation
│   │   └── rvb-verify-progress.mdc # Progressive verification and regression testing
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

- **`prd/`** - Product Requirements Documents
- **`tasks/`** - Task breakdowns and implementation plans  
- **`tests/`** - Test specifications, results, and coverage reports
- **`summaries/`** - Implementation summaries and progress reports

### File Naming Convention
**Format:** `YYYY-MM-DD_<filetype>_<feature-or-task>.md`

**Components:**
- **Date**: ISO format (YYYY-MM-DD) for chronological organization
- **File Type**: `prd`, `task`, `test`, or `summary`
- **Feature/Task**: Descriptive identifier (lowercase, hyphen-separated)

**Examples:**
- `2025-07-08_prd_user-authentication.md`
- `2025-07-08_task_user-authentication.md`
- `2025-07-08_test_user-authentication_login-flow.md`
- `2025-07-08_summary_user-authentication_task-1-2.md`

### Framework vs Project Files
- **Framework files** stay in `rigour_vibe/` (methodology, prompts, templates)
- **Project files** are created in `../directives/` (PRDs, tasks, tests, summaries)
- This separation keeps the framework clean and reusable across projects

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

- **Velocity**: Start coding quickly without over-engineering
- **Quality**: Progressive testing ensures reliability
- **Adaptability**: Scale rigor based on actual complexity
- **Maintainability**: Built-in regression protection
- **Confidence**: Know your code works before moving forward
- **Collaboration**: Clear handoff points for team development

## 🔗 Integration with IDEs

### Cursor/Windsurf Workflows
Use the `.mdc` prompts as workflows:
- `rvb create user authentication system`
- `rvb generate tasks for @user-auth-prd.md`
- `rvb implement task 1.1 with tests`

### VS Code Integration
Copy prompts into your workspace as reusable templates.

## 🎉 Getting Started

1. **Identify Your Project's Complexity Level**
2. **Start with PRD Creation**: `@rvb-create-prd.mdc`
   - Creates: `../directives/prd/YYYY-MM-DD_prd_feature-name.md`
3. **Generate Test-Aware Tasks**: `@rvb-generate-tasks.mdc`
   - Creates: `../directives/tasks/YYYY-MM-DD_task_feature-name.md`
4. **Implement with Progressive Testing**: `@rvb-implement-task.mdc`
   - Creates: `../directives/tests/YYYY-MM-DD_test_feature-name_task-id.md`
   - Creates: `../directives/summaries/YYYY-MM-DD_summary_feature-name_task-id.md`
5. **Verify and Progress**: `@rvb-verify-progress.mdc`
   - Updates existing files and creates progress summaries

## 📚 Learn More

- **Vibe Coding PRD**: For understanding the streamlined planning approach
- **Spec-Then-Code**: For deep-dive into rigorous development methodology
- **Examples**: See the `examples/` directory for real-world applications

---

*Happy coding with confidence! 🚀*
