---
name: applying-web-design-guidelines
description: Audits and enforces web interface standards covering accessibility, performance, UX, and code quality from Vercel Engineering's Web Interface Guidelines. Use this skill when reviewing UI code, checking accessibility compliance, auditing design implementations, running pre-merge frontend checks, or when someone asks to "review my UI", "check accessibility", "check my site", "audit design", or "is this component correct". Apply proactively when writing form elements, interactive components, images, animations, or anything that users directly touch — these guidelines prevent common mistakes before they reach production.
---

# Web Design Guidelines

Good UI code is more than styling — it's accessibility, resilience, performance, and copy, all working together. These guidelines are derived from Vercel Engineering's Web Interface Guidelines, covering 18 categories that address the most common quality gaps in production web UIs.

## Workflow

1. **Read the relevant category file** from `references/` based on what's being reviewed (accessibility issues → `references/accessibility.md`, performance → `references/performance-navigation.md`, etc.)
2. **Scan the code** for violations in the relevant categories
3. **Report findings** in `file:line` format with the rule name, what's wrong, and the fix
4. **Prioritize** — fix Accessibility and Forms first (user-blocking), then Performance, then the rest

Read `references/accessibility.md` first for any UI review — it covers the most critical rules.

---

## Category Overview

### 1. Accessibility — CRITICAL

Interactive elements need accessible labels. Screen readers, voice navigation, and keyboard users depend on them. Every `<button>`, `<a>`, `<input>`, and icon-only element needs an accessible name.

Critical rules: `aria-label` on icon buttons, semantic HTML (`<button>` not `<div onClick>`), `onKeyDown` alongside `onClick` for custom interactive elements, skip navigation links.

> Read `references/accessibility.md` for the complete rule set.

---

### 2. Focus States — CRITICAL

Every interactive element needs a visible focus indicator. Removing `outline` without providing a replacement breaks keyboard navigation entirely.

Critical rules: Never `outline: none` without `focus-visible` replacement; use `:focus-visible` (not `:focus`) to show indicators only for keyboard navigation.

> Read `references/accessibility.md` for focus state rules.

---

### 3. Forms — HIGH

Forms are where users do work. Broken forms (missing autocomplete, wrong input types, unclear errors) lose users.

Critical rules: `autocomplete` attributes on all relevant inputs, correct `type` for inputs (`email`, `tel`, `number`), inline error messages next to the field (not toast-only), warn before navigating away from unsaved form state.

> Read `references/accessibility.md` for form accessibility rules.

---

### 4. Animation — HIGH

Animations must respect user preferences and only animate GPU-friendly properties. Animating `height`, `width`, or `top/left` causes layout thrash on every frame.

Critical rules: `@media (prefers-reduced-motion: reduce)` wrapping all animations, animate only `transform` and `opacity` (not layout properties).

> Read `references/motion-typography.md` for animation rules.

---

### 5. Typography — MEDIUM-HIGH

Typographic details signal quality. Wrong quote characters, missing number formatting, and unbalanced headings are visible to users even if they can't articulate why something looks off.

Critical rules: curly quotes (`"` not `"`), proper ellipsis (…), `font-variant-numeric: tabular-nums` for numbers in tables, `text-wrap: balance` for headings.

> Read `references/motion-typography.md` for typography rules.

---

### 6. Content Handling — MEDIUM-HIGH

Text overflows, empty states, and long content need explicit handling. Without them, layouts break in production with real data.

Critical rules: `overflow: hidden; text-overflow: ellipsis` on truncated text, `min-width: 0` on flex children that truncate, design explicit empty states (not blank areas), handle long unbroken strings with `overflow-wrap: break-word`.

> Read `references/content-media.md` for content handling rules.

---

### 7. Images — MEDIUM-HIGH

Images without dimensions cause layout shift; images without lazy loading degrade initial load performance.

Critical rules: explicit `width` and `height` attributes on all `<img>` tags, `loading="lazy"` on below-fold images, `fetchpriority="high"` on the above-fold hero image.

> Read `references/content-media.md` for image rules.

---

### 8. Performance — MEDIUM

Perceived performance is about loading the right things at the right time. Virtualizing long lists and preloading critical resources are the highest-impact moves.

Critical rules: virtualize lists over 50 items (react-virtual, react-window), `<link rel="preconnect">` for third-party origins, `<link rel="preload">` for critical fonts.

> Read `references/performance-navigation.md` for performance rules.

---

### 9. Navigation & State — MEDIUM

