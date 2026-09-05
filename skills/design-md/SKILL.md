---
name: design-md
description: >
  Owns DESIGN.md end to end — Google Stitch's open AI-readable design-system format (YAML tokens
  + Markdown rationale). Three directions: invent an identity for a new project through a short
  interview, extract one from an existing brand (deck, site, screenshots, Figma), or read an
  existing DESIGN.md and apply it. Use when starting a new project with no visual identity yet,
  when asked what the brand for something should be, when documenting a brand for AI tools, or
  when reverse-engineering a visual identity into reusable tokens. For elevating a UI that
  already has an identity, use `taste-redesign` instead.
---

# DESIGN.md — AI-readable design system files

`DESIGN.md` is an open format introduced by **Google Stitch** (the design.md spec —
https://stitch.withgoogle.com/docs/design-md/). It's a single Markdown file, dropped in a
project's root next to `README.md`, that an AI coding agent reads to generate or restyle UI
consistently with a brand. It works because it pairs two layers in one file:

> "Tokens give agents exact values. Prose tells them why those values exist and how to apply
> them." — design.md spec

- **YAML front matter** — machine-readable design tokens (colors, typography, spacing, shape,
  components) an agent can reference exactly.
- **Markdown body** — human-readable rationale, organized into a canonical section order, that
  tells the agent *why* those values exist and *how* to apply them in context.

This is the format used by Stitch, and it's Claude/Cursor-compatible: the workflow is "drop
`DESIGN.md` in the repo root → tell the agent `Use the @DESIGN.md file and style my app`."

A community collection of 70+ real-world examples (Linear, Stripe, Apple, Figma, Cursor, Tesla,
etc.) lives at https://github.com/voltagent/awesome-design-md — each entry pairs a `DESIGN.md`
with `preview.html`/`preview-dark.html` visual catalogs. Use these as calibration references for
tone, token granularity, and section depth.

## Three directions

| Direction | Situation | Where to go |
|---|---|---|
| **Invent** | New project, no identity yet | "Inventing an identity" below — interview first, then the format. If the identity has to be *right*, run `art-direction` first and skip the interview |
| **Extract** | Identity exists somewhere (deck, site, screenshots, Figma) | "How to write one" — read the sources, then the format |
| **Apply** | `DESIGN.md` already exists | Read its tokens and build against them |

## When to use this skill

- User is **starting a new project** and its visual identity isn't defined yet.
- User asks to **create/write a `DESIGN.md`** for a project, brand, or product.
- User wants to **reverse-engineer a brand's visual identity** (from a PDF deck, screenshots, a
  live site, Figma file, or brand guidelines) into a portable, agent-readable spec.
- User wants an AI coding tool to **apply a consistent design system** when generating or
  restyling UI — `DESIGN.md` is the artifact that makes that possible without Figma exports,
  JSON token files, or special tooling.
- User references "Stitch", "design.md", "AI design system file", or asks to document a brand
  "the way Google does it."

## The format

### YAML front matter (token layer)

```yaml
version: alpha            # or a semver-style string
name: <string>            # e.g. "Acme-design-analysis"
description: "<string>"   # 3-6 sentence brand summary — see Overview guidance below

colors:
  <token-name>: "<CSS color: hex | rgb | oklch | named>"

typography:
  <token-name>:
    fontFamily: <string>
    fontSize: <px|rem>
    fontWeight: <number>
    lineHeight: <number>
    letterSpacing: <px|em>
    fontFeature: <string>      # optional
    fontVariation: <string>    # optional

rounded:
  <scale-level>: <px | "organic">   # "organic" is valid for hand-drawn/blob shape systems

spacing:
  <scale-level>: <px | number>

components:
  <component-name>:
    backgroundColor: "{colors.<token>}"   # bracket notation = token reference
    textColor: "{colors.<token>}"
    typography: "{typography.<token>}"
    rounded: "{rounded.<token>}"
    padding: <value>
    size / height / width: <value>
```

