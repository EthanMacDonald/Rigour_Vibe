# 🚀 Rigour Vibe Quick Start Guide

Get started with rigorous development - from single-shot apps to complex features!

## 🎯 Choose Your Development Style

### 🏃‍♂️ Single-Shot App (4-8 hours total)
**For**: MVPs, prototypes, personal projects, learning experiments
**Goal**: Working app by end of day

### 🏗️ Feature Development (days to weeks)  
**For**: Production features, team projects, business requirements
**Goal**: Reliable, maintainable, well-tested features

### 🔧 Technical Problems (varies)
**For**: Bug fixes, performance issues, architecture changes
**Goal**: Root cause analysis and systematic solutions

---

## 🚀 Single-Shot App Workflow

**Perfect for building a complete app in one focused session**

### ⚡ Quick Setup (2 minutes)
Answer these 4 questions:
1. **What are you building?** (Be specific but concise)
2. **Who will use it?** (Primary user type)  
3. **What's the core action?** (Main thing users do)
4. **How will you know it works?** (Success criteria)

### Step 1: Lightning PRD (15-30 minutes)
```bash
@rvb-create-prd.mdc "Build a [your app idea]"
```

**Examples:**
- "Build a todo app with drag-and-drop priority ordering"
- "Build a expense tracker that categorizes spending automatically"  
- "Build a team standup bot that collects daily updates"

**AI will:**
- Ask 4-6 focused questions
- Auto-select Light Touch complexity
- Focus on 3-5 core features only
- Create: `../directives/prd/2025-07-09_prd_your-app.md`

### Step 2: Rapid Tasks (10 minutes)
```bash
@rvb-generate-tasks.mdc [reference your PRD file]
```

**AI creates:**
- 3-5 high-level tasks maximum
- 2-3 subtasks each
- Light testing requirements
- Waits for your "Go" to proceed

### Step 3: Focused Implementation (3-6 hours)
```bash
@rvb-process-tasks.mdc
```

**AI systematically:**
- Does one subtask at a time
- Waits for approval between subtasks
- Uses Light Touch quality gates (fast!)
- Tests core functionality only

### Step 4: Ship It (5 minutes)
```bash
@rvb-commit-message.mdc
```

**Total Time: 4-8 hours for a working app! 🎉**

---

## 🏗️ Feature Development Workflow

**For production features and team collaboration**

### 1. Choose Your Complexity Level ⚖️

**Answer these quick questions:**

#### A. Risk Assessment
- **Low Risk:** Cosmetic changes, easy to fix if broken
- **Medium Risk:** Affects user workflows, moderate impact if broken  
- **High Risk:** Financial/security/data implications if broken

#### B. System Impact
- **Single Component:** Changes one file/component
- **Multiple Components:** Changes several related parts
- **Cross-System:** Integration across multiple systems

#### C. Timeline Pressure
- **Experimental:** Speed over perfection, prototype
- **Production:** Balanced approach, real feature
- **Mission-Critical:** Quality over speed, can't fail

**Your Level:**
- **Mostly Low + Single + Experimental = Light Touch (Level 1)**
- **Mix of Medium + Multiple + Production = Balanced Rigor (Level 2)**
- **Any High + Cross-System + Mission-Critical = Full Rigor (Level 3)**

### 2. Create Your PRD 📋

#### For Light Touch:
```bash
@rvb-create-prd.mdc "Feature: [Simple description]"
```

#### For Balanced/Full Rigor:
```bash
@rvb-create-prd.mdc "Feature: [Detailed description with risk factors]"
```

Creates: `../directives/prd/2025-07-09_prd_feature-name.md`

### 3. Generate Test-Aware Tasks 📝
```bash
@rvb-generate-tasks.mdc [reference your PRD file]
```

**AI creates:**
- High-level tasks based on complexity level
- Built-in test requirements
- Waits for your "Go" to generate detailed subtasks
- Creates: `../directives/tasks/2025-07-09_task_feature-name.md`

### 4. Implement with Tests First 🧪
```bash
@rvb-process-tasks.mdc
```

**OR for individual tasks:**
```bash
@rvb-implement-task.mdc
```

#### The Test-First Cycle:
1. **Red:** Write failing tests that describe what you want
2. **Green:** Write minimal code to make tests pass
3. **Refactor:** Clean up code while keeping tests passing
4. **Verify:** Run full test suite to catch regressions
5. **Document:** Create test specs and implementation summaries

**Creates per task:**
- `../directives/tests/2025-07-08_test_feature-name_task-1-1.md`
- `../directives/summaries/2025-07-08_summary_feature-name_task-1-1.md`

## 5. Verify Progress Continuously ✅

```
Use @rvb-verify-progress.mdc
Check: Overall progress and quality gates
```

### After Each Task:
- ✅ All new tests pass
- ✅ All old tests still pass  
- ✅ Task marked complete
- ✅ Changes committed

## Level-Specific Quick Guides

### Light Touch (Level 1) - 15 minutes setup
```bash
# 1. Simple PRD (5 min)
"Use @rvb-create-prd.mdc to add user profile photo upload"
# Creates: ../directives/prd/2025-07-08_prd_profile-photo-upload.md

# 2. Basic tasks (5 min)  
"Use @rvb-generate-tasks.mdc with @../directives/prd/2025-07-08_prd_profile-photo-upload.md"
# Creates: ../directives/tasks/2025-07-08_task_profile-photo-upload.md

# 3. Test-first implementation (5 min per task)
"Use @rvb-implement-task.mdc for task 1.1"
# Creates test specs and summaries per task
```

