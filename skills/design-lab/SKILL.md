---
name: design-lab
description: >
  Conduct a design interview, generate 5 distinct UI variations in a temporary route, collect
  your reaction to the live rendered variants, and produce an implementation plan. Use when the user wants to explore UI design options, redesign an
  existing component/page, or create new UI with multiple genuinely different approaches to
  compare — before writing production code or committing to a direction. Heavier than
  `prototype` on purpose: use that one for a single component whose direction is already
  clear, this one when the direction itself is open and the scope is a whole page or flow. For reviewing a
  UI that's already real (not exploring new directions), use `taste-redesign`.
  Source: adapted from github.com/0xdesign/design-plugin's design-lab skill (interview +
  5-variant structure), with feedback collection replaced by a plain rendered route you open
  and judge yourself — no overlay component, no external tooling.
---

# Design Lab

A complete design exploration workflow: interview, generate variations, collect real feedback
on the live thing, refine, and finalize into an implementation plan.

## Core Philosophy

**Explore before you commit, and get feedback on the real rendered thing — not a description
of it.** Five meaningfully different directions, live at real size in real context, beat one
direction refined in isolation. And the feedback step holds to one rule: the user reacts to
the actual rendered UI, at real size, in real context — not to a report or a summary you wrote
about it.

This skill differs from `prototype` in weight: `prototype` diverges 3-5 versions of one
component with no interview and a lightweight picker, for a fast "which feels right" check.
This skill runs a structured interview, infers the project's real visual language, generates 5
variants of a component *or* a whole page, collects real feedback, and produces a persisted
implementation plan plus a running Design Memory file. Use `prototype` when you already know
the scope and just want to compare; use this when the direction itself is still open.

## CRITICAL: Cleanup Behavior

All temporary files MUST be deleted when the process ends, whether by the user confirming a
final design (cleanup, then generate the plan) or aborting (cleanup immediately, no plan
generated). Never leave `.claude-design/` or a `__design_lab` route behind. If the user says
"cancel," "abort," "stop," or "nevermind" at any point, confirm and then delete all temporary
artifacts.

---

## Phase 0: Preflight Detection

Before starting the interview, detect the project automatically.

**Package manager** — lock files in the project root: `pnpm-lock.yaml` → pnpm,
`yarn.lock` → yarn, `package-lock.json` → npm, `bun.lockb` → bun.

**Framework** — config files: `next.config.{js,mjs,ts}` → Next.js (check `app/` vs `pages/`
for router); `vite.config.{js,ts}` → Vite; `remix.config.js` → Remix; `nuxt.config.{js,ts}` →
Nuxt; `astro.config.mjs` → Astro.

**Styling system** — `package.json` dependencies and config files: `tailwind.config.{js,ts}` →
Tailwind; `@mui/material` → Material UI; `@chakra-ui/react` → Chakra; `antd` → Ant Design;
`styled-components` / `@emotion/react` → CSS-in-JS; `.module.css` files → CSS Modules.

**Design Memory check** — look for `docs/design-memory.md`, `DESIGN_MEMORY.md`, or
`.claude-design/design-memory.md`. If found, read it and use it to prefill defaults and skip
redundant interview questions.

