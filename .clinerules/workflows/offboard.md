# /offboard â€” Task Offboarding & Documentation

**Purpose:** Close out a completed Standard or Feature/Architectural task.

**Steps:**
1. **Summarize** â€” list features implemented, files changed, tests added.
2. **Update governance docs**:
   - Mark completed features as "Complete" in `docs/requirements/frd.md`.
   - Add a final gate entry to `docs/approvals.md` with status "Approved" and any notes.
3. **Verify CI/CD status** â€” if the task involved a push, confirm the pipeline passed (or document known failures).
4. **Create checkpoint commit** â€” if not already committed, create an atomic commit with a summary message (e.g., `chore: complete feature FR-001`).
5. **Log next steps** â€” list any deferred items, follow-up tasks, or open questions.

**Applies to:** Standard and Feature/Architectural tasks. Optional for Micro. Skipped for Hotfix (retroactive update is already required).