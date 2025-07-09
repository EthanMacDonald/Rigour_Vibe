# Example: User Profile Avatar Upload (Light Touch)

This example demonstrates the Rigour Vibe approach for a simple, low-risk feature that still benefits from structured testing.

## Feature Description
Add the ability for users to upload and display a profile avatar image in an existing user profile page.

## Complexity Assessment
- **Risk Level:** Low (cosmetic feature, easy to rollback)
- **System Impact:** Single component modification
- **Timeline:** Prototype/quick implementation
- **Recommended Level:** Light Touch (Level 1)

## PRD Example

```markdown
# PRD: User Profile Avatar Upload

## Complexity Level
**Rigor Level:** Light Touch
**Risk Assessment:** Low
**Reasoning:** Simple UI enhancement, no business-critical impact, easy to revert

## Overview
Users can upload and display a profile picture to personalize their account.

## Goals & Success Metrics
1. Users can upload an image file for their profile
2. Avatar displays correctly in profile view
3. File upload errors are handled gracefully

### Success Metrics
- User Behavior: Increased profile completion rate
- Technical Metrics: Upload success rate >95%

## User Stories & Acceptance Criteria
1. **As a** logged-in user, **I want** to upload a profile picture **so that** my account feels more personal
   - **Acceptance Criteria:**
     - [ ] Click upload button opens file picker
     - [ ] Supported formats: JPG, PNG, GIF
     - [ ] File size limit: 5MB
     - [ ] Preview shows before saving
     - [ ] Error message for invalid files

## Functional Requirements
1. **REQ-001:** File upload component in profile edit page
   - **Testability:** UI component tests + file upload simulation
   - **Priority:** High

2. **REQ-002:** Image validation (type, size)
   - **Testability:** Unit tests for validation logic
   - **Priority:** High

3. **REQ-003:** Avatar display in profile view
   - **Testability:** Component rendering tests
   - **Priority:** Medium

## Quality Requirements
### Testing Strategy (Light Touch)
#### Unit Tests
- **Coverage Target:** 80% (focus on core functionality)
- **Focus Areas:**
  - File validation logic
  - Error handling
  - Component rendering

#### Integration Tests
- **File Upload Flow:** End-to-end upload process
- **Profile Display:** Avatar shows after upload

## Technical Considerations
- Use existing file upload service
- Store avatar URL in user profile object
- Default placeholder if no avatar uploaded

## Non-Goals
- Image editing/cropping
- Multiple image upload
- Advanced image optimization
```

## Task List Example

```markdown
# Rigour Vibe Tasks: User Profile Avatar Upload

## Project Overview
**Complexity Level:** Light Touch
**Testing Strategy:** Focus on core functionality and error handling
**Quality Gates:** 2 gates (Foundation + Feature Complete)

## Test Infrastructure Setup
- [x] 0.1 Verify existing test framework works for file uploads
- [x] 0.2 Create test utilities for mock file uploads
- [x] 0.3 Set up component testing environment

## Implementation Tasks

### Task Group 1: File Upload Logic
- [x] 1.0 File Validation Service
  - **Tests Required:**
    - [x] 1.0.T1 Unit tests for file type validation
    - [x] 1.0.T2 Unit tests for file size validation
    - [x] 1.0.T3 Unit tests for error scenarios
  - **Implementation:**
    - [x] 1.1 Create file validation utility
    - [x] 1.2 Add error handling with user-friendly messages
  - **Verification:**
    - [x] 1.0.V1 All validation tests pass
    - [x] 1.0.V2 Error messages clear and helpful

### Task Group 2: Upload Component
- [x] 2.0 Avatar Upload Component
  - **Tests Required:**
    - [x] 2.0.T1 Component renders correctly
    - [x] 2.0.T2 File picker opens on click
    - [x] 2.0.T3 Preview shows selected image
    - [x] 2.0.T4 Upload success/error handling
  - **Implementation:**
    - [x] 2.1 Create upload button component
    - [x] 2.2 Add file preview functionality
    - [x] 2.3 Integrate with existing upload service
    - [x] 2.4 Add loading states and error display
  - **Verification:**
    - [x] 2.0.V1 Component works in isolation
    - [x] 2.0.V2 Integration with file service works

### Task Group 3: Profile Integration
- [x] 3.0 Profile Display Integration
  - **Tests Required:**
    - [x] 3.0.T1 Avatar displays in profile view
    - [x] 3.0.T2 Default placeholder when no avatar
    - [x] 3.0.T3 Avatar updates after successful upload
  - **Implementation:**
    - [x] 3.1 Add avatar display to profile component
    - [x] 3.2 Connect upload component to profile edit
    - [x] 3.3 Update profile data model
  - **Verification:**
    - [x] 3.0.V1 End-to-end upload flow works
    - [x] 3.0.V2 Profile updates correctly

## Quality Gates

### Gate 1: Upload Functionality ✅
- [x] File validation working
- [x] Upload component functional
- [x] Error handling in place
- [x] Basic tests passing

### Gate 2: Feature Complete ✅
- [x] Full upload workflow functional
- [x] Profile integration complete
- [x] All tests passing
- [x] User acceptance criteria met

## Test Results Summary
- **Unit Tests:** 12/12 passing ✅
- **Component Tests:** 8/8 passing ✅
- **Integration Tests:** 3/3 passing ✅
- **Coverage:** 85% (exceeds 80% target) ✅
```

## Key Benefits of Light Touch Approach

### What We Got Right
1. **Quick Development:** Feature completed in 2 days vs estimated 1 week for full rigor
2. **Quality Assurance:** Tests caught 3 edge cases that would have been bugs
3. **Maintainable Code:** Clean structure makes future enhancements easy
4. **User Focus:** Acceptance criteria ensured user experience was considered

### What We Kept Simple
1. **Minimal Documentation:** Just enough to understand the feature
2. **Focused Testing:** Tested core functionality, skipped complex edge cases
3. **Basic Error Handling:** Clear user messages without exhaustive scenarios
4. **Simple Integration:** Used existing patterns and services

### Lessons Learned
1. **Test-First Worked:** Writing tests first prevented 2 implementation mistakes
2. **Quality Gates Helped:** Caught integration issue at Gate 1 before building on it
3. **Risk Assessment Accurate:** Low risk feature didn't need heavy process
4. **Time Savings:** Completed 80% faster than traditional full-spec approach

## When This Approach Works
- ✅ UI enhancements and visual features
- ✅ Features with obvious user feedback
- ✅ Low business impact if bugs occur
- ✅ Existing patterns and infrastructure available
- ✅ Clear, simple requirements

## When to Upgrade to Balanced Rigor
- ❌ If file uploads affect billing or important data
- ❌ If integration with multiple systems required
- ❌ If security implications discovered
- ❌ If performance becomes critical
- ❌ If feature complexity grows beyond expectations

This example shows how Rigour Vibe's Light Touch approach can deliver quality features quickly while maintaining professional development standards.