**Design source check** — before inferring anything generically, check for `DESIGN.md`
(`design-md`'s format). If one exists, its tokens are
the source of truth — read them and skip straight to matching them across all 5 variants
instead of running visual-style inference from scratch.

**Visual style inference (no `DESIGN.md`) — never use generic/predefined styles.**

- Tailwind: read `theme.colors`, `theme.spacing`, `theme.borderRadius`, `theme.fontFamily`,
  `theme.boxShadow` from `tailwind.config.{js,ts}`.
- CSS Variables: read `--color-*`, `--spacing-*`, `--font-*`, `--radius-*` from `globals.css`
  / `variables.css` / `:root`.
- UI library theme config (MUI's `createTheme()`, Chakra's `extendTheme()`, Ant's
  `ConfigProvider`).
- Always scan 2-3 existing buttons, cards, and forms for real styling patterns, and existing
  typography for heading/body sizes.

Store inferred styles in the Design Brief for consistent use across all variants.

---

## Phase 1: Interview

Use `AskUserQuestion` for all steps. Skip any question a found Design Memory or `DESIGN.md`
already answers.

**1.1 Scope & target** — component or full page? New or redesign? If redesign, the file path
or route. If the target is unclear, propose a name based on repo patterns and confirm.

**1.2 Pain points & inspiration** — top pain points with the current design, or what this
design should avoid (multi-select: too cluttered/dense, unclear hierarchy, poor mobile
experience, outdated look). Visual inspiration (Stripe, Linear, Notion, Apple, or named
others). Functional inspiration (inline editing, progressive disclosure, optimistic updates,
keyboard shortcuts).

**1.3 Brand & style direction** — 3-5 brand adjectives (minimal, premium, playful,
utilitarian…). Density (compact / comfortable / spacious). Dark mode requirement (yes / no /
nice-to-have).

**1.4 Persona & jobs-to-be-done** — primary user (developer, designer, business user, end
consumer). Primary context (desktop-first, mobile-first, both). Top 3 tasks users must
complete (open-ended).

**1.5 Constraints** — must-keep elements (existing copy, current fields, nav structure, or
none). Technical constraints, multi-select (no new dependencies, use existing components, must
be WCAG accessible, none).

---

## Phase 2: Generate the Design Brief

Save a structured brief to `.claude-design/design-brief.json`:

```json
{
  "scope": "component|page",
  "isRedesign": true,
  "targetPath": "src/components/Example.tsx",
  "targetName": "Example",
  "painPoints": ["Too dense", "Primary action unclear"],
  "inspiration": { "visual": ["Stripe", "Linear"], "functional": ["Inline validation"] },
  "brand": { "adjectives": ["minimal", "trustworthy"], "density": "comfortable", "darkMode": true },
  "persona": { "primary": "Developer", "context": "desktop-first", "keyTasks": ["Complete checkout"] },
  "constraints": { "mustKeep": ["existing fields"], "technical": ["no new dependencies", "WCAG accessible"] },
  "framework": "nextjs-app",
  "packageManager": "pnpm",
  "stylingSystem": "tailwind"
}
```

Display a summary to the user before proceeding.

---

## Phase 3: Generate the Lab

### Directory structure

```
.claude-design/
├── lab/
│   ├── page.tsx              # Main lab page (framework-specific)
│   ├── variants/
│   │   ├── VariantA.tsx … VariantE.tsx
│   ├── components/
│   │   └── LabShell.tsx
│   └── data/
│       └── fixtures.ts       # Shared mock data across variants
├── design-brief.json
└── run-log.md
```

No feedback overlay here and no external tooling — Phase 5 just opens the live route and the
user tells you what they think. Nothing extra to build, wire in, or delete at cleanup.

### Route integration

- **Next.js App Router**: `app/__design_lab/page.tsx` importing from `.claude-design/lab/`.
- **Next.js Pages Router**: `pages/__design_lab.tsx`.
- **Vite React**: add a route to `/__design_lab` if React Router exists, or a conditional
  render in `App.tsx` on `?design_lab=true` otherwise.
- **Other frameworks**: the most appropriate temporary route for the detected framework.

### Variant generation guidelines

Apply the craft bar from `taste-skill`/`taste-redesign` (layout, typography, color, AI-tells)
and `emil-design-eng`/`animation` (motion timing, easing, reduced-motion) — but **do not use
predefined visual styles**. Infer them from the project (Phase 0), or from the existing
`DESIGN.md` if one was found.

Each variant MUST explore a different, named axis. Not minor variations — meaningfully
distinct directions, all using the project's own visual language:

- **Variant A — Information Hierarchy**: restructure content hierarchy, apply Gestalt
  proximity, one primary action per view, use the existing type scale to create clear levels.
- **Variant B — Layout Model**: a different layout approach entirely (card vs. list vs. table
  vs. split-pane), using the project's existing grid/layout system.
- **Variant C — Density**: if the brief says comfortable, try more compact (or the reverse) —
  same spacing tokens, applied differently. Show the tradeoff: more visible data vs. easier
  scanning.
- **Variant D — Interaction Model**: a different interaction pattern (modal vs. inline vs.
  panel vs. drawer), with all required states (loading, error, empty, disabled) implemented.
- **Variant E — Expressive Direction**: push the brand direction from the interview furthest —
  different use of the project's own tokens, motion where it adds meaning.

### Lab page requirements

- **Header**: Design Brief summary (target, scope, key requirements) and review instructions.
- **Variant grid**: clear A-E labels, a one-line "why this exists" rationale per variant, the
  actual rendered variant, key-difference notes. Desktop: 2-3 column grid. Mobile: horizontal
  scroll or tabs.
- **Shared fixture data** across all variants — fair comparison.
- Every element you want feedback on should be real, rendered UI — the reviewer
  identifies elements itself (nearest heading + tag, or a text snippet); no manual annotation
  needed.

### Code quality

Follow the project's existing conventions (file naming, imports, detected styling system).
Every component needs Default, Hover, Focus, Active, Disabled, Loading, Error, and Empty
states. Accessibility: semantic HTML, keyboard-operable, visible `:focus-visible`, 4.5:1 text
contrast / 3:1 UI contrast, 44×44px minimum touch targets.

---

## Phase 4: Present the Lab

Do NOT start the dev server, check ports, or open a browser yourself — that blocks the turn on
a long-running process. Output the lab location and immediately proceed to Phase 5 without
waiting for the user to confirm they've opened it:

```
✅ Design Lab created — 5 variants in .claude-design/lab/

Make sure your dev server is running (pnpm dev if not), then I'll open:
http://localhost:3000/__design_lab
```

---

## Phase 5: Collect Real Feedback

The variants are already rendered at a real route. There is nothing to install and nothing to
wire in — you open it, the user looks, and they tell you what they think in their own words.

1. Serve the route and give the user the URL:
   ```sh
   # whatever the project's dev server is
   npm run dev    # then: http://localhost:3000/__design_lab
   ```
   If the project has no dev server, write the variants to a single self-contained
   `.claude-design/lab/index.html` and give the user the file path instead — same picker chrome
   as `prototype`'s `PICKER.md`, one file, opens in any browser.

2. Tell the user it's open, and what to look at: all five side by side, at real size, with real
   content. Their reaction to the rendered thing is the entire point of this phase.

3. **Wait for them.** Do not proceed, do not summarize, do not guess a winner. This is a
   deliberate stop.

4. Take the feedback in whatever form it arrives — "B's spacing, A's type scale", "none of these,
   they're all too corporate", a list of specific gripes. Keep `data-variant="X"` on each
   variant's wrapper so you can map a comment back to the variant it refers to when the user
   names one.

5. **The safety gate**: silence is not approval. If the user says nothing specific, or says only
   "looks fine", ask before making sweeping changes — they may not have looked yet.

### Stage: is there a winner?

After the batch, ask (`AskUserQuestion`): *"Is there one variant you like as is?"*

- **Yes** → which one (A-E), then any small tweaks or "good as is." Proceed to Phase 7.
- **No, I like parts of different ones** → ask what specifically, per variant (e.g. "A: love
  the card layout. B: the color scheme feels right. E: typography hierarchy is clearest").
  Proceed to Phase 6.

---

## Phase 6: Synthesize a New Variant

Build a new **Variant F** combining the specific elements called out from each source variant,
the best structural decisions across all of them, and any pattern that appeared in more than
one. Replace the lab view with F prominently shown plus 1-2 of the closest originals for
comparison; drop variants nothing was liked from. Re-open the updated route
and collect another round of feedback. Support multiple synthesis passes until the user is
satisfied, then proceed to Phase 7.

---

## Phase 7: Final Preview

Once satisfied, create `.claude-design/preview/` with a `FinalDesign.tsx` at a
`/__design_preview` route. For redesigns, include a before/after comparison (toggle or split
view). Ask for final confirmation via `AskUserQuestion`: finalize, needs changes (iterate), or
abort (see below).

---

## Abort Handling

Triggered by "cancel," "abort," "stop," "nevermind," "forget it," "I changed my mind" — at any
point, not only at final confirmation. Confirm ("this will delete all the design lab files"),
then on confirmation: delete `.claude-design/` entirely, delete the temporary route files, do
NOT generate an implementation plan, do NOT update Design Memory. Acknowledge and stop.

---

## Phase 8: Finalize

### 8.1 Cleanup

Delete `.claude-design/` entirely and every temporary route file this skill created
(`app/__design_lab/`, `pages/__design_lab.tsx`, `app/__design_preview/`,
`pages/__design_preview.tsx`, and revert any Vite `App.tsx` conditional-render edit).

**Safety rules**: only delete files inside `.claude-design/`; only delete route files this
skill created; never delete user-authored files; verify paths before deleting.

### 8.2 Generate the implementation plan

Write `DESIGN_PLAN.md` in the project root: summary (scope, target, winning variant, key
improvements from feedback), files to change, ordered implementation steps, component API
(props/state/events), required UI states, an accessibility checklist, a testing checklist, and
any new/existing design tokens involved.

### 8.3 Update Design Memory

Create or update `DESIGN_MEMORY.md`: brand tone and anti-patterns discovered, layout/spacing
(density, grid, radius, shadows), typography, color, interaction patterns (forms,
modals/drawers, tables, feedback), accessibility rules, and repo conventions (component
structure, styling approach, existing primitives). If updating an existing file, append new
patterns and resolve conflicting guidance with the latest decision — keep it concise and
actionable.

---

## Error Handling

- **Framework not detected** — ask directly; offer Next.js, Vite, CRA, Vue, etc.
- **Dev server won't start** — check for port conflicts, provide manual instructions, let the
  user start it themselves.
- **Route integration fails** — fall back to a standalone HTML file with manual preview
  instructions.
- **Cleanup interrupted** — log what was deleted vs. what remains, give manual cleanup
  instructions, never leave partial state without saying so.

## Configuration Options

- `DESIGN_AUTO_IMPLEMENT` — if `true`, implement the plan immediately after confirmation.
- `DESIGN_KEEP_LAB` — if `true`, don't delete the lab until an explicit cleanup command.
- `DESIGN_MEMORY_PATH` — custom path for the Design Memory file.

## See Also

- `prototype` — the lighter, no-interview variant picker for a single component.
- `taste-redesign` — the right tool once a design is already real and you just want a
  review-and-improve pass, not an exploration.
- `taste-skill` / `taste-redesign` — the craft bar variants are held to.
- `design-md` — where an existing project identity comes from, checked in
  Phase 0 before inferring anything generically.
