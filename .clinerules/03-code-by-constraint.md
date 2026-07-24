# Code by Constraint

## Skeleton First
For Standard and Feature/Architectural tasks involving new/refactored components, modules, or features, output or verify the structural skeleton (interfaces, abstract classes, data types) first. Display this blueprint in chat and explicitly await human sign-off before writing concrete logic. (Skipped for Micro and Hotfix â€” see Tier 0.)

## Zero Placeholders
Never emit incomplete code or placeholders. Every block of code must be syntactically complete.

## Engineering Discipline (adapted from JPL's "Power of Ten")

**Hard rules:**
1. **Simple control flow** â€” avoid deep nesting; no unbounded recursion without a base case and an explicit depth guard. Avoid deep object/property chains and callback pyramids that make control flow hard to follow.
2. **Bounded loops** â€” every loop, including retry/polling loops, must have a provably terminating condition and a max-iteration cap. Not "loop until success." (Cross-references the two-strike/stuck-loop rule in `04-state-control.md`.)
3. **Assertion / validation density** â€” meaningful input validation or guard clauses at function entry, not just error handling at the boundary.
4. **Check all return values / handle all errors** â€” no unchecked async calls, no swallowed exceptions, no ignored promise rejections; validate parameters before use.
5. **Minimal metaprogramming** â€” avoid `eval`, `new Function()`, or deserializing into dynamic execution. Standard framework patterns (decorators, DI containers, ORMs) are not what this rule targets.
6. **Zero-warnings policy** â€” linter and type-checker must run clean. Treat warnings as build-breaking, not advisory.

**Advisory â€” flag for human review, don't auto-block:**
7. **Function length** â€” a function that doesn't fit on one screen (~60 lines) is worth flagging for a possible split, but don't force a split where it would produce worse code (e.g. arbitrary fragmentation of a declarative config or component tree).
8. **Variable scope** â€” prefer the smallest scope that works; flag *incidental* module-level mutable state, but intentional singletons (DB connection pools, app instances) are normal and not a violation.

**Scoped, not universal:**
9. **Bounded resource growth** â€” long-running processes must not have unbounded in-memory caches, buffers, or collections; anything that accumulates needs an eviction policy or hard limit. Does not apply to stateless/serverless functions or short-lived scripts.