**Focus:** Core functionality + basic error handling + simple integration

### Balanced Rigor (Level 2) - 30 minutes setup
```bash
# 1. Detailed PRD (10 min)
"Use @rvb-create-prd.mdc to add user notification system with email/SMS"
# Creates: ../directives/prd/2025-07-08_prd_user-notifications.md

# 2. Comprehensive tasks (10 min)
"Use @rvb-generate-tasks.mdc with @../directives/prd/2025-07-08_prd_user-notifications.md"
# Creates: ../directives/tasks/2025-07-08_task_user-notifications.md

# 3. Test-driven implementation (10 min per task)
"Use @rvb-implement-task.mdc for task 1.1 with integration testing"
# Creates detailed test specs and summaries
```

**Focus:** Unit tests + integration tests + edge cases + performance

### Full Rigor (Level 3) - 60 minutes setup
```bash
# 1. Comprehensive PRD (20 min)
"Use @rvb-create-prd.mdc to add payment processing with PCI compliance"
# Creates: ../directives/prd/2025-07-08_prd_payment-processing.md

# 2. Detailed task breakdown (20 min)
"Use @rvb-generate-tasks.mdc with security and compliance requirements"
# Creates: ../directives/tasks/2025-07-08_task_payment-processing.md

# 3. TDD implementation (20 min per task)
"Use @rvb-implement-task.mdc with comprehensive test coverage"
# Creates extensive test documentation and summaries
```

**Focus:** TDD + security tests + performance tests + compliance + documentation

## 📁 File Organization Benefits

### Chronological Tracking
- Dates in filenames enable chronological project tracking
- Easy to see development timeline and progress
- Helps with version control and rollback scenarios

### Organized Documentation
- **`../directives/prd/`** - All requirements in one place
- **`../directives/tasks/`** - Implementation plans and breakdowns
- **`../directives/tests/`** - Test specifications and results
- **`../directives/summaries/`** - Implementation details and decisions

### Easy Navigation
```bash
# View all PRDs
ls ../directives/prd/

# Find specific feature tasks
ls ../directives/tasks/*user-auth*

# Review test results for a feature
ls ../directives/tests/*payment*

# Check implementation summaries
ls ../directives/summaries/2025-07-08*
```

### Team Collaboration
- Clear file naming makes handoffs easy
- Test specs provide context for new team members
- Implementation summaries capture decision rationale
- Organized structure scales with team size

## Common Commands by Project Type

### React/TypeScript Project
```bash
# Test commands to configure
npm test                    # Run all tests
npm run test:watch         # Run tests in watch mode
npm run test:coverage      # Generate coverage report
npm run lint               # Check code quality
npm run type-check         # TypeScript type checking
```

### Node.js/Express API
```bash
# Test commands to configure
npm test                    # Unit tests
npm run test:integration   # API integration tests
npm run test:e2e          # End-to-end tests
npm run security:audit    # Security vulnerability check
```

### Python/Django Project
```bash
# Test commands to configure  
pytest                     # Run all tests
pytest --cov              # Run with coverage
python manage.py test      # Django tests
bandit -r .               # Security scanning
```

## Quality Gate Checklist

### Gate 1: Foundation ✅
- [ ] Core functionality tests pass
- [ ] Basic integration verified
- [ ] No critical issues

### Gate 2: Feature Complete ✅  
- [ ] All feature tests pass
- [ ] User workflows verified
- [ ] Performance acceptable

### Gate 3: Release Ready ✅
- [ ] Complete test suite passes
- [ ] Security verified
- [ ] Documentation complete

## Emergency Procedures 🚨

### When Tests Fail:
1. **STOP** - Don't write more code
2. **Identify** - Use `git diff` to see changes
3. **Fix** - Address the root cause
4. **Verify** - All tests pass before continuing

### When Complexity Explodes:
1. **Pause** - Stop implementation
2. **Reassess** - Upgrade rigor level if needed
3. **Break Down** - Split into smaller tasks
4. **Add Tests** - Increase test coverage

### When Timeline Slips:
1. **Evaluate** - Can scope be reduced?
2. **Communicate** - Update stakeholders
3. **Prioritize** - Focus on must-have features
4. **Document** - Record decisions for future

## Success Patterns 🎯

### Daily Rhythm:
```
Morning: Run tests, plan current task
During: Write tests first, then implement
Evening: Verify no regressions, commit changes
```

### Weekly Rhythm:
```
Monday: Plan week's tasks and quality gate goals
Wednesday: Mid-week progress check and adjustments  
Friday: Quality gate verification and retrospective
```

### Task Completion:
```
1. Understand acceptance criteria
2. Write failing tests
3. Implement minimal solution
4. Refactor for quality
5. Verify all tests pass
6. Update documentation
7. Commit with clear message
8. Mark task complete
```

## Troubleshooting 🔧

### "Tests are taking too long to write"
- **Light Touch:** Focus on happy path + basic errors only
- **Balanced:** Add edge cases gradually as you discover them
- **Full Rigor:** Comprehensive upfront pays off in maintenance

### "Complexity keeps growing"
- Pause and reassess your level - you may need to upgrade
- Break current task into smaller pieces
- Add more test coverage for complex areas

### "Not sure what to test"
- Start with acceptance criteria from PRD
- Test the behavior users will see
- Add tests for error conditions
- Test integration points between components

---

**Ready to start?** Pick your complexity level and dive in! 🚀

**Need help?** Check the examples directory for real-world demonstrations.
