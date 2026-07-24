# /onboard â€” Task Onboarding & Context Restoration

**Purpose:** Initialize context for a new Standard or Feature/Architectural task.

**Steps:**
1. READ `docs/approvals.md` â€” phase-gate status, feature completion state, deferred items.
2. READ `docs/requirements/frd.md` â€” feature list with status (Not Started / In Progress / Complete) and acceptance criteria.
3. READ `docs/requirements/feature_requests.md` â€” open/proposed/declined feature requests.
4. RUN `git --no-pager log --oneline -5` â€” recent commits and what last changed.
5. STALENESS CROSS-CHECK:
   - Compare the last-modified date of `frd.md` and `approvals.md` against the most recent commit date (`git log -1 --format=%cd`).
   - If the docs are older than the most recent commit and that commit isn't reflected in them, flag it: "Note: the FRD/approvals log may be stale â€” the most recent commit isn't reflected there. Confirming with you before I rely on it."
6. RESTATE UNDERSTANDING:
   - "Here's what I understand is complete..."
   - "Here's what I understand is remaining..."
   - "Confirm this is correct before I proceed."

**If `docs/` doesn't exist:** Create the governance doc structure using the `governance-templates` skill before proceeding.

**Applies to:** Standard and Feature/Architectural tasks only. Skipped for Micro and Hotfix (see Tier 0).