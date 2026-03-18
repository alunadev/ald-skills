# Question Bank — Prompt Clarifier

A categorized library of Socratic questions for enriching vague prompts.

**Usage rule:** Ask max 3 questions per session. Start with the highest-impact gap.
Prefer multiple-choice over open-ended. Accept brief answers and move on.

---

## Category 1 — Intent
*Ask first for "fix", "improve", "make better", "it's broken" prompts.*

**Q1 — Behavior gap** (highest priority for bug fixes)
> "What's happening now vs. what should happen? Describe the specific behavior that's wrong."

*Why:* Without this, the agent will guess what "fixed" means. The behavior gap is the ground truth.

**Q2 — Problem type** (use when Q1 gives a vague answer)
> "Is this about: (A) correctness — wrong output or crash, (B) performance — it's slow or heavy,
> or (C) experience — it works but feels wrong?"

*Why:* Bug fix, optimization, and UX improvement require very different approaches.
Multiple-choice is faster than open-ended.

---

## Category 2 — Scope
*Ask first for "add X", "build X", "implement Y" prompts.*

**Q3 — Regression boundary**
> "What existing behavior must stay completely unchanged after this is done?"

*Why:* The most common source of rework. Knowing what can't break narrows the solution space
and prevents over-engineering.

**Q4 — Edge cases and user types**
> "Should this work for all users, or a specific subset? Any edge cases that must be handled
> in this iteration?"

*Why:* Prevents scope creep mid-task. "All users" vs. "admin users only" is a 10x scope difference.

---

## Category 3 — Constraints
*Ask for auth, payments, data-handling, or compliance-sensitive prompts.*

**Q5 — Security and compliance**
> "Any security or compliance requirements? For example: session handling rules, PII logging
> restrictions, rate limiting, or specific libraries to use or avoid."

*Why:* Security requirements discovered mid-implementation cause rewrites.
Getting this upfront costs 30 seconds; missing it costs hours.

---

## Category 4 — Success Criteria
*Ask if the intent answer didn't define what "done" looks like.*

**Q6 — Verification test**
> "How will you know this is working correctly? What's the simplest test or check that
> would satisfy you?"

*Why:* Success criteria transform a task from subjective to verifiable.
"User can log in" is done when you can demonstrate it, not when the code compiles.

---

## Category 5 — Context
*Ask if no file paths, component names, or entry points were mentioned.*

**Q7 — Entry point**
> "Which file, component, or system is the starting point for this change?
> (Or should I search the codebase for the relevant code?)"

*Why:* Grounding the task to a specific file prevents the agent from starting in the wrong place
and reading unrelated code. Offering to search is an escape hatch that avoids blocking.

---

## Question Selection Guide

| Prompt pattern | Ask first | Ask second | Skip |
|---------------|-----------|-----------|------|
| "fix [vague thing]" | Q1 (behavior gap) | Q6 (success criteria) | Q3 if simple |
| "make [thing] better" | Q2 (problem type) | Q1 (behavior gap) | Q4, Q5 |
| "add [feature]" | Q3 (regression boundary) | Q4 (scope/users) | Q2 |
| "build [feature]" | Q4 (scope/users) | Q3 (regression boundary) | Q2 |
| "refactor [thing]" | Q3 (regression boundary) | Q6 (success criteria) | Q4, Q5 |
| "add auth/payments/data" | Q5 (security) | Q3 (regression boundary) | Q2 |
| No file path mentioned | Q7 (entry point) | depends on above | — |

---

## Tone Calibration

- Keep questions **short** — one sentence maximum.
- **Don't stack questions.** One question per message.
- When the user gives a short answer, **accept it** and move to enrichment.
- If the user says "just figure it out", skip remaining questions and enrich with `[assumed]` labels.
- Never ask for information you can get by reading the codebase yourself.
