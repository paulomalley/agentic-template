# Test Location

Tests live in a centralized `tests/` folder at the project root, with subfolders by type:

tests/
â”œâ”€â”€ unit/ # isolated logic, no I/O, no network
â”œâ”€â”€ integration/ # crosses a service/module boundary (DB, external API, handler layer)
â”œâ”€â”€ e2e/ # full user/system flow, end to end
â””â”€â”€ smoke/ # fast post-deploy or post-build sanity checks


- Mirror the source layout inside each subfolder where practical (e.g. `tests/unit/services/user.test.ts` for `src/services/user.ts`), so a test's location tells you what it covers.
- If a project's framework strongly conventionalizes a different layout (e.g. co-located `*.test.ts` files), confirm the deviation with the user during onboarding and record it in `docs/design/architecture.md` rather than silently diverging from this structure.
- A workspace rule file may define this project's actual service/module boundary paths (what counts as "crossing a boundary" for the integration-test requirement in `05-phase-gate-policy.md`) and which commands run each test type.