# /run-e2e — Execute End-to-End Tests On Demand

**Purpose:** Run the full Playwright e2e suite independently of any code change gate. Use this command whenever you want to validate the current state of the application without committing.

**Steps:**

1. RUN `npx playwright test` (which maps to `npm run test:e2e`)
2. REPORT the pass/fail counts per test file
3. On failure:
   - Identify which e2e tests failed and which features/FRDs they belong to
   - The agent may iterate to fix failures, subject to the Two-Strike Rule (`.clinerules/04-state-control.md`)
4. On all passing: report "All e2e tests pass" with the full count

**Note:** This workflow is independent of the pre-commit hook. Use it for manual verification, CI debugging, or checking a specific feature's e2e health.