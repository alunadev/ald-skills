# Animation & Typography

Source: Vercel Engineering / vercel-labs web-interface-guidelines

---

## Animation

### prefers-reduced-motion

Wrap all animations and transitions in a `prefers-reduced-motion: no-preference` media query. Some users experience motion sickness or vestibular disorders triggered by UI animations. Respecting their preference is not optional — it's an accessibility requirement.

```css
/* Method 1 — wrap animation in media query: */
@media (prefers-reduced-motion: no-preference) {
  .card {
    transition: transform 200ms ease;
  }
  .card:hover {
    transform: translateY(-4px);
  }
}

/* Method 2 — disable in reduced-motion query: */
.card {
  transition: transform 200ms ease;
}
@media (prefers-reduced-motion: reduce) {
  .card {
    transition: none;
  }
}
```

In Tailwind: use `motion-safe:` and `motion-reduce:` variants.

```tsx
<div className="motion-safe:transition-transform motion-safe:hover:-translate-y-1">
  Card
</div>
```

### Animate Only transform and opacity

Animating layout properties (`width`, `height`, `top`, `left`, `margin`, `padding`) triggers layout recalculation and paint on every frame — causing jank, especially on low-powered devices.

Only `transform` and `opacity` changes are GPU-composited: they run on the compositor thread without touching layout.

```css
/* Bad — causes layout recalculation on every frame: */
.modal {
  transition: height 300ms ease;
}

/* Good — GPU composited, no layout: */
.modal {
  transition: transform 300ms ease, opacity 300ms ease;
  /* Use transform: scaleY() to simulate height changes */
}
```

For height animations specifically, use `grid-template-rows` transition (modern approach):

```css
.collapsible {
  display: grid;
  grid-template-rows: 0fr;
  transition: grid-template-rows 300ms ease;
}
.collapsible.open {
  grid-template-rows: 1fr;
}
.collapsible-inner {
  overflow: hidden;
}
```

### animation-fill-mode

Set `animation-fill-mode: forwards` when an animation should hold its final state. Without it, elements snap back to their original state when the animation ends.

```css
.fade-in {
  animation: fadeIn 300ms ease forwards;
}
@keyframes fadeIn {
  from { opacity: 0; transform: translateY(8px); }
  to   { opacity: 1; transform: translateY(0); }
}
```

### Staggered Entrance Animations

For lists of items, stagger entrance animations with `animation-delay` to create a cascading effect. Don't apply the same delay to all items.

```tsx
items.map((item, i) => (
  <li
    key={item.id}
    className="animate-fade-in"
    style={{ animationDelay: `${i * 50}ms` }}
  >
    {item.name}
  </li>
))
```

Keep total stagger duration under 500ms for lists of 10 items to avoid feeling sluggish.

---

## Typography

### Curly Quotes

Use typographic (curly) quotes in copy, not straight quotes. Straight quotes are typewriter artifacts.

```tsx
// Bad:
<p>"Great design is honest."</p>

// Good:
<p>&ldquo;Great design is honest.&rdquo;</p>
// or in JSX (these are actual curly quote characters):
<p>"Great design is honest."</p>
```

### Proper Ellipsis

Use the ellipsis character (…) not three periods (...). Three periods are three glyphs with inter-glyph spacing; the ellipsis is one glyph.

```tsx
// Bad:
<span>Loading...</span>

// Good:
<span>Loading…</span>
// or: <span>Loading&#8230;</span>
```

For CSS text truncation, use `text-overflow: ellipsis` — it uses the proper character automatically.

### Tabular Numbers for Data

Use `font-variant-numeric: tabular-nums` for numbers displayed in tables, dashboards, or anywhere numbers align vertically. Proportional number spacing causes misalignment when digits change.

```css
.metric-value {
  font-variant-numeric: tabular-nums;
}
```

In Tailwind: `tabular-nums` class.

Without tabular nums, "100" and "999" have different widths — a column of numbers will shift horizontally as values change.

### text-wrap: balance for Headings

Apply `text-wrap: balance` to headings to prevent awkward line breaks where one line has two words and the next has ten. The browser distributes text evenly across lines.

```css
h1, h2, h3 {
  text-wrap: balance;
}
```

In Tailwind: `text-balance` class.

Don't apply to body text — it has performance implications for long paragraphs.

### Line Length

Keep body text line length between 60-80 characters for optimal readability. Very wide text (100+ chars) requires eye movement that causes reading fatigue.

```css
.prose {
  max-width: 65ch; /* ch unit = width of '0' character */
}
```

### Leading (Line Height)

Use relative line height values, not pixel values. Pixel values don't scale with font size changes.

```css
/* Bad — doesn't scale: */
p { line-height: 24px; }

/* Good — scales with font-size: */
p { line-height: 1.5; }
```

Recommended values: headings 1.1-1.3, body text 1.5-1.7, small labels 1.2-1.4.
