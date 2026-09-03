---
name: taste-skill
description: >
  Anti-slop frontend design skill for building NEW landing pages, portfolios, and UI from a
  brief. Reads the brief and existing brand context first, infers a design direction from
  three configurable dials (variance, motion, density), and ships interfaces that don't look
  templated or default-AI. Use when starting a new page/UI with no existing identity to
  preserve, or when asked to design something "that doesn't look like every other AI landing
  page." For auditing and upgrading an EXISTING UI, use `taste-redesign` instead — this skill
  is for the moment before code exists. Triggers on: "build a landing page", "design a
  portfolio", "make this not look generic/templated/AI-generated", "anti-slop", starting UI
  work with a brief but no established identity yet. Also owns component-library selection
  (which package for toasts, dropdowns, charts, drag-and-drop, state, etc.) — use this instead
  of hand-rolling a component or guessing at a dependency.
  Source: github.com/Leonxlnx/taste-skill (taste-skill, the main v2 variant); library table
  merged from github.com/emilkowalski/skills' pick-ui-library.
---

# Taste Skill — Anti-Slop Frontend Design

## Core Philosophy: Brief-First, Not Aesthetic-First

Never default to a fixed visual style. Read the brief and any existing brand assets first,
declare a one-line design read, then let three dials — inferred from that read — decide the
shape of the output. If the project already has a `DESIGN.md` or established identity, this
skill defers to it: use its tokens as the substance, and use the checklists below (Sections 4
and 9) to keep the *execution* free of default-AI tells.

## Step 0: Declare the Design Read

Before generating any code, state one line following this pattern:

> "Reading this as: [page kind] for [audience], with a [vibe] language, leaning toward
> [design system or aesthetic family]."

Read these signals first, in order of weight:
- Page kind (landing, portfolio, redesign, editorial)
- Vibe words used ("minimalist," "Linear-style," "brutalist," "playful")
- Reference URLs or named competitors
- Target audience (B2B, design-conscious consumer, recruiters)
- Existing brand assets (logo, color, typography — check for `DESIGN.md` first)
- Quiet constraints (accessibility-first, regulated, trust-driven)

**If the brief is ambiguous, ask one question. Do not guess.**

## Step 1: The Three Dials

Baseline: `DESIGN_VARIANCE: 8` · `MOTION_INTENSITY: 6` · `VISUAL_DENSITY: 4`

Infer values from the design read using this table:

| Signal | VARIANCE | MOTION | DENSITY |
|---|---|---|---|
| minimalist / clean / calm / editorial / Linear-style | 5-6 | 3-4 | 2-3 |
| premium consumer / Apple-y / luxury / brand | 7-8 | 5-7 | 3-4 |
| playful / wild / Dribbble / Awwwards / experimental / agency | 9-10 | 8-10 | 3-4 |
| landing page / portfolio / marketing site (default) | 7-9 | 6-8 | 3-5 |
| trust-first / public-sector / regulated / accessibility-critical | 3-4 | 2-3 | 4-5 |
| redesign — preserve existing | match existing | +1 | match existing |
| redesign — overhaul | +2 | +2 | match existing |

Use-case presets, if the brief maps cleanly to one:

| Use case | VARIANCE | MOTION | DENSITY |
|---|---|---|---|
| Landing (SaaS, mainstream) | 7 | 6 | 4 |
| Landing (Agency / creative) | 9 | 8 | 3 |
| Landing (Premium consumer) | 7 | 6 | 3 |
| Portfolio (Designer / studio) | 8 | 7 | 3 |
| Portfolio (Developer) | 6 | 5 | 4 |
| Editorial / Blog | 6 | 4 | 3 |
| Public-sector service | 3 | 2 | 5 |

## Step 2: Design System Selection

- **Real design systems** with an official package (Material 3, Fluent UI, Carbon, GOV.UK,
  shadcn/ui) — use the official package, don't reimplement it.
- **Aesthetic directions** without an official package (glassmorphism, brutalism, editorial) —
  build with native CSS + Tailwind + maintained components, not from-scratch primitives.
- Check `package.json` before importing any library. If the project already uses a listed
  library below, use it — if it uses a competitor (e.g. `react-window` instead of `Virtuoso`),
  flag the alternative but don't churn the dependency without being asked.

### Component library picks (curated, don't substitute without a reason)

Identify the task, not the library the tech asked for — "I need a dropdown" is a
UI-primitives task (`base-ui`) even if someone asked about something else. Recommend one
library, state what it's for in one sentence, and install/wire it up if that's part of the
request — don't present a menu when the table has a clear answer. If the task isn't covered,
say so explicitly and recommend from general knowledge, but be clear you've left this table.

**UI components & primitives**