Token references use **bracket notation** — `{colors.primary}`, `{typography.body}` — both
inside `components:` and inline in the Markdown prose, so the agent can trace every described
value back to its canonical definition.

Component variants (hover, active, pressed, focused, selected) are **separate top-level entries**
with related names (`button-primary`, `button-primary-hover`, `button-primary-pressed`), not
nested state objects.

### Markdown body (rationale layer) — canonical section order

All sections are technically optional, but real-world examples consistently include these, in
this order:

1. **Overview** — Brand & style summary, "Key Characteristics" bullet list. This is the single
   most load-bearing section: a dense paragraph plus 5-8 bullets that an agent can hold in mind
   while generating *anything*, even before consulting token details.
2. **Colors** — Grouped by *role* (Brand & Accent / Surface / Text / Semantic — not just a flat
   swatch list), each entry naming the token, its hex, and **where it's used**.
3. **Typography** — Font family rationale (including open-source substitutes for proprietary
   typefaces), then a hierarchy table (token / size / weight / line-height / letter-spacing /
   use), then "Principles" — the *rules* that generate the hierarchy, not just its values.
4. **Layout** — Spacing system (base unit + scale), grid/container/composition patterns,
   whitespace philosophy.
5. **Elevation & Depth** — A table of elevation levels and their treatment (shadow / surface lift
   / border), plus notes on decorative depth (gradients, photography, screenshots).
6. **Shapes** — Border-radius scale as a table, plus photography/illustration geometry notes.
   For brands with organic/hand-drawn ornament systems (blobs, brushstrokes), document them here
   as their own subsection with explicit "keep it irregular/asymmetric" guidance.
7. **Components** — Grouped by family (Buttons, Cards, Inputs, Navigation, etc.), each entry
   naming its token, describing every state, and citing token references.
8. **Do's and Don'ts** — The guardrail section. This is where *negative space* gets defined —
   what the brand explicitly avoids (second accent colors, dark mode, generic icon libraries,
   shadows, etc.). Often the highest-value section for preventing agent drift.
9. **Responsive Behavior** — Breakpoint table, touch-target minimums, collapsing strategy,
   image/photography behavior across viewports.
10. **Iteration Guide** *(optional but valuable)* — A numbered checklist for *using* the file:
    "focus on one component at a time," "run the linter after edits," "treat [accent color] as
    scarce." Frames the file as a working tool, not a static spec.
11. **Known Gaps** *(optional but valuable — especially for reverse-engineered files)* — Explicit
    list of what's *not* documented (no dark mode, proprietary fonts, missing states, values that
    are estimates pending verification). Prevents the agent from inventing answers to unasked
    questions.

### CLI tooling (per the spec)

```bash
npx @google/design.md lint DESIGN.md     # validate structural correctness
npx @google/design.md diff old.md new.md # compare versions, detect regressions
npx @google/design.md export --target=tailwind-v4   # convert to Tailwind/DTCG formats
npx @google/design.md spec                # print the formal specification
```

## Inventing an identity (new project, nothing to extract from)

**If `ART-DIRECTION.md` exists, read it and skip the interview below.** The `art-direction`
skill answers all six questions with far more behind each answer — the chosen concept's
typographic and chromatic territory becomes the real values, §1 and §2 become the Overview
prose, §4 becomes the imagery and motion rules, and §6 "what we don't want" is copied into
Don'ts verbatim. Go straight to drafting tokens.

The interview below is the fast path for a project where a consistent identity matters more
than the right one.

Every project gets its own identity, generated for that project. There is no default house brand
to fall back on — a generic look with no real decisions behind it is worse than one clearly made
for the project at hand.

**Interview — up to 6 questions, one at a time, multiple-choice where possible:**

