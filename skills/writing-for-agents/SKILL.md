---
name: writing-for-agents
description: Writing standards for any document an AI agent consumes — a skill, a CLAUDE.md/AGENTS.md, or a doc reached by a pointer. Use when creating or editing a skill, or writing/editing CLAUDE.md, AGENTS.md, or any reference doc meant to be read by an agent rather than a human alone.
---

# Writing for Agents

The packaging differs across a skill, a `CLAUDE.md`, or a doc reached by a pointer — the writing
discipline doesn't. The goal isn't a document a human reads once; it's a document that gets an
agent to the same *process* every run, not just the same output.

## Context pointers

A context pointer is a reference living in the agent's always-loaded context (a skill
description, a `CLAUDE.md` line) that names material and encodes when to reach it. The pointer's
*wording* — not its target — decides whether the agent actually reaches the material, and how
reliably.

- Front-load the trigger word — the pointer does its work at the start, not buried in a clause.
- One trigger per distinct case. Synonyms restating the same case are the same branch written
  twice — collapse them.
- Cut identity the target document already states — don't restate the material in the pointer.

## Two budgets, spent differently

- **Context load** — the cost of always-loaded material (a skill description, a `CLAUDE.md`
  line) on every single turn, whether or not it fires.
- **Cognitive load** — the cost on the human of knowing which documents exist and when to reach
  for each. Not a cost to eliminate — it's the price of human judgment; spend it where the
  judgment matters, remove it where it doesn't.

Material behind a pointer pays only the pointer's cost in context load; material with no pointer
rides entirely on someone remembering it exists.

## Information hierarchy — where each piece of content sits

1. **In-file step** — what the agent does, in order. The primary tier.
2. **In-file reference** — consulted on demand, but still in the main file (e.g. a flat rule
   list).
3. **Disclosed reference** — pushed to a separate file, reached only through a pointer, loaded
   only when it fires.

Push too little down and the top of the document bloats past what every run needs; push too much
down and material the agent actually needs stays hidden. **Progressive disclosure** is moving
material down this ladder as it stops being universally needed — the branching test: inline what
every path needs, disclose what only some paths reach.

**Co-location**: keep a concept's definition, rules, and caveats under one heading rather than
scattered across the document, so reading one part brings its neighbors with it.

## Leading words

A leading word is a compact, already-understood term (*seam*, *tracer bullet*, *red/green*) that
anchors a whole region of behavior in a few tokens by recruiting priors the model already has,
instead of restating a description every time. Reuse an existing well-known term before coining
a new one — a made-up word carries no priors, so you pay in definition tokens what a pretrained
word gives free.

Avoid steering by **negation** ("don't do X") — naming the forbidden behavior makes it *more*
available to the model, not less. State the positive target instead ("write one-line comments,"
not "don't over-comment").

## Pruning

- **Single source of truth.** The same meaning stated in two places is duplication — costs
  upkeep, and inflates that meaning's apparent importance.
- **Don't restate the environment.** `package.json` scripts, config, `--help` output are sources
  of truth on their own; a doc that copies them is a stale cache waiting to happen. Document the
  unwritten convention or the reason behind a choice — not what a one-command lookup already
  answers.
- **Check relevance regularly.** A line that no longer bears on the task, or has gone stale as
  the world changed, should go. Without this habit, documents accumulate sediment — old layers
  nobody wants to be the one to delete.
- **Cut no-ops.** An instruction the agent already does by default costs tokens for nothing. If
  it doesn't change behavior, delete the sentence.

## Skills specifically: model-invoked vs. user-invoked

- **Model-invoked** — has a description the agent can match against context; the agent decides
  when to reach for it. Always costs a little context load (the description), in exchange for
  auto-discovery.
- **User-invoked** (`disable-model-invocation: true`) — only reached when the user explicitly
  types it. Zero ongoing context load, at the cost of the human having to remember it exists.
- **Router skill** — a user-invoked skill that's just an index of other user-invoked skills, so
  the human doesn't have to hold that whole list in their own head.

Pick model-invoked for anything the agent should apply by default (a discipline, a standard);
user-invoked for anything expensive, destructive, or only useful when deliberately asked for —
matches how `design-lab` (manual) vs. `prototype` (auto-triggers) are split in this repo.

## See also

- `creating-skills` — the meta-skill for generating a new skill's structure. This skill is the
  writing discipline underneath it: `creating-skills` decides what a skill contains,
  `writing-for-agents` decides how any of it should be worded.
- `products/ald-os/context/product-builder-principles.md` — Engineering #14, Documentation is
  part of the deliverable. This skill is that principle's operational form.

## Source

Adapted from [mattpocock/skills](https://github.com/mattpocock/skills)' `writing-for-agents` and
`SKILL-MECHANICS.md`.
