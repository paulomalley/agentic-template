---
paths:
  - "client/**"
  - "server/src/routes/**"
  - "docs/requirements/**"
---

# E2E/UAT Testing Policy

This rule activates when a change touches `client/`, `server/src/routes/`, or `docs/requirements/`.

## Definition

A UAT/E2E test is a user journey test executed through the front end using **Playwright** that mimics how a real user would interact with the application. These tests live in `tests/e2e/`.

## Creation Gate

Every Functional Requirement or Feature defined in `docs/requirements/frd.md` must include at least a skeletal e2e test specification at plan time. No feature is considered "Complete" without associated e2e tests.

## Maintenance Gate

When a Functional Requirement changes, a Feature changes, or a Defect is fixed (including `hotfix:` commits), the corresponding e2e tests must be reviewed and updated in the same commit — adding new tests, removing obsolete ones, or adjusting existing ones to match the new behaviour.

## Post-Initial-Build Gate

Once a feature's initial code build has been presented to a human for validation:
- **Every subsequent code change** to that feature must run the full e2e suite and pass before the next human review.
- If e2e tests fail, the agent must iterate code → test automatically until passing, subject to the Two-Strike Rule (`.clinerules/04-state-control.md`).

## Coverage Requirements

Per feature or FRD, the e2e test suite must include:

| Type | Minimum Count |
|---|---|
| Happy-path tests | ≥2 |
| Negative / error-path tests | ≥2 |
| Edge-case tests | ≥1 |

## Enforcement

- The pre-commit hook runs `npm test` (which includes `npm run test:e2e`) on every commit and blocks on failure (see `.clinerules/06-git-hygiene.md` check #9).
- The pre-commit hook also warns if `client/**` changes lack corresponding e2e test changes in `tests/e2e/`.
- E2E test count must not decrease without replacement.