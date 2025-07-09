# Hybrid Vibe Verification Checklist

## Quality Gate Verification

### Gate 1: Foundation Complete ✅
**Purpose:** Verify core functionality is solid before building upon it

#### Pre-Gate Requirements
- [ ] All foundation tasks marked complete in task list
- [ ] Core data models implemented and tested
- [ ] Business logic layer functional
- [ ] Integration points identified and tested

#### Verification Steps
- [ ] **Test Suite Status**
  ```bash
  npm test -- --testPathPattern="(foundation|core|data|service)"
  ```
  - [ ] All foundation tests passing
  - [ ] Test coverage meets minimum threshold
  - [ ] No flaky or intermittent test failures

- [ ] **Integration Verification**
  ```bash
  npm run test:integration:foundation
  ```
  - [ ] Data persistence working correctly
  - [ ] API endpoints responding as expected
  - [ ] External service integrations functional

- [ ] **Performance Baseline**
  ```bash
  npm run test:performance:baseline
  ```
  - [ ] Response times within acceptable range
  - [ ] Memory usage reasonable
  - [ ] No obvious performance bottlenecks

- [ ] **Code Quality**
  ```bash
  npm run lint && npm run type-check
  ```
  - [ ] Linting passes without errors
  - [ ] Type checking passes (if TypeScript)
  - [ ] Code formatting consistent

#### Go/No-Go Decision
- **✅ GO:** All checks pass - proceed to UI development
- **❌ NO-GO:** Address failing items before proceeding

### Gate 2: Feature Complete ✅
**Purpose:** Verify complete feature functionality before final integration

#### Pre-Gate Requirements
- [ ] All feature implementation tasks complete
- [ ] User interface components implemented
- [ ] Feature integrated into application
- [ ] User acceptance criteria met

#### Verification Steps
- [ ] **Full Feature Test Suite**
  ```bash
  npm test
  ```
  - [ ] All unit tests passing
  - [ ] All integration tests passing
  - [ ] Component tests passing
  - [ ] End-to-end critical paths verified

- [ ] **User Experience Verification**
  - [ ] All user stories can be completed successfully
  - [ ] Error handling provides clear user feedback
  - [ ] Loading states and transitions smooth
  - [ ] Accessibility requirements met (WCAG guidelines)

- [ ] **Cross-Browser Compatibility** (if web app)
  ```bash
  npm run test:cross-browser
  ```
  - [ ] Chrome/Chromium
  - [ ] Firefox
  - [ ] Safari (if relevant)
  - [ ] Mobile browsers (if relevant)

- [ ] **Performance Verification**
  ```bash
  npm run test:performance:feature
  ```
  - [ ] Feature doesn't introduce performance regressions
  - [ ] Page load times acceptable
  - [ ] User interactions responsive

#### Go/No-Go Decision
- **✅ GO:** Feature ready for release preparation
- **❌ NO-GO:** Address quality issues before release

### Gate 3: Release Ready ✅
**Purpose:** Verify production readiness and deployment safety

#### Pre-Gate Requirements
- [ ] Gates 1 and 2 successfully passed
- [ ] All tasks in task list completed
- [ ] Documentation updated
- [ ] Deployment procedures defined

#### Verification Steps
- [ ] **Complete Test Suite**
  ```bash
  npm run test:release
  ```
  - [ ] 100% of tests passing
  - [ ] No skipped or ignored tests
  - [ ] Test coverage meets release standards

- [ ] **Security Verification**
  ```bash
  npm run security:scan
  ```
  - [ ] No high-severity security vulnerabilities
  - [ ] Input validation comprehensive
  - [ ] Authentication/authorization working
  - [ ] Sensitive data properly protected

- [ ] **Performance Verification**
  ```bash
  npm run test:performance:full
  ```
  - [ ] Load testing passes
  - [ ] Stress testing within limits
  - [ ] Memory leaks absent
  - [ ] Database performance acceptable

- [ ] **Production Readiness**
  ```bash
  npm run verify:production
  ```
  - [ ] Environment variables configured
  - [ ] Database migrations ready
  - [ ] Monitoring and logging configured
  - [ ] Error tracking active
  - [ ] Backup procedures verified

- [ ] **Rollback Verification**
  - [ ] Rollback procedure documented
  - [ ] Rollback tested in staging environment
  - [ ] Data migration rollback planned
  - [ ] Quick rollback triggers identified

#### Go/No-Go Decision
- **✅ GO:** Ready for production deployment
- **❌ NO-GO:** Address production readiness issues

## Continuous Verification Checklist

