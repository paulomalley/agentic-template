---
paths:
  - "client/**"
  - "server/src/routes/**"
---

# Integration Testing Policy

This rule activates only when a change touches `client/` or `server/src/routes/`.

## Integration Test Requirement
Any change touching a route handler, database access layer, or external API integration must include an integration test in `tests/integration/`, in addition to unit tests in `tests/unit/` for pure logic.

**Coverage expectation:** the integration test must exercise (a) the happy path for the touched boundary, and (b) at least one failure/error-handling path (invalid input, not-found, upstream failure, auth rejection). A test covering only the happy path does not satisfy this requirement.

## Post-Implementation Smoke Check

After implementing any feature that touches `client/` or `server/src/routes/`, run the project's smoke test suite before marking the feature complete or requesting human review.

The smoke command is defined in `package.json` as `test:smoke`. If this script does not exist, add it before relying on this policy:

```json
"scripts": {
  "test:smoke": "echo \"Add your smoke tests here\" && exit 0"
}
```

**Note:** The smoke suite must pass (or have a documented, accepted failure) before human validation. If the smoke script is a no-op stub, update it with real smoke tests before marking any feature complete.