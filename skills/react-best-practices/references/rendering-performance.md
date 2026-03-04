# Rendering Performance Rules

Source: Vercel Engineering / vercel-labs agent-skills

These rules reduce browser layout, paint, and hydration overhead. They apply after React has reconciled — at the browser rendering stage.

---

## rendering-animate-svg-wrapper

Wrap SVG animations inside a `<div>` with `will-change: transform` rather than animating the SVG directly. SVG layout is expensive; GPU-composited transforms on a wrapper are cheap.

```tsx
<div style={{ willChange: 'transform' }}>
  <svg className="animate-spin">...</svg>
</div>
```

Why: `will-change: transform` promotes the element to its own compositor layer, enabling GPU-accelerated animation without triggering layout recalculations on every frame.

---

## rendering-content-visibility

Apply `content-visibility: auto` to large off-screen sections (long article bodies, collapsed accordions, below-the-fold content) to skip layout and paint for invisible areas.

```css
.page-section {
  content-visibility: auto;
  contain-intrinsic-size: 0 500px; /* estimated height to prevent layout shift */
}
```

Why: The browser spends time laying out and painting content that isn't visible. `content-visibility: auto` instructs it to skip rendering for off-screen elements until they approach the viewport.

---

## rendering-hoist-jsx

Move JSX object literals that don't change out of component render functions. Objects created inside a function body are recreated on every call, causing identity comparisons to fail.

```tsx
// Bad — new object every render:
function Page() {
  return <Layout style={{ padding: '16px' }}>...</Layout>;
}

// Good — stable reference:
const LAYOUT_STYLE = { padding: '16px' };
function Page() {
  return <Layout style={LAYOUT_STYLE}>...</Layout>;
}
```

---

## rendering-svg-precision

Reduce SVG path precision to 1-2 decimal places. SVG files exported from design tools often use 6+ decimal places, which increases file size and parse time without visible difference.

```svg
<!-- Before: 6 decimal places -->
<path d="M 10.234567 20.987654 L 30.123456 40.876543" />

<!-- After: 1 decimal place -->
<path d="M 10.2 21 L 30.1 40.9" />
```

Use SVGO or a build step to automate this optimization.

---

## rendering-hydration-no-flicker

Prevent content flash during hydration by matching server and client renders exactly. Apply initial styles server-side when possible, or use CSS variables that are set in a synchronous `<script>` in `<head>`.

```html
<!-- In <head> — runs before paint, no flash: -->
<script>
  document.documentElement.setAttribute(
    'data-theme',
    localStorage.getItem('theme') ?? 'light'
  );
</script>
```

Why: React hydration expects server HTML to match the initial client render. If client state (e.g., theme from localStorage) isn't reflected in the server render, React either errors or produces a flash.

---

## rendering-hydration-suppress-warning

Use `suppressHydrationWarning` only for legitimately client-specific values — timestamps, random IDs, content that's intentionally different between server and client. Don't use it to silence real mismatch bugs.

```tsx
<span suppressHydrationWarning>
  {new Date().toLocaleDateString()}
</span>
```

If you're suppressing a warning for a value that *should* match, fix the mismatch instead.

---

## rendering-activity

Use React's `<Activity>` component (experimental, React 19+) or CSS `hidden` attribute to hide and show content without unmounting it. Unmounting destroys component state; hiding preserves it.

```tsx
// Preserves state when inactive:
<Activity mode={isVisible ? 'visible' : 'hidden'}>
  <ExpensiveComponent />
</Activity>
```

For stable React versions, use CSS `display: none` or `visibility: hidden` on a wrapper to achieve the same effect without unmounting.

---

## rendering-conditional-render

When conditionally rendering, prefer the ternary pattern over `&&` for nullable/falsy values to avoid rendering `0` or `false` as text.

```tsx
// Bad — renders "0" when count is 0:
{count && <Badge count={count} />}

// Good:
{count > 0 && <Badge count={count} />}
// or:
{count ? <Badge count={count} /> : null}
```

---

## rendering-usetransition-loading

Use `useTransition` + a pending state indicator for navigations and data operations that take over 100ms. This keeps the UI responsive during the transition instead of freezing.

```tsx
const [isPending, startTransition] = useTransition();

function handleNavigate(route: string) {
  startTransition(() => {
    router.push(route);
  });
}

return (
  <button onClick={() => handleNavigate('/dashboard')} disabled={isPending}>
    {isPending ? <Spinner /> : 'Go to Dashboard'}
  </button>
);
```