### After Each Task Completion
- [ ] **Immediate Verification**
  - [ ] Task-specific tests all pass
  - [ ] Implementation meets acceptance criteria
  - [ ] Code quality standards met
  - [ ] Task marked complete in task list

- [ ] **Regression Check**
  ```bash
  npm test
  ```
  - [ ] Full test suite still passing
  - [ ] No new test failures introduced
  - [ ] Performance hasn't degraded

- [ ] **Integration Verification**
  - [ ] Feature integrates properly with existing code
  - [ ] No breaking changes to existing APIs
  - [ ] User workflows still functional

### Daily Development Checklist
- [ ] **Morning Setup**
  - [ ] Pull latest code changes
  - [ ] Run test suite to verify starting state
  - [ ] Review task list for current priorities

- [ ] **During Development**
  - [ ] Write tests before implementation
  - [ ] Commit frequently with clear messages
  - [ ] Run relevant tests after each change

- [ ] **End of Day**
  - [ ] Full test suite run
  - [ ] All changes committed
  - [ ] Task list updated with progress
  - [ ] No broken tests left for tomorrow

### Weekly Review Checklist
- [ ] **Progress Assessment**
  - [ ] Review completed tasks vs. timeline
  - [ ] Assess quality gate readiness
  - [ ] Identify any scope creep or complexity changes

- [ ] **Quality Review**
  - [ ] Code coverage trends
  - [ ] Test reliability (flaky tests)
  - [ ] Performance trend analysis
  - [ ] Technical debt accumulation

- [ ] **Risk Assessment**
  - [ ] Identify new risks that have emerged
  - [ ] Review mitigation strategies
  - [ ] Adjust complexity level if needed
  - [ ] Update stakeholders on status

## Emergency Procedures

### When Tests Start Failing
1. **Stop Implementation** - Don't add more code until tests pass
2. **Identify Root Cause** - Use `git diff` and `git log` to find changes
3. **Isolate Problem** - Run specific test files to narrow down issues
4. **Fix or Revert** - Either fix the issue or revert problematic changes
5. **Verify Fix** - Ensure all tests pass before continuing

### When Performance Degrades
1. **Measure Impact** - Run performance benchmarks
2. **Identify Bottleneck** - Use profiling tools
3. **Assess Criticality** - Determine if blocking or can be addressed later
4. **Fix or Document** - Either resolve immediately or add to technical debt
5. **Re-baseline** - Update performance expectations if needed

### When Complexity Exceeds Expectations
1. **Pause Development** - Stop adding features
2. **Reassess Approach** - Consider breaking task into smaller pieces
3. **Upgrade Rigor Level** - Add more comprehensive testing
4. **Communicate Impact** - Update timeline and stakeholder expectations
5. **Adjust Plan** - Modify task list and quality gates as needed

## Quality Metrics Dashboard

### Test Health Metrics
- **Test Pass Rate:** [Current] / [Target] (≥95%)
- **Test Coverage:** [Current] / [Target] (varies by complexity level)
- **Test Execution Time:** [Current] / [Target] (≤10 minutes)
- **Flaky Test Count:** [Current] / [Target] (0)

### Code Quality Metrics
- **Lint Violations:** [Current] / [Target] (0 errors)
- **Type Coverage:** [Current] / [Target] (≥90% if TypeScript)
- **Code Duplication:** [Current] / [Target] (≤5%)
- **Technical Debt:** [Current trend]

### Performance Metrics
- **Response Time:** [Current] / [Target]
- **Memory Usage:** [Current] / [Target]
- **CPU Usage:** [Current] / [Target]
- **Database Query Time:** [Current] / [Target]

### Security Metrics
- **Vulnerability Count:** [Current] / [Target] (0 high severity)
- **Security Test Coverage:** [Current] / [Target]
- **Dependency Security:** [Current status]

## Documentation Verification

### Code Documentation
- [ ] **Inline Comments** - Complex logic explained
- [ ] **Function Documentation** - Parameters and return values documented
- [ ] **API Documentation** - Endpoints documented with examples
- [ ] **README Updates** - Installation and usage instructions current

### Process Documentation
- [ ] **Feature Documentation** - User-facing feature docs updated
- [ ] **Developer Guide** - Setup and development process documented
- [ ] **Deployment Guide** - Production deployment steps documented
- [ ] **Troubleshooting Guide** - Common issues and solutions documented

### Test Documentation
- [ ] **Test Strategy** - Testing approach documented
- [ ] **Test Data** - Test data setup and management documented
- [ ] **Test Execution** - How to run different test suites documented
- [ ] **Test Maintenance** - How to update and maintain tests documented

---

**Checklist Version:** 1.0
**Last Updated:** [Date]
**Next Review Date:** [Date]
**Responsible Team:** [Team Name]
