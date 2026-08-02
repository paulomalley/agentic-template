# Phase-Gate Policy

## Governance Process (Standard/Feature tasks only)

1. **PLAN MODE** â€” remain in PLAN MODE until the complete architecture, test placement strategy, and file paths are explicitly agreed by the user. Do not create files until transitioned to ACT MODE.
2. **Governance Docs** â€” if `docs/` doesn't exist, create it with the structure defined in the `governance-templates` skill before proceeding.
3. **Feature Request Intake** â€” capture ideas immediately in `docs/requirements/feature_requests.md` using the template from the `governance-templates` skill. Do not implement feature requests directly â€” formalize in the FRD first.
4. **TDD Mandatory** â€” production logic and its test suite must be generated within the same execution block.
5. **Integration Tests** â€” any change crossing a service or module boundary must include an integration test in addition to unit tests (see `05a-integration-policy.md` for details).
6. **E2E/UAT Tests** â€” see `05b-e2e-policy.md` for when end-to-end / UAT tests are mandated.
7. **Sign-Off Integrity** â€” when requesting sign-off, include a specific summary of what's being approved and at least one concrete question/decision point.
8. **Post-Implementation Gate** â€” before presenting code, verify compilation and linting, and update the project's changelog if one exists.

**Templates** for governance docs are defined in the `governance-templates` skill (lazy-loaded via `/use_skill governance-templates`).