| Task | Library |
| --- | --- |
| Unstyled, accessible UI components (dialogs, popovers, menus, selects…) | `base-ui` |
| Command menus (⌘K palettes) | `cmdk` |
| Toasts / notifications | Sonner — see `ask-sonner` |
| One-time password / verification code inputs | `input-otp` |
| Customizable GUIs / control panels | `Leva` (`dialkit` as an alternative) |

**Motion & visuals**

| Task | Library |
| --- | --- |
| General-purpose animation (springs, layout animations, enter/exit) | Motion (Framer Motion) — see `emil-design-eng` / `animation` for when it's actually warranted |
| Animating numbers (counters, prices, stats) | `NumberFlow` |
| Animated text components | `torph` |
| 3D globes | `Cobe` |
| Dynamic OG images (HTML/CSS → SVG/PNG) | `Satori` |
| Syntax highlighting | `shiki` |

Reach for Motion when you need springs, layout animations, exit animations, or gesture-driven
values. A simple hover or fade doesn't need it — plain CSS transitions are the right tool
there.

**Charts**

| Task | Library |
| --- | --- |
| Real-time / streaming charts | `Liveline` |
| General charts (static or interactive dashboards) | `recharts` |

The split: if data points arrive live and the chart scrolls with time, use Liveline.
Everything else is recharts.

**Interaction & performance**

| Task | Library |
| --- | --- |
| Drag and drop | `dnd kit` |
| Virtualization (long lists, large tables) | `Virtuoso` |

**State & styling**

| Task | Library |
| --- | --- |
| State management | `zustand` |
| Constructing className strings conditionally | `clsx` |
| Type-safe, variant-driven styling for Tailwind | `cva` |
| Theme switching / dark mode (no flash on load) | `next-themes` |

The styling split: `clsx` for ad-hoc conditional classes; `cva` when a component has real
variants (size, intent, state) that deserve a typed API. They compose — `cva` uses
`clsx`-style inputs internally.

**Common mismatches to catch**

- Toasts built by hand or with a modal library → Sonner exists for exactly this.
- A `<div>`-based dropdown/dialog with manual focus handling → `base-ui`, which handles
  accessibility, focus trapping, and dismissal.
- Animating a number by re-rendering text → `NumberFlow` handles digit transitions properly.
- Rendering a 1,000+ row list directly → `Virtuoso` before reaching for pagination hacks.
- A `useState`-per-component web of props for shared state → `zustand`.
- Template-literal className ternaries three conditions deep → `clsx` (or `cva` if it's
  variant-shaped).

## Step 3: Architecture Defaults

