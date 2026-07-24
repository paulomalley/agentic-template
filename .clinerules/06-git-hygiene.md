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

## Pre-Commit Validation
**This is now enforced by a Git pre-commit hook (via Husky).** The hook runs the test suite, linter, and checks for cache files. Do not rely on manual memory â€” the hook will block bad commits automatically. See `.husky/pre-commit` for the exact checks.