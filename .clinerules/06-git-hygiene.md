# Git Hygiene & Commit Practices

1. NEVER commit dependency directories (e.g. `node_modules/`, `vendor/`, `venv/`), build output (`dist/`, `build/`), local data/database files, `.env` files, or coverage reports.
2. Verify the repo-root `.gitignore` covers these categories for this project's stack. The `.gitignore` file itself is the source of truth â€” don't restate its contents in rules; if it's missing a category, add it.
3. Before staging, verify with `git status --short` that no untracked tooling cache files are being added. Prefer `git add -u` (tracked changes only) over `git add -A` as the default staging command.
4. After staging but before committing, run `git status --short` and confirm only project source files appear. If dependency/build artifacts appear, run `git rm --cached` to remove them from the index.
5. Commit messages reference feature IDs where applicable (e.g. `feat(fr-001): add X`). Hotfix commits use the `hotfix:` prefix instead.

## Atomic Commits
Each commit represents one logical, reversible change. Do not batch unrelated changes into a single commit.

## Commit Triggers
Commit at these checkpoints:
- After TDD green â€” a unit test + its implementation pass
- After each phase-gate passes
- When switching between PLAN and ACT mode
- At end of session if work is incomplete (use `wip:` prefix)

## Pre-Commit Validation (Automated Enforcement)

**This is enforced by a Git pre-commit hook (via Husky).** The hook runs the following checks mechanically. Do not rely on manual memory — the hook enforces `.clinerules/` governance automatically.

### Checks Run on Every Commit

| # | What It Checks | Violation => |
|---|---|---|
| 1 | No dependency/build artifacts staged (`node_modules/`, `dist/`, etc.) | ❌ Blocks commit |
| 2 | No untracked cache/build files present | ⚠️ Warns |
| 3 | Boundary-path changes (`client/`, `server/src/routes/`) must include integration tests (`tests/integration/`) | ⚠️ Warns |
| 4 | Boundary-path changes auto-run `npm run test:smoke` | ❌ Blocks if fails |
| 5 | Source file changes should have corresponding test file changes in the same commit (TDD) | ⚠️ Warns |
| 6 | >3 non-test source files changed triggers multi-file transform warning | ⚠️ Warns |
| 7 | Feature-level commits (touching `.clinerules/` or `docs/`) should update `docs/approvals.md` | ⚠️ Warns |
| 8 | Runs linter (`npm run test:lint`) if configured | ❌ Blocks if fails |
| 9 | Test count should not decrease without replacement | ⚠️ Warns |

### Bypassing Individual Checks

Use environment variables to skip specific checks for a single commit:

```bash
SKIP_TESTS=1 git commit            # skip all test/lint checks
SKIP_TDD=1 git commit              # skip TDD file-ratio check
SKIP_SMOKE=1 git commit            # skip smoke test
ALLOW_MULTI_FILE=1 git commit      # suppress multi-file warning
ALLOW_APPROVAL_SKIP=1 git commit   # skip approvals doc check
```

### Emergency Escape

```bash
git commit --no-verify   # skip ALL hook checks
```

This should be used sparingly — a commit that bypasses the hook also bypasses governance enforcement. Only use `--no-verify` when the hook is incorrectly blocking a legitimate commit (file a bug in that case).
