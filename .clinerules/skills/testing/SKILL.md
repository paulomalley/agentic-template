---
name: testing
description: After each coding action, validate that business and functional requirements are covered by tests at the correct level. Integrated with project clinerules governance.
---

# Testing Reviewer

After every code change, evaluate whether the change has the right tests at the right level and whether those tests would catch meaningful regressions. This skill enforces the testing requirements defined in the project's `.clinerules/` directory.

## Pre-Check: Project Test Infrastructure

Before auditing, verify the project has a functioning test suite:

1. Check `package.json` scripts for the project's test commands.
2. If no test runner is configured (e.g., `"test": "echo \"no tests yet\""`), **do not proceed with the audit**. Instead, report: "No test runner configured. Scaffold the project's test infrastructure first before I can audit."
3. Read `.clinerules/08-test-structure.md` for the project's test directory layout (`tests/unit/`, `tests/integration/`, `tests/e2e/`, `tests/smoke/`).

## Rules Reference

This skill enforces the following clinerules in this priority order:

| Rule | Requirement |
|---|---|
| `05-phase-gate-policy.md` | TDD mandatory — code + tests generated together |
| `05a-integration-policy.md` | Integration test required when boundary paths are touched (`client/`, `server/src/routes/`); smoke check must run |
| `08-test-structure.md` | Tests in `tests/{unit,integration,e2e,smoke}/` mirroring source layout |
| `04-state-control.md` | Two-strike rule — if same test fails with identical output twice, stop and escalate |

## Steps

1. **Analyze Scope**: Review the code changes to identify business logic modifications, edge cases, failure states, and affected dependencies. Cross-reference with boundary paths defined in `05a-integration-policy.md`.
2. **Audit Existing Tests**: For each changed source file, check whether corresponding test files exist at the correct level:
   - Pure logic → `tests/unit/` (no I/O, no network)
   - Route handler / DB access / external API → `tests/integration/` (happy path + at least one failure path)
   - Full user flow → `tests/e2e/`
3. **Verify Quality**:
   - Assertions must evaluate observable outcomes, not internal implementation details.
   - Mocks should be minimal; prefer real or in-memory substitutes over deep mocking.
   - Flag tests that would be brittle on refactor (e.g., asserting internal state, call counts, or private method names).
4. **Report Gaps**: Output a blocking/non-blocking report using the format below.

## Output Format

Produce a report in this exact structure:

```
## Test Audit Report

### ✅ Covered
- [test file path]: [what it validates]

### ⚠️ Missing (Non-Blocking)
- [test scenario]: [why it should exist, risk level]

### 🔴 Missing (Blocking — per .clinerules/)
- [test scenario]: [which rule it violates]
```

**Blocking** means: the change must not be considered complete until these tests exist.
A gap is blocking when:
- A boundary path (per `05a`) was touched and no integration test exists.
- TDD was skipped — code was written before tests.
- The smoke check (`npm run test:smoke`) was not run after a boundary-path change.

### Cross-Cutting Checklist

Additionally, check for unaddressed risks in:
- Authorization / access control
- Async operations (race conditions, timeouts)
- Data migrations (rollback path)
- Backward compatibility
- Accessibility

## Post-Audit Action

If blocking gaps exist, the task is **not complete**. Generate the missing tests before marking the feature done or requesting human review.