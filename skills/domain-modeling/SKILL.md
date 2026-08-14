---
name: domain-modeling
description: Maintains a project's domain vocabulary and records architecturally-significant decisions as they're made — a CONTEXT.md glossary and gated ADRs, not passive documentation read once. Use when terminology conflicts or turns fuzzy, when making a decision that's hard to reverse/surprising/a real trade-off, or when a stated domain rule doesn't match what the code actually does.
---

# Domain Modeling

An active discipline for keeping a project's domain vocabulary and its consequential decisions
accurate as the project changes — not documentation written once and left to rot.

This is the reduced, single-project version of the upstream skill — no `CONTEXT-MAP.md` or
multiple bounded contexts. If a project genuinely grows into more than one coherent domain,
that's a deliberate escalation to revisit, not the default here.

## Two artifacts

- **`CONTEXT.md`** at the repo root — the project's glossary: what terms mean, and what to
  avoid calling them instead.
- **`docs/adr/`** — Architecture Decision Records, created lazily, only when the first one is
  actually needed. One per consequential decision.

## Core practices

1. **Challenge imprecision immediately.** When a term conflicts with `CONTEXT.md`, or starts
   meaning two different things in different places, raise it right away — don't let ambiguity
   sit.
2. **Stress-test with scenarios.** Invent a specific edge case to check whether a stated domain
   relationship actually holds, before trusting it.
3. **Verify against implementation.** Cross-check what `CONTEXT.md` says against what the code
   actually does. Surface the contradiction when they disagree — one of them is wrong.
4. **Capture decisions immediately, not in a batch.** Update `CONTEXT.md` the moment a term
   crystallizes — not as a cleanup pass later.

## CONTEXT.md format

```md
# {Project Name}

{One or two sentence description.}

## Language

**Term**:
{One or two sentence description of what it IS, not what it does.}
_Avoid_: {other words people might reach for instead}
```

Rules:

- Be opinionated — when multiple words exist for the same concept, pick one and list the rest
  under `_Avoid_`.
- Only project-specific terms belong. General programming concepts (timeouts, error types)
  don't, even if used constantly.
- Create the file lazily — the first time a term actually needs pinning down, not upfront as an
  exercise.

## When a decision earns an ADR

All three must be true:

1. **Hard to reverse** — changing your mind later has a real cost.
2. **Surprising without context** — a future reader (including you, in six months) would wonder
   why.
3. **A real trade-off** — there were genuine alternatives, and one was picked for specific
   reasons.

If a decision is easy to reverse, skip it — you'll just reverse it if needed. If it's not
surprising, nobody will ask. If there was no real alternative, there's nothing to record beyond
"did the obvious thing."

ADR template — one paragraph is enough:

```md
# {Short title of the decision}

{1-3 sentences: what's the context, what did we decide, and why.}
```

Numbered sequentially in `docs/adr/`: `0001-slug.md`, `0002-slug.md`. Create `docs/adr/` lazily,
only when the first one is needed. Optional sections (Status frontmatter, Considered Options,
Consequences) only when they add genuine value — most ADRs won't need them.

## Why this exists

Operationalizes Engineering #15 (Data gets a canonical shape at the boundary) and Engineering
#14 (Documentation is part of the deliverable) in
`products/ald-os/context/product-builder-principles.md` — a schema or shared vocabulary is a
contract even without a schema language, and a decision that only lives in your head is a
single point of failure.

## Source

Adapted, reduced-scope, from [mattpocock/skills](https://github.com/mattpocock/skills)'
`domain-modeling` skill — dropped `CONTEXT-MAP.md`/multi-bounded-context support, which is built
for larger team codebases than the current scale of Adrian's solo projects. Add it back if a
project genuinely grows into multiple distinct domains.
