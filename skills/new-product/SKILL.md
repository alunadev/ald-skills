---
name: new-product
description: >
  Orchestrates building a product from zero — the order the documents get written, and which
  skill writes each one. Frame, art direction, define, foundations, design outside the code,
  build, review, ship, measure. Use when starting a new product, app, site or tool with nothing
  built yet, or when a folder is empty and the next move would otherwise be writing code. For a
  product that already exists, use `evolve-product` instead.
---

# Building a product from zero

Nine stages. The value is the **order**: each stage's document is the next stage's input. Skip
one and the next stage invents it — which is how a product ends up with an identity nobody chose.

You are orchestrating. Each stage names the skill that does the actual work; load it there
rather than reimplementing it here.

## Before anything

Check what already exists. If the folder has real content — a populated `CLAUDE.md`, source
files, a live product — **stop and switch to `evolve-product`.** This skill overwrites nothing,
but running it on a live product produces documents that describe a product that doesn't exist.

If the folder is empty or near-empty, bootstrap from the templates in
`ald-system/templates/canonical-docs/`: `CLAUDE.md`, `progress.txt`, `constraints.md`,
`papercuts.md`, and the `docs/` tree. Fill in the identity section before moving on — everything
downstream refers back to it.

## The nine stages

| # | Stage | Produces | Skill |
|---|---|---|---|
| 0 | Frame | `brief.md`, `constraints.md` §1 §2 §5 | `grilling` |
| 1 | Art direction | `ART-DIRECTION.md` → `DESIGN.md` | `art-direction` → `design-md` |
| 2 | Define | `prd.md`, `CONTEXT.md`, tracking plan | `prd-writer`, `domain-modeling`, `/tracking` |
| 3 | Foundations | `architecture.md`, token file, code conventions | `codebase-design` |
| 4 | Design | screens, **outside the production code** | `prototype` / `design-lab` (or Figma) |
| 5 | Build | the code | `tdd`, `taste-skill`, `codebase-design` |
| 6 | Review | — | `code-review`, `pr-review-toolkit` |
| 7 | Ship | preview deploy, then merge | `deploying-to-github`, `product-launch` |
| 8 | Measure | `papercuts.md` opens | `product-analytics` |

### 0 — Frame

Interview the user before proposing anything, so the proposal is justified in their own words.
On a solo project they are both client and builder — run it anyway; it is what makes everything
downstream defensible.

Write the constraints **before considering any solution**: flows that must be supported, states
that must be handled, what you are explicitly not doing. Alexander's rule — if a constraint has
to change later, you come back here rather than patching forward.

### 1 — Art direction

`art-direction` produces `ART-DIRECTION.md`: central idea, visual attributes, cultural
references from outside the sector, photographic direction, three typographic and chromatic
concepts, and the permanent anti-cliché list.

Then `design-md` reads that file and turns the chosen concept into `DESIGN.md` tokens. It skips
its own interview when `ART-DIRECTION.md` exists.

**Do not let stage 4 start before both files exist.** Screens designed without them are where
the identity gets decided by accident.

### 2 — Define

Let the agent interview the user rather than writing the PRD cold. `prd-writer` owns the PRD;
`domain-modeling` owns the nouns in `CONTEXT.md`; `/tracking` defines the analytics events
**now**, so stage 8 isn't bolting them on afterwards.

Design scope is set here and stays small on purpose: **the main flow plus 3-4 core screens.**

### 3 — Foundations

What parts the system has, how they talk, and the code conventions so the agent writes the same
way every time. `DESIGN.md`'s tokens become a real token file here. Humans decide what and why;
the agent executes how.

### 4 — Design

**Never in the production codebase.** Once v1 exists in the real code, exploration stops and
refinement of that one option begins — prototype gravity. Design 3-4 variants of the main flow
and the core screens somewhere else, using the stage-3 tokens so every variant could ship, then
bring the decision back.

### 5-8 — Build, review, ship, measure

Search open source before writing anything. Component-first: tokens → atoms → molecules →
sections → pages. TDD on logic, not layout.

At review, **remove the agent's litter** — extra copy, lines, icons, belt-and-suspenders code —
then check the design against `~/.claude/CLAUDE.md`'s principles and `ART-DIRECTION.md` §6.

Ship behind a preview deploy with real data; holding it with real content is the only way to
know it is right.

At measure, `papercuts.md` opens and never closes. It is what feeds `evolve-product`.

## Rules that hold across every stage

- **The documents complement; they never restate each other.** Principles are global,
  `ART-DIRECTION.md` owns the territory, `DESIGN.md` owns the values, `constraints.md` owns
  what is true of this project alone. Copying a value between them is how they start to disagree.
- **A stage's output is the next stage's input.** If a document is missing, go back and write
  it rather than inferring it.
- **Constraints change deliberately.** A change gets a row in the `constraints.md` change log and
  triggers a cohesive redesign of the affected area — never a spot fix.
