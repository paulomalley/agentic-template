# Task Classification (Tier 0)

At the start of every new task, before onboarding, self-classify the task and state the classification + reasoning for human confirmation. If uncertain which tier applies, default UP to the stricter tier.

- **Micro**: single file, â‰¤20 lines changed, no schema/API/route change, no new dependency, does not touch auth/payments/data-deletion/migrations/security-sensitive code, and requires no clarifying questions about scope or intent.
  - Skips full onboarding and PLANâ†’ACT / skeleton sign-off.
  - Still requires: tests-pass + lint-pass and an atomic commit.
- **Standard**: everything else short of a new feature/architecture change.
  - Keeps full onboarding + TDD.
  - Skips skeleton-first architectural blueprint sign-off.
- **Feature/Architectural**: new feature/component, schema change, new route, or changes touching >3 files.
  - Full pipeline: PLAN mode, governance docs, skeleton sign-off, phase gates.
- **Hotfix**: user-declared ONLY â€” never self-classified.
  - Skips PLANâ†’ACT gating, skeleton sign-off, and governance-doc review.
  - Still requires: a failing test reproducing the bug BEFORE the fix, and a passing test AFTER.
  - Still requires: an atomic commit tagged `hotfix:`, referencing the incident/issue if one exists.
  - Triggers a mandatory follow-up: within the same session or the next, retroactively update the governance docs to reflect the emergency change, flagged in `docs/approvals.md` as "emergency bypass â€” retroactive documentation."
  - The two-strike rule's "stop and wait" behavior is suspended only during the diagnostic phase (reading logs, reproducing the issue); once a fix is being applied, normal failure-handling resumes.

Other rule files reference these tiers by name (e.g. "skipped for Micro/Hotfix") rather than restating the exceptions â€” this file is the source of truth for what each tier bypasses.

If a workspace's `.clinerules/` overrides this file (e.g. different tier thresholds for that project), the workspace version wins.