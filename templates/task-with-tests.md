# Rigour Vibe Tasks: [Feature Name]

**File:** `../directives/tasks/YYYY-MM-DD_task_feature-name.md`
**PRD Reference:** `../directives/prd/YYYY-MM-DD_prd_feature-name.md`
**Created:** [Date]

## Project Overview
**Complexity Level:** [Light Touch | Balanced Rigor | Full Rigor]
**Testing Strategy:** [Summary of testing approach from PRD]
**Quality Gates:** [Number and type of checkpoints]
**Estimated Timeline:** [Development timeline]

## Test Infrastructure Setup
**Complete this section first before any feature tasks**

- [ ] 0.0 Test Environment Setup
  - [ ] 0.1 Configure test runner and framework
  - [ ] 0.2 Set up test utilities and helpers
  - [ ] 0.3 Create test data factories/fixtures
  - [ ] 0.4 Establish baseline performance benchmarks
  - [ ] 0.5 Verify CI/CD pipeline includes tests
  - [ ] 0.6 Document test execution commands

## Relevant Files (Following Rigour Vibe Project Structure)
### Implementation Files
- `src/core/[feature]/[module].ts` - Core business logic
- `src/api/[feature]/[endpoint].ts` - API endpoints (if applicable)
- `src/ui/[feature]/[component].tsx` - UI components (if applicable)
- `src/utils/[feature]/[helpers].ts` - Utility functions
- `src/config/[feature].ts` - Configuration settings (if needed)

### Test Files
- `tests/unit/[feature]/[module].test.ts` - Unit tests for core logic
- `tests/unit/[feature]/[component].test.tsx` - Component unit tests (if applicable)
- `tests/integration/[feature]/[workflow].spec.ts` - Integration tests
- `tests/e2e/[feature]/[scenario].e2e.ts` - End-to-end tests (if applicable)
- `tests/fixtures/[feature]/[data].json` - Test data and mock objects

### Environment & Scripts
- `docker/Dockerfile` - Docker configuration (if needed)
- `environment/ci/github-actions.yml` - CI/CD configuration (if needed)
- `scripts/build/build-[feature].sh` - Build scripts (if needed)
- `scripts/test/test-[feature].sh` - Test execution scripts (if needed)

### Documentation Files
- `directives/tests/YYYY-MM-DD_test_[feature]_task-[id].md` - Test specifications per task
- `directives/summaries/YYYY-MM-DD_summary_[feature]_task-[id].md` - Implementation summaries per task
- `docs/api/[feature].md` - API documentation (if applicable)
- `docs/user/[feature].md` - User documentation (if applicable)
- `docs/dev/[feature].md` - Developer documentation (if needed)

## Implementation Tasks

### Task Group 1: Foundation
- [ ] 1.0 Core Data Layer
  - **Prerequisites:**
    - [ ] Review existing data models
    - [ ] Identify integration points
  - **Tests Required Before Implementation:**
    - [ ] 1.0.T1 Write unit tests for data models
    - [ ] 1.0.T2 Write integration tests for data persistence
    - [ ] 1.0.T3 Write validation tests for input sanitization
  - **Implementation Subtasks:**
    - [ ] 1.1 Define data types and interfaces
    - [ ] 1.2 Implement data validation logic
    - [ ] 1.3 Create database schema/API contracts
    - [ ] 1.4 Add error handling for data operations
  - **Verification Requirements:**
    - [ ] 1.0.V1 All data model tests pass
    - [ ] 1.0.V2 Data validation prevents invalid inputs
    - [ ] 1.0.V3 Error scenarios handled gracefully
    - [ ] 1.0.V4 Integration with existing data layer verified

- [ ] 2.0 Business Logic Implementation
  - **Prerequisites:**
    - [ ] Task 1.0 completed and verified
  - **Tests Required Before Implementation:**
    - [ ] 2.0.T1 Write tests for core business rules
    - [ ] 2.0.T2 Write tests for edge cases and error conditions
    - [ ] 2.0.T3 Write integration tests for service layer
  - **Implementation Subtasks:**
    - [ ] 2.1 Implement core business logic
    - [ ] 2.2 Add input validation and sanitization
    - [ ] 2.3 Implement error handling and recovery
    - [ ] 2.4 Add logging and monitoring hooks
  - **Verification Requirements:**
    - [ ] 2.0.V1 All business logic tests pass
    - [ ] 2.0.V2 Edge cases handled correctly
    - [ ] 2.0.V3 Integration with data layer works
    - [ ] 2.0.V4 Performance within acceptable limits

### Task Group 2: User Interface
- [ ] 3.0 Component Development
  - **Prerequisites:**
    - [ ] Tasks 1.0 and 2.0 completed
  - **Tests Required Before Implementation:**
    - [ ] 3.0.T1 Write component unit tests (render, props, events)
    - [ ] 3.0.T2 Write accessibility tests
    - [ ] 3.0.T3 Write integration tests with services
  - **Implementation Subtasks:**
    - [ ] 3.1 Create base component structure
    - [ ] 3.2 Implement user interaction handlers
    - [ ] 3.3 Add form validation and feedback
    - [ ] 3.4 Implement loading and error states
    - [ ] 3.5 Add accessibility attributes and support
  - **Verification Requirements:**
    - [ ] 3.0.V1 Component renders correctly in all states
    - [ ] 3.0.V2 User interactions work as expected
    - [ ] 3.0.V3 Accessibility requirements met
    - [ ] 3.0.V4 Integration with business logic verified

