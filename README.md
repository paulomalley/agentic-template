# Agentic Template

A reusable governance scaffold for agent-driven software projects. Provides `.clinerules/` for AI agent behavior, `docs/` for project governance, and supporting scripts and hooks.

## 4-Phase Execution Pipeline

Every Standard or Feature task moves sequentially through 4 phases, orchestrated by `.clinerules/00-phase-orchestration.md`:

| Phase | Name | Goal |
|---|---|---|
| 1 | **GROUND** | Ingest state without modifying files — run `/onboard`, read `docs/approvals.md` and requirements docs |
| 2 | **PLAN** | Architect the feature — draft governance docs and structural blueprints (interfaces/types) |
| 3 | **ACT** | TDD implementation — write tests and production code side-by-side, zero placeholders, bounded loops |
| 4 | **VERIFY** | Audit & quality gate — integration tests, Playwright E2E, smoke tests, Husky pre-commit checks |

**Key gates:**

- 🛑 **HUMAN GATE** at the end of PLAN — skeleton/blueprint sign-off is required before switching to ACT.
- **Tier 0 classification** (`.clinerules/00-task-classification.md`) determines how much of the pipeline applies: Micro and Hotfix tasks bypass phases, Standard tasks keep full onboarding + TDD, Feature/Architectural tasks run the full pipeline including skeleton sign-off.
- **Two-strike rule** (`.clinerules/04-state-control.md`) governs error handling during TDD — repeated identical failures stop iteration and request human intervention.

## Directory Layout

```
.clinerules/
├── 00-phase-orchestration.md      # 4-phase pipeline: GROUND → PLAN → ACT → VERIFY
├── 00-task-classification.md      # Task sizing (Micro / Standard / Feature / Hotfix)
├── 01-onboarding-policy.md        # Onboarding workflow trigger
├── 02-workspace-safety.md         # Scope and command safety
├── 03-code-by-constraint.md       # Skeleton-first, TDD, engineering discipline
├── 04-state-control.md            # Two-strike error rule, multi-file transforms
├── 05-phase-gate-policy.md        # Governance process, sign-off gates
├── 05a-integration-policy.md      # Integration test requirements for boundary paths
├── 05b-e2e-policy.md              # E2E/UAT test requirements
├── 06-git-hygiene.md              # Commit practices, atomic commits, pre-commit hooks
├── 07-cli-execution-safety.md     # Pager avoidance, chaining rules, dev server pre-flight
├── 08-test-structure.md           # Test directory layout conventions
├── hooks/
│   └── hooks.md                   # Automatic event trigger documentation
├── skills/
│   ├── SKILL.md                   # governance-templates skill
│   └── testing/
│       └── SKILL.md               # Testing reviewer skill
└── workflows/
    ├── onboard.md                 # Task onboarding & context restoration
    ├── offboard.md                # Task offboarding & documentation
    ├── monitor-ci.md              # Post-push CI monitoring
    └── run-e2e.md                 # Run end-to-end test suite
.husky/
└── pre-commit                     # Git pre-commit hook (enforces .clinerules governance)
docs/
├── approvals.md                   # Phase-gate approval log
├── design/
│   └── architecture.md            # System architecture template
└── requirements/
    ├── brd.md                     # Business requirements template
    ├── frd.md                     # Functional requirements template
    └── feature_requests.md        # Feature request intake template
scripts/
└── monitor-ci.ps1                 # CI monitoring script (PowerShell)
```

## Usage

### For a new project (GitHub Template)
Click **"Use this template"** on the repo page, then start coding.

### For an existing project
Copy the relevant directories and merge what you need:

```bash
# Copy all rules, skills, workflows, hooks
cp -r .clinerules/ /path/to/your-project/

# Copy governance docs
cp -r docs/ /path/to/your-project/

# Copy CI monitor script
cp -r scripts/ /path/to/your-project/

# Copy pre-commit hooks
cp -r .husky/ /path/to/your-project/

# Merge package.json scripts (test runners)
# Merge .gitignore entries
```

### With git subtree (keeps sync capability)
```bash
git subtree add --prefix=.clinerules https://github.com/paulomalley/agentic-template.git main --squash
```

## Per-Project Customization

| File | What to Customize |
|---|---|
| `.clinerules/00-phase-orchestration.md` | Phase triggers, gates, or pipeline wording if your workflow diverges |
| `.clinerules/00-task-classification.md` | Tier thresholds (e.g. Micro size limits, file-count rules) for your project |
| `.clinerules/05a-integration-policy.md` | `paths:` frontmatter — set project boundary paths |
| `.clinerules/05b-e2e-policy.md` | `paths:` frontmatter — set which changes require E2E coverage |
| `docs/design/architecture.md` | Tech stack, actual boundaries, design decisions |
| `docs/requirements/brd.md` | Project-specific problem, goals, success criteria |
| `package.json` | Merge test scripts, remove stubs |
| `.husky/pre-commit` | Adjust test/lint commands for project toolchain |