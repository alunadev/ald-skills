---
name: taste-redesign
description: >
  Audits an EXISTING UI/codebase for generic AI patterns and applies targeted craft fixes —
  layout, interactivity, content, iconography, and code quality — without discarding the
  project's own identity. Use when a UI looks flat, generic, or "AI-slop" and there is code
  to improve, not build from scratch. Triggers on: "improve the design", "looks generic",
  "not polished enough", "redesign this", "elevate the UI", "it looks boring", "make it
  better looking", "apply taste", "design review". Works with any CSS framework. For
  designing a NEW project's identity from a brief, use `taste-skill` instead — this skill
  only upgrades what's already built. Source: github.com/Leonxlnx/taste-skill
  (redesign-skill), restored to the full checklist + the project-identity rule the earlier
  port had dropped.
---

# Taste Redesign Skill

## Step 0: Check for an existing identity first

Before touching typography or color: does this project already have a `DESIGN.md`, a design
token file, or an established visual system in the codebase?

- **If yes** — do not apply the Typography or Color sections below. Those choices are already
  made; overriding them with this checklist's defaults (Geist/Outfit, off-black, etc.) would
  replace a deliberate identity with a generic one, which is the opposite of the point. Apply
  Layout, Interactivity, Content Quality, Component Patterns, Iconography, and Code Quality
  instead — those are craft fixes, not identity decisions.
- **If no** — the project has no defined identity yet, and this really is generic-AI-slop
  cleanup. The full checklist below applies. Consider pointing the user at `design-md`
  first if this is more than a one-off page.

## Method

1. **Scan** — identify the framework and styling method in use.
2. **Diagnose** — run the checklist below against the current UI.
3. **Fix** — apply targeted improvements. Do not rewrite from scratch.

## Fix Priority (in order)

1. Font replacement *(skip if Step 0 says an identity already exists)*
2. Color palette cleanup *(skip if Step 0 says an identity already exists)*
3. Hover and active states
4. Layout and spacing
5. Replace generic components
6. Loading, empty, and error states
7. Typography scale polish *(skip if Step 0 says an identity already exists)*

## Audit Checklist

### Typography *(only when no existing identity — see Step 0)*
- Replace generic fonts (Inter, Roboto, Arial) with distinctive alternatives: Geist, Outfit, Cabinet Grotesk
- Tighten letter-spacing on headlines, reduce line-height — headlines should feel heavy
- Limit paragraph width to ~65 characters, increase line-height for readability
- Introduce Medium (500) and SemiBold (600) weights
- Use `font-variant-numeric: tabular-nums` for data-heavy interfaces
- Fix orphaned words with `text-wrap: balance` or `text-wrap: pretty`
- Use sentence case, not Title Case, on headers

### Color and Surfaces *(only when no existing identity — see Step 0)*
- Avoid pure black — use off-black or tinted dark variants
- Keep accent saturation below 80%
- One accent color only — remove all others
- Stick to one gray family — no mixing warm and cool grays
- Tint shadows with background hue, not pure black
- Add subtle noise/grain to combat flat sterility
- Avoid jarring dark sections interrupting light-mode pages
- Eliminate the purple/blue "AI gradient" aesthetic
- Ensure consistent shadow lighting direction across the page

### Layout
- Add max-width container (1200–1440px) with auto margins
- Use `min-height: 100dvh` not `height: 100vh`
- Break symmetry — avoid three equal card columns (most generic AI layout)
- Allow variable card heights instead of forcing equal
- Vary border-radius — tighter inner elements, softer containers
- Double the whitespace — let designs breathe
- Use CSS Grid for complex structures
- Create depth through negative margins and layering
- Align buttons and features vertically across card groups

### Interactivity
- Add hover states: background shift, scale, or translate
- Add press feedback: `scale(0.97)` on `:active` (unified with `emil-design-eng` — see references)
- All transitions 200–300ms
- Visible focus rings (accessibility requirement)
- Skeleton loaders, not spinners
- Design empty states, not blank screens
- Animate only `transform` and `opacity` (GPU-accelerated)
- `scroll-behavior: smooth`

### Content Quality
- Use diverse, realistic names — not "John Doe"
- Use organic data, not round numbers (`47.2%`, not `50%`)
- Avoid placeholder company names ("Acme", "Nexus")
- Eliminate marketing clichés: "Elevate," "Seamless," "Unleash," "Next-Gen," "Game-changer"
- Remove exclamation marks from success/status messages
- Active voice, specific language — not vague filler
- Randomize dates in lists (blog posts, activity feeds) — no visibly sequential timestamps
- Use unique avatar images, not the same placeholder repeated
- Write real copy, not Lorem Ipsum
- Sentence case on headers

### Component Patterns
- Remove unnecessary card borders and shadows — pick one, not both
- Diversify button styles beyond filled/ghost combinations
- Replace pill-shaped badges with alternatives where a badge appears on everything
- Reconsider accordion FAQ sections — often a default that doesn't fit the content
- Modernize testimonial carousels
- Highlight the recommended pricing tier, don't leave all tiers visually equal
- Use inline editing over modal dialogs for simple actions
- Simplify footer link structures
- Status badges: square or plain text, not pill-shaped for everything
- Avoid modals for simple actions — use slide-overs or inline edit instead

### Iconography
- Move beyond default Lucide/Feather icons where they've become the visible default —
  Phosphor or a custom set reads more deliberate
- Replace clichéd icon metaphors (lightbulb = idea, rocket = launch)
- Standardize stroke widths across the icon set
- Include a real, branded favicon — not the framework default
- Use authentic team photography, not stock

### Code Quality
- Use semantic HTML (`<nav>`, `<main>`, `<article>`, `<aside>`, `<section>`)
- Consolidate inline styles into CSS classes
- Use relative units over hardcoded pixels
- Add descriptive alt text to images
- Establish a z-index scale instead of arbitrary large numbers
- Remove debug artifacts (`console.log`, commented-out blocks, TODO stubs)
- Verify all imports exist in dependencies before shipping
- Add proper meta tags

### Strategic Omissions to Check
- Privacy policy and terms of service links present
- "Back" navigation options where a user could get stuck
- A custom 404 page, not the framework default
- Form validation on every input that needs it
- Skip-to-content link for keyboard users
- Cookie consent compliance, if applicable

## Upgrade Techniques (when more visual impact is wanted)

- **Typography:** variable font animation, outlined-to-fill transitions, text mask reveals
- **Layout:** broken grids with asymmetry, whitespace maximization, parallax card stacks, split-screen scroll
- **Motion:** smooth scroll with inertia, staggered entry animations, spring physics, scroll-driven reveals
- **Surfaces:** glassmorphism with inner borders, spotlight borders, grain overlays, colored shadows

## Essential Rules

- **Maintain consistency with the project's existing styling system.** This is the rule that
  makes Step 0 matter — never let this checklist override an identity that's already there.
- Work with the existing tech stack — do not migrate frameworks.
- Do not break existing functionality. Test after every change.
- Check dependency files before importing new libraries.
- Verify Tailwind version (v3 vs v4) before modifying config.
- Keep changes focused and reviewable. Small, targeted improvements over big rewrites.

## See Also

- `taste-skill` — for defining the identity of a NEW project from a brief (brief-first, three
  configurable dials), rather than upgrading an existing one.
- `design-md` — the format an existing identity is usually recorded in; check for this file
  before doing anything in the Typography or Color sections above.
- `design-md` — generates a new project's identity if Step 0 finds none.