URL should reflect app state. If refreshing the page loses the user's context (search query, selected tab, filters), that's a bug.

Critical rules: URL reflects current state (query params for filters/search), stateful UI is deep-linkable, browser back button works as expected.

> Read `references/performance-navigation.md` for navigation rules.

---

### 10. Touch & Interaction — MEDIUM

Mobile users tap; desktop users click. Both need appropriate interaction handling.

Critical rules: `touch-action: manipulation` on interactive elements (prevents 300ms tap delay), `overscroll-behavior: contain` on scrollable containers to prevent scroll chaining.

> Read `references/platform-ux.md` for touch and interaction rules.

---

### 11. Safe Areas — MEDIUM

Full-bleed layouts on mobile need to respect device safe areas (notch, home indicator). Content clipped by the notch is inaccessible.

Critical rules: `env(safe-area-inset-*)` CSS variables for full-bleed layouts, `viewport-fit=cover` in the viewport meta tag when using safe area insets.

> Read `references/platform-ux.md` for safe area rules.

---

### 12. Dark Mode — MEDIUM

Dark mode needs explicit handling — not just color inversion. System color scheme should be respected by default.

Critical rules: `color-scheme: dark` on `<html>` or in CSS for dark themes, `<meta name="theme-color">` for browser chrome, no hardcoded hex colors in dark mode styles (use CSS variables).

> Read `references/platform-ux.md` for dark mode rules.

---

### 13. Locale & i18n — MEDIUM

Date, number, and currency formatting must use the browser's locale APIs. Hardcoded formats break for international users.

Critical rules: `Intl.DateTimeFormat` for date formatting (not manual string concatenation), `Intl.NumberFormat` for numbers and currency, never hardcode locale-specific formats.

> Read `references/platform-ux.md` for locale rules.

---

### 14. Hydration — MEDIUM

React hydration mismatches cause content flicker or errors. The most common cause is rendering client-only values (Date.now(), Math.random(), localStorage) on the server.

Critical rules: controlled inputs (`<input value={...}>`) need an `onChange` handler, avoid rendering client-specific values in server-rendered markup.

> Read `references/platform-ux.md` for hydration rules.

---

### 15. Hover & Interactive States — LOW-MEDIUM

Every interactive element needs a hover state to signal clickability. Missing hover states make UI feel unresponsive.

Critical rules: all `<button>` and `<a>` elements have `:hover` styles, cursor changes (`cursor: pointer`) on interactive elements.

> Read `references/platform-ux.md` for hover state rules.

---

### 16. Content & Copy — LOW-MEDIUM

Words are UI. Active voice, specific labels, and correct casing make interfaces feel professional. Passive and vague copy signals low quality.

Critical rules: active voice in button labels ("Save changes" not "Changes will be saved"), Title Case for headings, specific CTAs ("Download invoice" not "Click here").

> Read `references/platform-ux.md` for copy guidelines.

---

### 17. Anti-patterns — LOW

Common patterns that appear in code reviews that should be rejected outright, regardless of context.

> Read `references/antipatterns.md` for the complete list.

---

## Output Format

When auditing code, report each issue as:

```
[CATEGORY] [PRIORITY] rule-name
File: path/to/component.tsx:42
Issue: <img> missing explicit width and height attributes
Fix: Add width={800} height={600} to prevent layout shift during image load
```

Group findings by category, ordered by priority (CRITICAL first).

## Quality Checklist

- [ ] All icon-only buttons have `aria-label`
- [ ] No `outline: none` without `:focus-visible` replacement
- [ ] All `<input>` elements have `autocomplete` attributes where relevant
- [ ] All animations wrapped in `@media (prefers-reduced-motion: reduce)`
- [ ] All `<img>` have explicit `width` and `height`
- [ ] Lists over 50 items are virtualized
- [ ] URL reflects filterable/searchable state

## References

- `references/accessibility.md` — Accessibility, Focus States, Forms (categories 1-3)
- `references/motion-typography.md` — Animation, Typography (categories 4-5)
- `references/content-media.md` — Content Handling, Images (categories 6-7)
- `references/performance-navigation.md` — Performance, Navigation & State (categories 8-9)
- `references/platform-ux.md` — Touch, Safe Areas, Dark Mode, Locale, Hydration, Hover, Copy (categories 10-16)
- `references/antipatterns.md` — Anti-patterns (category 17)

## See Also

- `interface-design` — For intentional design thinking, product domain exploration, and layout decisions
- `web-design-guidelines` applies at the code review level; `interface-design` applies at the design decision level
