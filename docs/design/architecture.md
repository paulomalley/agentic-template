# Architecture

## Tech Stack
- **Runtime:** [e.g., Node.js 20]
- **Language:** [e.g., TypeScript 5.x]
- **Framework:** [e.g., Express / Next.js / none]
- **Database:** [e.g., PostgreSQL 16 / SQLite / none]
- **Testing:** [e.g., Vitest / Jest / node:test]
- **CI/CD:** [e.g., GitHub Actions]

## Project Structure
```
src/
├── [domain]/         # business logic modules
├── [routes]/         # API route handlers (if applicable)
└── [lib]/            # shared utilities
tests/
├── unit/
├── integration/
├── e2e/
└── smoke/
```

## Service / Module Boundaries
Crossing any of these boundaries triggers the integration-test requirement (per `.clinerules/05a-integration-policy.md`):
- [ ] Boundary 1: [describe, e.g., "Database access layer"]
- [ ] Boundary 2: [describe, e.g., "External API client"]
- [ ] Boundary 3: [describe, e.g., "File system I/O"]

## Design Decisions
| Decision | Rationale | Date |
|---|---|---|
| [Example: Use in-memory SQLite for tests] | [Avoids Docker dependency; fast test execution] | [YYYY-MM-DD] |

## Key Interfaces / Contracts
- **[Interface name]**: [purpose, inputs, outputs]

## Constraints
- [Constraint 1, e.g., "No runtime dependencies beyond Node.js stdlib"]
- [Constraint 2, e.g., "Must support Windows + Unix paths"]