---
name: brainstorming
description: >
  Expert Socratic discovery skill for exploring ideas, architecture decisions, and technical design
  before writing any code. Use this skill — proactively and always first — when requirements are
  vague, when the user is debating between technical approaches, when the problem is unclear, or
  when a design decision could have significant architectural consequences. Triggers on: "should we
  use X or Y", "help me think through", "I'm not sure how to approach this", "what's the best
  architecture for", "trade-offs between", "design before I code", "let's think through this", "I
  have an idea", "how should I structure", "help me design", "I want to build X but not sure how",
  "what approach would you recommend", "is this the right way to". Produces a validated design doc
  with 2-3 implementation options, trade-offs, and a recommendation. Always use before planning
  when the approach is not yet locked.
---

# Brainstorming — Socratic Design Discovery

## Why This Matters

The most expensive code to write is the wrong code. Brainstorming exists to prevent that by forcing clarity on purpose, constraints, and design before any implementation begins. A 20-minute brainstorm saves hours of refactoring.

The Socratic method works here because users often don't know what they want — they know what they're trying to achieve. Your job is to ask questions that surface the real requirements hiding behind the initial idea.

## When to Use

- Requirements are vague or high-level ("I want to build X")
- The user is debating between technical approaches
- Architecture decisions have long-term consequences
- The feature touches multiple systems or has unclear boundaries
- A new idea needs reality-checking before investing in it

## Workflow

### 1. Context Loading First

Read relevant files, recent commits, and existing docs before asking a single question. Users find it frustrating to explain context that's already in the codebase. The goal is to arrive at the first question already informed.

### 2. Socratic Discovery

Ask **one question at a time**. Each question should unlock the next. Good questions:
- Surface constraints the user hasn't articulated yet ("What happens if X fails?")
- Force a choice between concrete options ("Do you want A — faster to ship but harder to change later — or B — more setup but more flexible?")
- Test assumptions ("Are you sure users will actually do Y?")

Prefer multiple-choice questions over open-ended ones. "Do you prefer A or B?" gets faster, more reliable answers than "How should we handle this?"

### 3. Optioneering

Once you understand the problem well enough, propose **2-3 distinct approaches** with explicit trade-offs. Don't hedge — lead with your recommendation and explain why.

```
Option A (Recommended): [description]
- Pros: [2-3 concrete benefits]
- Cons: [honest limitations]
- Best when: [specific context where this wins]

Option B: [description]
- Pros: [2-3 concrete benefits]
- Cons: [honest limitations]
- Best when: [specific context where this wins]

Option C: [description]
- [same format]
```

### 4. Design Verification

Present the design in small chunks (200-300 words each). After each chunk, check: "Does this look right so far?" Don't move to the next section until the current one is approved.

Cover in order:
1. Architecture overview
2. Key components and their responsibilities
3. Data flow between components
4. Error handling strategy
5. Testing approach

### 5. Output

Save the validated design to `docs/designs/YYYY-MM-DD-<topic>.md`. Once the design is locked, suggest moving to the `planning` skill for atomic task breakdown.

## What Good Looks Like

A completed brainstorm leaves the user with:
- A clear answer to "what are we building and why this approach"
- 2-3 rejected alternatives and why they were rejected (this is as valuable as the choice made)
- No ambiguity about the boundaries of the feature
- A design doc they could hand to another engineer

## References

- `references/socratic-questions.md` — Question bank organized by problem type (architecture, data model, API design, UI/UX, performance)
- `references/architecture-patterns.md` — Common trade-off frameworks (monolith vs microservices, sync vs async, SQL vs NoSQL, client-side vs server-side)

Read the relevant reference file when you need deeper question frameworks or trade-off analysis for a specific domain.
