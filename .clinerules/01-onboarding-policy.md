# Onboarding Policy

For every new Standard or Feature/Architectural task, onboarding MUST occur before any planning or code changes. The detailed steps are defined in the `/onboard` workflow (see `.clinerules/workflows/onboard.md`).

**Key requirements:**
- Onboarding applies to Standard and Feature/Architectural tasks only (see Tier 0 for Micro/Hotfix exceptions).
- If `docs/` does not exist, create the governance doc structure before proceeding.
- The onboarding workflow will cross-check doc staleness against `git log` and flag inconsistencies.
- **Windows setup note:** On Windows, if the repository is owned by a different user/group (e.g. `BUILTIN\Administrators`) than the current user, git will block all operations with a "dubious ownership" error. Run the following once per workspace to resolve:
  ```
  git config --global --add safe.directory <absolute-path-to-project>
  ```
  This should be done as part of initial project setup before any git operations.

**Trigger:** Call the `/onboard` slash command at the start of each qualifying task.