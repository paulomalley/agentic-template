# /monitor-ci â€” Post-Push CI/CD Monitoring

**Purpose:** Monitor the CI/CD pipeline after pushing to the default branch and intervene on failure.

**Execution:** This workflow runs the script based on the environment:
- On any platform (PowerShell 7+): `pwsh -File scripts/monitor-ci.ps1`
- On Windows (PowerShell 5.1): `powershell -File scripts/monitor-ci.ps1`

**Steps (handled by the script):**
1. Retrieve the latest run ID via `gh run list`.
2. Poll for completion every 30â€“60s.
3. On failure: pull logs, diagnose, implement fix, push new commit, restart monitoring.
4. On success: run production smoke tests (if reachable) and report completion.

**Fallback:** If the CI runner is offline (queued > 10 min), report to the user and stop.

**Applies to:** Standard, Feature, and Hotfix tasks. Skip for Micro (pipeline not required for local-only changes).

**Note:** The two-strike rule applies across pipeline failures (see `04-state-control.md`).