### Task Group 3: Integration & Polish
- [ ] 4.0 System Integration
  - **Prerequisites:**
    - [ ] All previous tasks completed
  - **Tests Required Before Implementation:**
    - [ ] 4.0.T1 Write end-to-end workflow tests
    - [ ] 4.0.T2 Write performance regression tests
    - [ ] 4.0.T3 Write security validation tests (if applicable)
  - **Implementation Subtasks:**
    - [ ] 4.1 Integrate all components into main application
    - [ ] 4.2 Add navigation and routing (if needed)
    - [ ] 4.3 Implement state management integration
    - [ ] 4.4 Add monitoring and analytics tracking
  - **Verification Requirements:**
    - [ ] 4.0.V1 End-to-end workflows complete successfully
    - [ ] 4.0.V2 No performance regressions introduced
    - [ ] 4.0.V3 Security requirements verified
    - [ ] 4.0.V4 Full application remains stable

## Quality Gates

### Quality Gate 1: Foundation Complete ✅
**Prerequisites:** Tasks 1.0 and 2.0 completed
**Verification Criteria:**
- [ ] All foundation tests passing (unit + integration)
- [ ] Data layer operations verified
- [ ] Business logic functioning correctly
- [ ] No critical performance issues
- [ ] Error handling working properly

**Gate 1 Verification Commands:**
```bash
# Run foundation tests
npm test -- --testPathPattern="(data|service|business)"

# Integration verification
npm run test:integration:foundation

# Performance check
npm run test:performance:baseline
```

### Quality Gate 2: Feature Complete ✅
**Prerequisites:** Tasks 3.0 and 4.0 completed
**Verification Criteria:**
- [ ] All feature tests passing
- [ ] User interface fully functional
- [ ] Integration points verified
- [ ] Accessibility requirements met
- [ ] Documentation updated

**Gate 2 Verification Commands:**
```bash
# Full feature test suite
npm test

# UI/Component tests
npm run test:components

# Accessibility check
npm run test:a11y

# Documentation verification
npm run docs:verify
```

### Quality Gate 3: Release Ready ✅
**Prerequisites:** All tasks completed + quality gates 1 & 2 passed
**Verification Criteria:**
- [ ] Complete test suite passing (100% of implemented features)
- [ ] Performance benchmarks met
- [ ] Security scan passed
- [ ] Cross-browser compatibility verified (if web app)
- [ ] Production deployment tested
- [ ] Monitoring and alerting configured
- [ ] Rollback procedures tested

**Gate 3 Verification Commands:**
```bash
# Complete release verification
npm run test:release

# Performance verification
npm run test:performance:full

# Security scan
npm run security:scan

# End-to-end verification
npm run test:e2e

# Production readiness check
npm run verify:production
```

## Test Execution Commands

### Development Testing
```bash
# Run all tests
npm test

# Run tests in watch mode
npm run test:watch

# Run specific test file
npm test path/to/test.spec.ts

# Run tests with coverage
npm run test:coverage
```

### Integration Testing
```bash
# Run integration tests only
npm run test:integration

# Run API integration tests
npm run test:api

# Run database integration tests
npm run test:db
```

### Specialized Testing
```bash
# Run accessibility tests
npm run test:a11y

# Run performance tests
npm run test:performance

# Run security tests
npm run test:security

# Run visual regression tests (if applicable)
npm run test:visual
```

## Task Completion Criteria

### Individual Task Completion
A task is complete when:
1. ✅ **Tests written first** - All required tests exist and initially fail
2. ✅ **Implementation complete** - Code makes tests pass
3. ✅ **Quality verified** - Code meets standards (linting, formatting)
4. ✅ **Integration verified** - Works with existing code
5. ✅ **Regression check** - All previous tests still pass
6. ✅ **Documentation updated** - Changes documented
7. ✅ **Committed** - Changes committed with descriptive message

### Quality Gate Completion
A quality gate is passed when:
1. ✅ **All prerequisite tasks complete**
2. ✅ **All gate-specific tests pass**
3. ✅ **Performance requirements met**
4. ✅ **Integration verified**
5. ✅ **Documentation current**
6. ✅ **Ready for next phase**

## Risk Management

### High-Risk Areas
[Identify based on complexity assessment]
- **Risk:** [Description]
  - **Mitigation:** [Additional testing/verification needed]
  - **Monitoring:** [How to detect issues early]

### Complexity Escalation
If any task becomes more complex than expected:
1. **Pause implementation**
2. **Reassess complexity level**
3. **Add additional tests if needed**
4. **Break down into smaller subtasks**
5. **Update timeline estimates**

## Progress Tracking

### Daily Checklist
- [ ] Run test suite to verify current state
- [ ] Complete one focused task/subtask
- [ ] Update task list with progress
- [ ] Commit changes with clear messages
- [ ] Verify no regressions introduced

### Weekly Review
- [ ] Review overall progress against timeline
- [ ] Assess risk level and mitigation needs
- [ ] Update stakeholders on status
- [ ] Plan next week's priorities
- [ ] Consider complexity adjustments

---

**Task List Status:** [Draft | In Progress | Complete]
**Last Updated:** [Date]
**Current Task:** [X.Y - Description]
**Overall Progress:** [X]% complete
**Next Quality Gate:** [Gate name] - [Status]
