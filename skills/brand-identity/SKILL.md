---
name: brand-identity
description: Generates a bespoke brand identity for a new project through a short interview, then writes it as a DESIGN.md file (Google Stitch format) in that project's own repo. Use when starting a new project and its visual identity isn't defined yet, when asked "what's the brand for X", "define the brand for this project", "new project design system", or before the first UI work on a fresh project. Do NOT use this to restyle or elevate a project that already has an identity — that's `taste-redesign`.
---

# Brand Identity Generator

## Why per-project, not one fixed brand

Every project gets its own identity, generated for that project — this skill does not apply a
single default brand across everything. There is no "the ALD brand" to fall back to; a
generic look with no real decisions behind it is worse than one clearly generated for the
project at hand.

## Workflow

1. **Interview — up to 6 questions, one at a time, multiple-choice where possible:**
   - What is this project, in one line? Who's it for?
   - Industry / domain — anything that implies conventions to follow or break?
   - Personality: 3 adjectives, or the closest reference brand(s)/products.
   - Primary color or mood — or "surprise me based on the personality answer."
   - Typography lean: serif / sans / mono / display — or "your call."
   - Tech stack — default is Adrian's usual (below); only ask if this project needs
     something different.
2. **Draft the brand.** Propose concrete token values (colors, typography, spacing, shape)
   that follow from the interview answers — not generic SaaS defaults.
3. **Write it as `DESIGN.md`** at the project's repo root, following the exact format and
   canonical section order from the `design-md` skill — read that skill first for the
   YAML token schema and section order, don't improvise the format.
4. If the tech stack deviates from Adrian's default, note it in `DESIGN.md`'s "Known Gaps"
   section rather than creating a separate file for it.
5. Never write brand output into this skill's own directory — the generated identity belongs
   to the project it's for, not to `ald-skills`.

## Adrian's default stack

Starting point for step 1, not a rule — confirm or deviate per project:

- React + TypeScript
- Tailwind CSS v4 (CSS-first `@theme`)
- shadcn/ui primitives
- Lucide icons

## See Also

- `design-md` — the `DESIGN.md` format and spec this skill writes to. Read it for the exact
  YAML schema and canonical section order before drafting.
- `taste-skill` — once the brand exists, use this to build the project's first UI from a brief
  without generic-AI tells, respecting the identity this skill just generated.
- `taste-redesign` — for elevating an *existing* UI that already has an identity, rather than
  defining a new one from scratch.
