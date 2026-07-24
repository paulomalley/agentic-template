# Workspace Safety & Scoping

1. DIRECTORY ISOLATION: Access local workspace paths only. Never look for files, system configuration, or environment variables outside this project root.
2. COMMAND RESTRAINTS:
   - **Read-only/validation commands** (test runners, linters, `git status`, `git log`, `git diff`, typecheck commands) may run without a per-call confirmation gate â€” required by phase-gate/TDD/smoke-check rules and non-destructive.
   - **State-changing or destructive commands** (installs/uninstalls, deletions, `git reset`, `git push --force`, database migrations, process kills, deploys) require explicit human confirmation before execution, every time.