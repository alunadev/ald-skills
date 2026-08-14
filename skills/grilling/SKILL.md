---
name: grilling
description: Short clarifying interview before starting non-trivial engineering work — surfaces the actual requirement, what's explicitly out of scope, and what proves it's done. Use before writing code when the task's requirement, scope, or definition of done isn't already unambiguous. Not for trivial or fully-specified changes — that's ceremony, not clarity.
---

# Grilling

A short, structured interview before code gets written — the engineering counterpart to
`brand-identity`'s design interview. The goal isn't exhaustive requirements-gathering; it's
surfacing the handful of decisions that would otherwise get assumed silently and cost more to
unwind later than to ask now.

## When to use it

Trigger before starting work where any of these is genuinely unclear:

- The actual requirement — what "done" means, concretely: a test, a behavior, a metric.
- What's explicitly out of scope — naming it before it happens is the fastest way to avoid
  scope creep.
- Which existing pattern or module this should follow, if any.

Skip it for trivial or fully-specified changes. A one-line fix or a task with an already-explicit
spec doesn't need an interview — asking anyway is ceremony, not clarity.

## How it works

Ask in rounds, not all at once — a **frontier** of the questions that can be answered right now,
without waiting on anything else:

1. List every open question you can see (requirement, scope, done-criteria, existing pattern to
   follow).
2. Drop any question you could answer yourself by looking at the codebase — grep, read the
   relevant file, check how a similar feature was built. Never ask for something discoverable.
3. Present the remaining frontier together, one round, each question tagged with a recommended
   answer:

   ```
   ❓ Q1 — <title>: <question>
   ➡️ <your recommended answer, and why>
   ```

4. Wait for confirmation before writing code. A silent assumption here is exactly the failure
   mode this skill exists to prevent.
5. If an answer opens new questions, that's a new, smaller frontier — repeat, don't front-load
   everything upfront.

## Completion criterion

The frontier is empty and the user has confirmed the shared understanding — not just answered
questions, but confirmed nothing was assumed. That confirmation is the actual gate, not a
nice-to-have.

## See also

- `brand-identity` — the same pattern, applied to design instead of engineering.
- `products/ald-os/context/product-builder-principles.md` — Engineering #12, Clarify before
  building. This skill is that principle's operational form.

## Source

Adapted from [mattpocock/skills](https://github.com/mattpocock/skills)' `grilling` skill
(design-tree/frontier questioning model), scoped down from its full generic-interview form to
engineering clarification specifically.
