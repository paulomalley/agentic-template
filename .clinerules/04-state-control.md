# State Control & Resilience

1. TWO-STRIKE ERROR RULE:
   - **During active TDD iteration** (writing/adjusting a test and its implementation within the same execution block), iterate freely to get the test passing â€” expected redâ†’green cycling is not a "failure" under this rule.
   - **Stuck-loop trigger**: if the *same test* fails with the *same error signature* more than 5 consecutive attempts, OR the error output shows no change across iterations, STOP. Present logs, state your theory, request human intervention.
  - **Outside TDD** (build failures, runtime errors, non-test execution): two consecutive identical failures = STOP immediately, present logs, state your theory, request human intervention.
  - "Same error signature" means: the error message text, exit code, and the specific file/line referenced (if any) are all identical between consecutive runs. Different line numbers in the same file, or different assertion values, count as a different signature.
  - Suspended during the diagnostic phase of a declared Hotfix (see Tier 0).
   - This is the runtime enforcement of the "bounded loops" principle in `03-code-by-constraint.md` â€” that rule covers loops written into code, this one covers the agent's own retry behavior.
2. MULTI-FILE TRANSFORMS: Before modifying more than 3 distinct source files simultaneously, explicitly prompt the user to confirm a clean Git checkpoint has been established.