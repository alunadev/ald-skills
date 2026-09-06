Runs the loop for a product that already ships — either the first pass that
derives its missing documents, or a normal iteration.

Usage: /evolve-product [the change, or "adoption pass"]

Two modes, checked automatically:

ADOPTION PASS — when DESIGN.md / constraints.md / papercuts.md don't exist yet.
A live product can't be documented forwards, so this goes backwards and
extracts: does CLAUDE.md still describe the product, what typefaces and weights
actually ship, whether an art direction can even be written by looking at it,
what the real constraints are, and what already annoys you. Every step produces
findings only you can decide on, so it runs with you, not for you.

ITERATION — the normal loop:
0. Feature or outcome?
1. The gate — does this change a constraint? (redesign / fix now / papercuts)
2. Spec, not a full PRD
3. Design the changed screens, outside the production code
4-7. Build, review, ship, measure — reuse before you create

When to use:
- Adding a feature or changing something already built
- A live project that has never had its documents written

When not to use:
- Nothing is built yet — use `/new-product`
