# 🚀 Hybrid Vibe Quick Start Guide

Get started with test-driven, rigorous development in under 10 minutes!

## 1. Choose Your Complexity Level ⚖️

**Answer these quick questions:**

### A. Risk Assessment
- **Low Risk:** Cosmetic changes, easy to fix if broken
- **Medium Risk:** Affects user workflows, moderate impact if broken  
- **High Risk:** Financial/security/data implications if broken

### B. System Impact
- **Single Component:** Changes one file/component
- **Multiple Components:** Changes several related parts
- **Cross-System:** Integration across multiple systems

### C. Timeline Pressure
- **Experimental:** Speed over perfection, prototype
- **Production:** Balanced approach, real feature
- **Mission-Critical:** Quality over speed, can't fail

**Your Level:**
- **Mostly Low + Single + Experimental = Light Touch (Level 1)**
- **Mix of Medium + Multiple + Production = Balanced Rigor (Level 2)**
- **Any High + Cross-System + Mission-Critical = Full Rigor (Level 3)**

## 2. Create Your PRD 📋

### For Light Touch:
```
Use @hvb-create-prd.mdc
Feature: [Simple description]
Context: [What problem this solves]
```

### For Balanced/Full Rigor:
```
Use @hvb-create-prd.mdc
Feature: [Detailed description]
Risk factors: [Security, performance, integration concerns]
Compliance: [Any regulatory requirements]
```

## 3. Generate Test-Aware Tasks 📝

```
Use @hvb-generate-tasks.mdc with your PRD file
Reference: @hvb-prd-[your-feature].md
```

The AI will create tasks with built-in test requirements.

## 4. Implement with Tests First 🧪

```
Use @hvb-implement-task.mdc
Start with: Task 1.1 from your task list
```

### The Test-First Cycle:
1. **Red:** Write failing tests that describe what you want
2. **Green:** Write minimal code to make tests pass
3. **Refactor:** Clean up code while keeping tests passing
4. **Verify:** Run full test suite to catch regressions

## 5. Verify Progress Continuously ✅

```
Use @hvb-verify-progress.mdc
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
"Use @hvb-create-prd.mdc to add user profile photo upload"

# 2. Basic tasks (5 min)  
"Use @hvb-generate-tasks.mdc with @hvb-prd-profile-photo.md"

# 3. Test-first implementation (5 min per task)
"Use @hvb-implement-task.mdc for task 1.1"
```

**Focus:** Core functionality + basic error handling + simple integration

### Balanced Rigor (Level 2) - 30 minutes setup
```bash
# 1. Detailed PRD (10 min)
"Use @hvb-create-prd.mdc to add user notification system with email/SMS"

# 2. Comprehensive tasks (10 min)
"Use @hvb-generate-tasks.mdc with @hvb-prd-notifications.md"

# 3. Test-driven implementation (10 min per task)
"Use @hvb-implement-task.mdc for task 1.1 with integration testing"
```

**Focus:** Unit tests + integration tests + edge cases + performance

### Full Rigor (Level 3) - 60 minutes setup
```bash
# 1. Comprehensive PRD (20 min)
"Use @hvb-create-prd.mdc to add payment processing with PCI compliance"

# 2. Detailed task breakdown (20 min)
"Use @hvb-generate-tasks.mdc with security and compliance requirements"

# 3. TDD implementation (20 min per task)
"Use @hvb-implement-task.mdc with comprehensive test coverage"
```

**Focus:** TDD + security tests + performance tests + compliance + documentation

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