1. What is this project, in one line? Who's it for?
2. Industry / domain — anything that implies conventions to follow or break?
3. Personality: 3 adjectives, or the closest reference brand(s)/products.
4. Primary color or mood — or "surprise me based on the personality answer."
5. Typography lean: serif / sans / mono / display — or "your call."
6. Tech stack — default below; only ask if this project needs something different.

**Then draft the brand:** propose concrete token values (colors, typography, spacing, shape)
that follow from the answers — not generic SaaS defaults. Write it using the format and
canonical section order in this file; don't improvise the structure.

If the tech stack deviates from the default, note it in "Known Gaps" rather than creating a
separate file for it.

**Default stack** — a starting point for question 6, not a rule:

- React + TypeScript
- Tailwind CSS v4 (CSS-first `@theme`)
- shadcn/ui primitives
- Lucide icons

**Never write brand output into this skill's own directory.** The generated identity belongs to
the project it's for, not to `ald-skills`.

## How to write one (process)

1. **Gather source material** — brand deck/PDF, live site, screenshots, Figma file, or brand
   guidelines. Read/view all of it before writing a single token; the Overview section depends on
   having seen the whole system.
2. **Name the single chromatic identity** (or the deliberate multi-accent system, if that's the
   brand). Most strong brands run on *one* accent color plus neutrals — name it first, then build
   the neutral ladder around it.
3. **Build the color palette by role**, not by hue: brand/accent, surface/canvas, text/ink,
   semantic. Estimate hex values conservatively from what you can see; **always flag estimates**
   in the description and in "Known Gaps" rather than presenting guesses as confirmed values.
4. **Build the typography hierarchy as a table** — work top-down from the largest display size to
   captions, and always note what the *real* typeface is (even if proprietary) plus an
   open-source substitute an agent can actually use.
5. **Name the shape/spacing scale** — derive a base unit (commonly 4px or 8px) and build the
   scale as multiples of it.
6. **Write Components last**, after the token vocabulary exists — every component entry should
   resolve entirely to `{token references}`, never to raw values.
7. **Write Do's and Don'ts from what you *didn't* see** — the absence of dark mode, the absence
   of a second accent, the absence of drop shadows, are all real signal. State them as rules.
8. **Always include "Known Gaps"** when the file is reverse-engineered (vs. exported from a real
   design system) — name what's estimated, what's missing, and what needs founder/designer
   confirmation before the tokens are locked for production.

## Calibration references

Pull a comparable brand from https://github.com/voltagent/awesome-design-md before writing —
matching tone matters as much as matching structure:

- **Linear** (`design-md/linear.app/DESIGN.md`) — dark, single-accent, software-craft tone; great
  reference for surface-ladder elevation systems and restrained semantic color.
- **Cursor** (`design-md/cursor/DESIGN.md`) — warm-cream editorial canvas with one orange accent
  plus a scoped pastel sub-palette for in-product states; good reference for "single brand
  voltage + contained secondary palette" patterns and for documenting proprietary/custom fonts
  with open-source substitutes.

Clone the repo locally to browse more (`git clone --depth 1
https://github.com/voltagent/awesome-design-md`) — 70+ examples span SaaS, consumer, fashion,
and enterprise brands.

## Output

Write the file as `DESIGN.md` in the project root (capitalized, exactly — agents and tools look
for that exact filename next to `README.md`). If reverse-engineering from non-canonical sources
(PDF, screenshots, a live site you can't inspect pixel values on), say so explicitly in the
`description` front-matter field and in "Known Gaps" — never present visual estimates as
confirmed brand values.

## See Also

- `taste-skill` — builds NEW UI from a brief; reads this file's tokens first when they exist,
  then handles execution discipline (anti-AI-tells, dials) on top.
- `taste-redesign` — for elevating a UI that already has a `DESIGN.md`/identity, rather than
  defining one from scratch.
- `frontend-slides` — reads this file's tokens for presentations too, instead of its own
  built-in presets, when a project already has an identity.