- React/Next.js, Tailwind v4, the Motion library, `next/font` — unless the brief or an
  existing `DESIGN.md`/tech-stack note says otherwise (check `design-md`'s output first).
- Avoid loading Google Fonts via `<link>` tags in production; use `next/font`.

## Step 4: Design Engineering Directives

### Typography
- Default display: `text-4xl md:text-6xl tracking-tighter leading-none`
- Default body: `text-base text-gray-600 leading-relaxed max-w-[65ch]`
- Avoid Inter as the default — choose Geist, Outfit, Cabinet Grotesk, or Satoshi instead,
  unless the project's own identity already specifies a typeface.
- Serif is discouraged as a default — only when the brand explicitly names it, or the
  aesthetic is genuinely editorial/luxury. Fraunces and Instrument_Serif specifically banned
  as defaults (overused).
- Italic display type with descenders (y, g, j, p, q): `leading-[1.1]` minimum + `pb-1` reserve.

### Color
- Maximum one accent color; saturation under 80%.
- Avoid the "AI purple/blue glow" default.
- Avoid the premium-consumer cliché palette: warm beige + brass + oxblood + espresso.
- One accent, used identically across every section — no drift.
- No pure black (`#000000`) or pure white (`#ffffff`) — off-black/off-white.

### Layout & Interactive States
- Button text must pass WCAG AA contrast (4.5:1) against its background.
- Button text must fit on one line at desktop — no wrapping CTAs.
- One label per interaction type across the whole page — no duplicate CTA intent.
- Form labels, placeholders, and focus rings all pass WCAG AA contrast.
- Hero fits the initial viewport; headline max 2 lines, subtext max ~20 words.
- Hero top padding capped around `pt-24` (~6rem) at desktop.
- Maximum 1 eyebrow per 3 sections.

## Step 5: Performance & Accessibility

- Animate only `transform` and `opacity` (GPU-accelerated).
- Honor `prefers-reduced-motion`.
- Support dark mode from the start, not bolted on later.

## Step 6: AI Tells — Forbidden Patterns (Section 9)

This is the highest-value section for making output not read as AI-generated. Check every
item before shipping.

**Visual & CSS:** no neon/outer glows by default (use inner borders or subtle tinted shadows);
no pure black; no oversaturated accents; no excessive gradient text on large headers; no
custom mouse cursors.

**Typography:** avoid Inter as default; no oversized H1s that just scream — control hierarchy
with weight and color, not raw scale; serif only for editorial/luxury, never dashboards.

**Layout & Spacing:** mathematically precise padding/margins, no floating elements with
awkward gaps; no 3-column-equal feature-card rows — the single most generic AI layout.

**Content & Data (the "Jane Doe" effect):** no generic names ("John Doe", "Sarah Chan") — use
creative, realistic, locale-appropriate ones; no generic avatars (SVG "egg" icons, Lucide user
icon) — use believable photo placeholders; no fake-perfect numbers (`99.99%`, `50%`,
`1234567`) — use organic data (`47.2%`); no startup-slop brand names ("Acme", "Nexus",
"SmartFlow") — invent contextual ones; no filler verbs ("Elevate", "Seamless", "Unleash",
"Next-Gen", "Revolutionize") — concrete verbs only.

**External Resources & Components:** no hand-rolled SVG icons — use Phosphor, HugeIcons,
Radix, or Tabler; no div-based fake screenshots; no broken Unsplash links; shadcn/ui
customization allowed, but never left in its default, unstyled state.

**Hero & top-of-page:** no version labels in the hero (`v0.6`, `v2.0`, `BETA`,
`INVITE-ONLY`) as default eyebrows; no "Brand · No. 01"-style sub-eyebrows.

**Section numbering & micro-labels:** no section-number eyebrows (`00 / INDEX`,
`001 · Capabilities`); no `01 / 4`-style pagination on images/tiles; no "Scroll ·
001 Capabilities"-style scroll cues; no "Index of Work, 2018–2026"-style range labels.

**Separators & dots:** the middle-dot (`·`) rationed to max 1 per line in metadata strips; no
decorative colored status dots on every list/nav/badge.

**Em-dashes & typography flourishes — completely banned, zero exceptions:** no em-dash (`—`)
anywhere — headlines, eyebrows, labels, pills, button text, captions, nav items, body copy,
quote attribution (use a hyphen with spaces or a line break instead), or en-dash (`–`) used as
a separator. Permitted dashes: the regular hyphen `-` (compounds, ranges, dividers) and the
minus sign in math (`-5°C`). If a single `—` or `–` is visible anywhere in the output, it
fails the check. Also banned as a default move: `<br>`-broken-and-italicized headlines;
vertical rotated text ("INDEX OF WORK" at 90°); crosshair/hairline grid lines as pure
decoration.

**Fake product previews:** no div-based fake product UI in the hero (fake task list,
terminal, dashboard built from styled divs); no fake version footers inside fake screenshots
(`v0.6.2-rc.1`, `last sync 4s ago`).

**Marketing-copy tells:** no "Quietly in use at" / "Quietly trusted by" social-proof headers;
no "From the field" / "Field notes" / "Currently on the bench" poetic labels; no mock-humble
industry references; no weather/locale strips (`LIS 14:23 · 18°C`) unless the brief is
place-focused; no micro-meta-sentences under eyebrows; no generic step labels
("Stage 1 / Stage 2 / Stage 3").

**Pills, labels & version stamps:** no pills/labels/tags overlaid on images; no photo-credit
captions as decoration; no version footers on marketing pages (`v1.4.2`, `Build 0048`); no
"Reservation 412 of 800"-style live-stock counters as decoration.

**Decoration text strips:** no decoration strip at hero bottom ("BRAND. MOTION. SPATIAL.") by
default; no floating top-right sub-text in section headings.

**Lists, dividers & scoring:** no `border-t` + `border-b` on every row of long lists/spec
tables; no scoring/progress bars with filled tracks used purely as comparison visuals.

**Locale, time, scroll cues:** locale/city/time/weather strips banned for ~99% of briefs;
scroll cues banned ("Scroll", "↓ scroll", "Scroll to explore"); zero decorative status dots by
default.

## Step 7: Pre-Flight Check

Before shipping, verify: brief inference was declared; dial values match the design read;
color consistency (one accent, used identically); button/form contrast passes WCAG AA; no CTA
wraps to two lines; copy has been audited against Section 9.D; every animation is justified
and uses only `transform`/`opacity`; **zero em-dashes anywhere in the output.** If any check
fails, the work is not done.

## See Also

- `taste-redesign` — for auditing and upgrading a UI that already exists, rather than
  designing a new one from a brief.
- `design-md` — if a `DESIGN.md` exists for this project, its tokens override the generic
  typography/color defaults in Step 4; this skill's job becomes execution discipline
  (Sections 5-9), not identity definition.
- `design-md` — runs the interview that produces a new project's `DESIGN.md` in the
  first place, before this skill's brief-first process has anything to read.
- `emil-design-eng` / `animation` — the full animation decision framework and build sequence
  behind this skill's short motion rules in Step 4/5.
- `ask-sonner` — setup and troubleshooting once the library table above points to Sonner.
- `design-lab` / `prototype` — for exploring multiple UI directions before committing to one,
  rather than declaring a single direction from dials and building it.
