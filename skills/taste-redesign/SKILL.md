---
name: taste-redesign
description: >
  Upgrades existing UIs to premium quality by auditing generic AI patterns and applying high-end
  design standards. Use when UI looks flat, generic, or "AI-slop". Triggers on: "improve the
  design", "looks generic", "not polished enough", "redesign this", "elevate the UI", "it looks
  boring", "make it better looking", "apply taste", "design review". Works with any CSS framework.
  Source: github.com/leonxlnx/taste-skill (redesign-skill variant).
---

# Taste Redesign Skill

Apply changes in this order for maximum visual impact with minimum risk:

1. **Font swap** — biggest instant improvement
2. **Color palette cleanup** — remove clashing or oversaturated colors
3. **Hover and active states** — makes the interface feel alive
4. **Layout and spacing** — proper grid, max-width, consistent padding
5. **Replace generic components** — swap cliché patterns for modern alternatives
6. **Add loading, empty, and error states** — makes it feel finished
7. **Polish typography scale and spacing** — the premium final touch

## Audit Checklist

### Typography
- Replace generic fonts (Inter, Roboto, Arial) with distinctive alternatives: Geist, Outfit, Cabinet Grotesk
- Tighten letter-spacing on headlines, reduce line-height — headlines should feel heavy
- Limit paragraph width to ~65 characters, increase line-height for readability
- Introduce Medium (500) and SemiBold (600) weights
- Use `font-variant-numeric: tabular-nums` for data-heavy interfaces
- Fix orphaned words with `text-wrap: balance` or `text-wrap: pretty`
- Use sentence case, not Title Case, on headers

### Color and Surfaces
- Avoid pure black — use off-black or tinted dark variants
- Keep accent saturation below 80%
- One accent color only — remove all others
- Stick to one gray family — no mixing warm and cool grays
- Tint shadows with background hue, not pure black
- Add subtle noise/grain to combat flat sterility
- Avoid jarring dark sections interrupting light-mode pages

### Layout
- Add max-width container (1200–1440px) with auto margins
- Use `min-height: 100dvh` not `height: 100vh`
- Break symmetry — avoid three equal card columns (most generic AI layout)
- Allow variable card heights instead of forcing equal
- Vary border-radius — tighter inner elements, softer containers
- Double the whitespace — let designs breathe

### Interactivity
- Add hover states: background shift, scale, or translate
- Add press feedback: `scale(0.98)` or `translateY(1px)`
- All transitions 200–300ms
- Visible focus rings (accessibility requirement)
- Skeleton loaders, not spinners
- Design empty states, not blank screens
- Animate only `transform` and `opacity` (GPU-accelerated)

### Components
- Cards: use only border, or only background, or only spacing — not all three
- Status badges: square or plain text, not pill-shaped for everything
- Avoid modals for simple actions — use slide-overs or inline edit instead

### Rules
- Work with the existing tech stack — do not migrate frameworks
- Test after every change
- Small, targeted improvements over big rewrites
