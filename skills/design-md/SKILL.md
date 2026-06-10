---
name: design-md
description: Write, read, and apply DESIGN.md files — Google Stitch's open AI-readable design-system format (YAML design tokens + Markdown rationale). Use when asked to "create a design.md", "extract a design system from [brand/PDF/site/screenshots]", "document this brand for AI tools", or when reverse-engineering a brand's visual identity into reusable tokens for an AI coding agent to apply consistently.
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

## When to use this skill

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
