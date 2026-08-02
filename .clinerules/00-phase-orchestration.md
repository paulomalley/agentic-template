# 4-Phase Execution Pipeline

Every Standard or Feature task MUST move sequentially through these 4 phases.

## Phase 1: GROUND (Research & Context)
- **Goal:** Ingest state without modifying files.
- **Action:** Run the `/onboard` workflow (`.clinerules/workflows/onboard.md`).
- **Tooling:** Read-only commands (`git log -5`, read `docs/approvals.md`, read `docs/requirements/frd.md`).
- **Completion:** Summarize context in ≤150 words and hand off: *"Grounding complete. Proceeding to Phase 2: PLAN."*

## Phase 2: PLAN (Architect & Blueprint)
- **Goal:** Design the feature, check tier requirements (Tier 0), and draft skeletons.
- **Action:** Create/update docs in `docs/` using the `governance-templates` skill (`/use_skill governance-templates`). Output structural blueprints (interfaces/types).
- **HUMAN GATE 🛑:** Stop and state: *"Awaiting human sign-off on the plan and blueprint before switching to ACT."*

## Phase 3: ACT (TDD Implementation)
- **Goal:** Write tests and production code side-by-side.
- **Action:** Enforce strict coding rules (`03-code-by-constraint.md`), zero placeholders, and bounded loops.
- **Guardrail:** Respect the Two-Strike Error Rule (`04-state-control.md`).
- **Completion:** When tests pass, hand off: *"Implementation complete. Proceeding to Phase 4: VERIFY."*

## Phase 4: VERIFY (Audit & Quality Gate)
- **Goal:** Run validation mechanics to ensure zero regressions.
- **Action:** Run integration tests (`05a-integration-policy.md`), Playwright E2E (`05b-e2e-policy.md`), and smoke tests (`npm run test:smoke`).
- **Guardrail:** Verify Husky pre-commit checks (`06-git-hygiene.md`) pass cleanly before presenting the final summary.