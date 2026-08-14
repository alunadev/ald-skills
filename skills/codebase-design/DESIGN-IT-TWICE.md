# Design It Twice

When exploring alternative interfaces for a chosen deepening candidate, use this parallel
sub-agent pattern. Based on "Design It Twice" (Ousterhout) — the first idea is unlikely to be
the best one.

Uses the vocabulary in [SKILL.md](SKILL.md) — **module**, **interface**, **seam**, **adapter**,
**leverage**.

## Process

### 1. Frame the problem space

Before spawning sub-agents, write a user-facing explanation of the problem space for the chosen
candidate:

- The constraints any new interface would need to satisfy.
- The dependencies it would rely on, and which category they fall into (see
  [DEEPENING.md](DEEPENING.md)).
- A rough illustrative code sketch to ground the constraints — not a proposal, just a way to
  make the constraints concrete.

Show this before spawning agents, so there's something concrete to compare designs against.

### 2. Spawn sub-agents

Spawn 3+ agents in parallel. Each must produce a **radically different** interface for the
deepened module.

Give each a separate technical brief (file paths, coupling details, dependency category from
[DEEPENING.md](DEEPENING.md), what sits behind the seam) and a different design constraint:

- Agent 1: "Minimize the interface — aim for 1-3 entry points max. Maximize leverage per entry
  point."
- Agent 2: "Maximize flexibility — support many use cases and extension."
- Agent 3: "Optimize for the most common caller — make the default case trivial."
- Agent 4 (if applicable): "Design around ports & adapters for cross-seam dependencies."

Include both the SKILL.md vocabulary and any project `CONTEXT.md` vocabulary in the brief so
each agent names things consistently with both the architecture language and the project's
domain language.

Each agent outputs:

1. Interface (types, methods, params — plus invariants, ordering, error modes).
2. Usage example showing how callers use it.
3. What the implementation hides behind the seam.
4. Dependency strategy and adapters (see [DEEPENING.md](DEEPENING.md)).
5. Trade-offs — where leverage is high, where it's thin.

### 3. Present and compare

Present designs sequentially, then compare them in prose. Contrast by **depth** (leverage at
the interface), **locality** (where change concentrates), and **seam placement**.

Give an explicit recommendation: which design is strongest and why. If elements from different
designs combine well, propose a hybrid. Be opinionated — a strong read beats a menu of options.
