---
name: evolve-product
description: >
  Orchestrates work on a product that already ships — a new feature, an improvement, or the
  first pass that derives a live product's missing documents from what is actually there. Runs
  the constraints gate that decides between a cohesive redesign, an immediate fix, and the
  papercuts log. Use when adding to or changing something already built, or when a live project
  has no DESIGN.md / constraints.md yet. For a product that doesn't exist, use `new-product`.
---

# Evolving a product that already exists

Two modes. Check which one applies before doing anything.

| Situation | Mode |
|---|---|
| The project has no `DESIGN.md` / `constraints.md` / `papercuts.md` | **Adoption pass** — run it once, first |
| Those documents exist | **Iteration** — the normal loop |

Do not run iteration on a project that has never had an adoption pass. The gate at its centre
checks changes against `constraints.md`, and with no such file the gate is a rhetorical question.

---

## Mode 1 — The adoption pass

A live product cannot be documented forwards. It already has colors, flows and decisions nobody
wrote down, so starting from a brief means inventing a past. **You go backwards, extracting** —
and each extraction is also an audit.

Run it **with the user, not for them.** Every step produces findings only they can decide on.

| # | Document | How it is produced | What it surfaces |
|---|---|---|---|
| 1 | `CLAUDE.md` | Does it describe what the product *is* now, or what it was? | scope drift |
| 2 | `DESIGN.md` | Extract from the live product — `design-md`, extract direction | how many typefaces and weights actually ship |
| 3 | `ART-DIRECTION.md` | Usually **cannot** be extracted | if you can't write the central idea while looking at the product, there is no direction — that is the finding, not a failure |
| 4 | `constraints.md` | Derived from the real flows and the real code | violations that each need a decision |
| 5 | `papercuts.md` | Seeded from what already annoys the user | which area is worst |

**Step 2 and step 4 will surface violations of the global design principles.** Three typefaces
and five weights is normal in something built before the rule existed. Each one becomes a
decision, and all three answers are legitimate:

- **Fix it** now, if it is small,
- **Declare it** in `constraints.md` §4 as a deliberate deviation, with the reason, or
- **Log the area** in `papercuts.md` if it is genuinely minor.

What is not allowed is leaving it undecided. An undecided violation is where the file starts
lying about the product.

**Timebox this.** Harvest the flows and the style values; write "explicitly not doing" from what
the user already refuses; seed the papercuts. Then stop — do not backfill states and technical
constraints exhaustively. Each one gets added the first time it actually decides something.

Full method: `ald-system/docs/constraints-and-papercuts.md`.

---

## Mode 2 — Iteration

### 0. Is this a feature or an outcome?

Someone arrives with a solution — including the user themselves. Turn it back into the behavior
that should change and the cheapest way to test it. Skill: `feature-to-outcome`.

### 1. The gate

**The single most important step, and the one that stops design whack-a-mole.** Every change
answers one question before anything is touched:

> Does this change a constraint?

| Answer | What happens |
|---|---|
| **Yes** | Update `constraints.md` first, then redesign the affected area **cohesively** |
| **No, and obvious** | Fix it now |
| **No, and minor** | `papercuts.md`. Do not fix it today |
| **It contradicts `ART-DIRECTION.md` §6** | This is a rebrand, not a design task — it goes back to `new-product` stage 1 |

A papercut **violates nothing**. Anything that breaks a principle, a constraint, or §6 is a
violation and gets fixed now — inconsistent components across screens is the common case, and it
is fixed by extracting the component, not by matching styles. Deferring a rule already agreed to
turns the log into where real problems go to be ignored.

Papercuts resolve **by area**: when you touch an area anyway, resolve all of its papercuts as
one pass. If any single area reaches **5 open**, that area becomes work on its own.

### 2. Spec — not a full PRD

What the section does, the flows it touches, what is out of scope. The product overview, data
model and design system already exist; you are extending, not establishing. Skills:
`prd-writer` (spec mode), `grilling`.

### 3. Design — changed screens only

No art-direction stage: the identity exists, so read `DESIGN.md` and match it. Still **outside
the production codebase**, still 3-4 variants. Prototype gravity does not care that the product
already exists. Skills: `prototype` / `design-lab`, `taste-redesign`.

### 4-7. Build → review → ship → measure

Identical to `new-product` stages 5-8, with one addition at build: **reuse before you create.**
If a component exists, use it; if it nearly exists, extend it; only then write a new one. This is
what keeps a product from becoming a patchwork of re-implemented buttons.
