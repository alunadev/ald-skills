---
name: canonical-docs
description: >
  Bootstraps or completes a project's canonical docs — PRD, App Flow, Design System, Tech Stack,
  Backend Structure, Implementation Plan, plus CLAUDE.md and progress.txt — through a relentless,
  one-question-at-a-time interview so nothing gets filled in by assumption. Adapts Matt Pocock's
  grill-me interview discipline (silent decision tree, one question at a time, always paired with
  a recommended answer, exhaust one doc before the next) to project setup instead of code review.
  Use when starting a brand-new project or product and you want the full knowledge-base set in
  place before any building or AI-assisted coding begins, or when an existing/in-progress project
  has partial or stale canonical docs that need to be completed or precision-checked. Triggers on
  "/canonical-docs", "quiero documentar este proyecto en canonical docs", "vamos a crear/precisar
  los canonical docs de [producto]", "grill me on the canonical docs", "empezar un proyecto nuevo"
  when the user wants the full doc set (not just a PRD — for that alone use `prd-writer`), "this
  product needs its docs completed before we build". Do NOT trigger on vague feature requests with
  no mention of documentation or project setup — that's `brainstorming` or `idea-validator`'s job.
---

# Canonical Docs — Grill-Me Bootstrap

## Why This Matters

Every new project starts the same way without this skill: re-explaining the stack, the scope, the
schema, and the conventions from scratch in every new chat, because nothing was written down the
first time. The canonical docs set exists so an AI agent — or a human collaborator — can open the
project cold and know exactly what's being built, for whom, with what stack, against what schema,
and in what order, without asking Adrian to repeat himself.

The interview exists because a doc filled in with guesses is worse than no doc — it looks
authoritative but silently encodes the agent's assumptions instead of the user's decisions. This
skill's job is to make sure every field in every doc is either a confirmed decision or an
explicitly labeled open question. Never both unlabeled.

Read `references/interview-protocol.md` in full before asking a single question — it is the
actual discipline this skill runs on (silent decision tree first, one question at a time, always
with a recommended answer, exhaust one doc before the next, push back on non-answers, never leave
a bare `[FILL IN]`). This SKILL.md file is the orchestration; the protocol file is the how.

## When to Use

- Starting a brand-new product or side project and you want the full knowledge-base set in place
  before writing any code or running other build-oriented skills.
- An existing project — including a lighter `ald-system/products/<name>/` folder that only has
  `context/*.md` + `CLAUDE.md` + `progress.txt` — is graduating into a real build and needs the
  full doc set: PRD, App Flow, Design System, Tech Stack, Backend Structure, Implementation Plan.
- A project has canonical docs already, but they're stale, half-filled, or were written by
  someone (or something) guessing instead of asking — "precisar" a project in progress.

## When NOT to Use

- The user just wants a single PRD for one feature inside an already-documented product → use
  `prd-writer` directly.
- Requirements are vague and the user hasn't decided what they're building yet → use
  `idea-validator` then `brainstorming` first; canonical-docs assumes there's already a real
  product idea to document, not one that needs validating.
- A quick one-off design decision mid-build → use `brainstorming`, not this.

## Step 0 — Detect the Situation

Before asking anything, look at what already exists in the target project (or, for an ald-system
product, `products/<name>/`):

- **Nothing exists** → Greenfield. Copy the template set from `resources/templates/` into the
  target location (see "Output Map" below for exact destination paths), then run the full
  interview branch by branch.
- **The lighter context set exists** (`context/product-context.md`, `context/team-context.md`,
  `context/user-personas.md`, `CLAUDE.md`, `progress.txt`) but no `docs/product/`,
  `docs/design-system/`, or `docs/system/` → read the existing context files fully, then copy only
  the missing `docs/` templates and interview for those branches. Don't re-ask what the context
  files already answer — surface it back for confirmation instead (see protocol step on existing
  projects).
- **Full or partial canonical docs already exist** → read every file fully first. For each
  branch, diff what's already answered against the question bank; only ask about gaps, stale
  answers, or unlabeled `[FILL IN]` placeholders left over from a previous incomplete pass.

## Step 1 — Run the Interview

Follow `references/interview-protocol.md`'s branch order exactly:

```
1. Team & Constraints        → context/team-context.md
2. Product Context & Personas → context/product-context.md, context/user-personas.md
3. PRD                        → docs/product/prd.md
4. App Flow                   → docs/product/app-flow.md
5. Design System              → docs/design-system/design-system.md
6. Tech Stack                 → docs/system/tech-stack.md
7. Backend Structure          → docs/system/backend-structure.md
8. Implementation Plan        → docs/system/implementation-plan.md
```

For each branch: read `references/question-bank.md`'s matching section, ask one question at a
time with a recommended answer, write the file once the branch is resolved, give a short summary,
confirm before moving on. Do not skip ahead to a later branch to answer an earlier one's question
— if the user volunteers tech-stack info while you're on the PRD branch, note it and use it when
you get there, but stay on the current branch's questions until it's closed.

### Fast mode

If the user explicitly asks for a lighter pass ("just get me something rough," "don't grill me on
everything, I'm in a hurry"), you may compress each branch to its single highest-impact question
(marked "No default" in the question bank, or the first question listed per section) and fill the
rest with clearly labeled open questions rather than skipping the interview discipline entirely.
Say explicitly that you're running fast mode and what got deferred, so the user knows the docs are
intentionally incomplete, not silently guessed.

## Output Map

**New standalone project** (outside ald-system, e.g. a side-project repo):

```
<project-root>/
├── CLAUDE.md                          (from CLAUDE.template.md)
├── progress.txt
├── context/
│   ├── product-context.md
│   ├── team-context.md
│   └── user-personas.md
└── docs/
    ├── product/
    │   ├── prd.md
    │   └── app-flow.md
    ├── design-system/
    │   └── design-system.md
    └── system/
        ├── tech-stack.md
        ├── backend-structure.md
        └── implementation-plan.md
```

**Product inside ald-system** (`products/<name>/`): same file set, rooted at `products/<name>/`
instead of a separate repo. If `context/*.md` and `CLAUDE.md`/`progress.txt` already exist there
(the lighter pre-build convention), leave them in place and only add the `docs/` subtree unless the
interview surfaces that the existing context files need updating too.

## Step 2 — Close Out

Follow the protocol's closing steps: update `progress.txt` and `CLAUDE.md` with what was decided,
then give one consolidated summary — every doc written, what's confirmed per doc, and every open
question across all docs gathered in one place (not buried per-file). Recommend the next skill:
`planning` if the Implementation Plan's phases are ready to atomize, `brainstorming` if a specific
design decision still needs exploring, or nothing further if the docs are the whole ask.

## Reference Files

- `references/interview-protocol.md` — the actual interview discipline (read in full before
  asking the first question).
- `references/question-bank.md` — concrete questions and recommended defaults per branch (read
  one section at a time, as you reach that branch).
- `resources/templates/` — the canonical doc templates. This directory is the source of truth for
  the doc structure and field set; copy from here, don't hand-roll a different structure.

## See Also

- `prd-writer` — for a single feature PRD inside an already-documented product.
- `brainstorming` — for a specific design/architecture decision, standalone or mid-interview.
- `planning` — the natural next step once the Implementation Plan's phases are agreed.
- `user-discovery` — if the "Product Context & Personas" branch reveals the user segment isn't
  actually validated yet; that's a signal to pause and run discovery before locking a PRD.
