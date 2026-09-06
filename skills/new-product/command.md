Runs the zero-to-one product loop — the order the documents get written, and
which skill writes each one.

Usage: /new-product [what you're building, in a line]

The nine stages:
0. Frame — brief + constraints, written before any solution is considered
1. Art direction — ART-DIRECTION.md, then DESIGN.md from the chosen concept
2. Define — PRD, the domain nouns, the analytics events
3. Foundations — architecture, tokens, code conventions
4. Design — 3-4 variants, outside the production codebase
5. Build — component-first, TDD on logic
6. Review — remove the agent's litter, then check against the principles
7. Ship — preview deploy with real data before merge
8. Measure — and papercuts.md opens

Each stage's document is the next stage's input. Skipping one means the next
stage invents it.

When to use:
- A new product, app, site or tool with nothing built yet
- An empty folder where the next move would otherwise be writing code

When not to use:
- The product already exists — use `/evolve-product`, which starts by deriving
  the missing documents from what's actually there
