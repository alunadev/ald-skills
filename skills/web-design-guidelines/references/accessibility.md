# Accessibility, Focus States & Forms

Source: Vercel Engineering / vercel-labs web-interface-guidelines

---

## Accessibility

### aria-label on Icon Buttons

Every button that contains only an icon (no visible text) needs an `aria-label` that describes its action. Without it, screen readers announce "button" with no context.

```tsx
// Bad:
<button><IconTrash /></button>

// Good:
<button aria-label="Delete item"><IconTrash /></button>
```

### Semantic HTML

Use the HTML element that matches the semantic role. `<div onClick>` creates an interactive element that keyboard and screen reader users can't access.

```tsx
// Bad:
<div onClick={handleClick} className="btn">Submit</div>

// Good:
<button onClick={handleClick}>Submit</button>
```

Rule: if it's clickable, it's a `<button>` (or `<a>` if it navigates). If it holds content, it's a `<div>` or `<section>`.

### Keyboard Handlers

Custom interactive elements built with `<div>` or `<span>` need both `onClick` and `onKeyDown` handlers. Mouse users trigger `onClick`; keyboard users trigger `keydown` with Enter or Space.

```tsx
<div
  role="button"
  tabIndex={0}
  onClick={handleClick}
  onKeyDown={(e) => {
    if (e.key === 'Enter' || e.key === ' ') handleClick();
  }}
>
  Custom button
</div>
```

Prefer real `<button>` elements — they handle keyboard events automatically.

### Skip Navigation Links

Add a "Skip to main content" link as the first focusable element on every page. Keyboard users navigate via Tab; without a skip link, they tab through the entire nav on every page.

```tsx
<a
  href="#main-content"
  className="sr-only focus:not-sr-only focus:absolute focus:top-4 focus:left-4"
>
  Skip to main content
</a>
<main id="main-content">...</main>
```

### Alt Text for Images

Every `<img>` needs an `alt` attribute. Decorative images use `alt=""` (empty string, not omitted). Informational images describe their content.

```tsx
// Decorative:
<img src="/decoration.png" alt="" />

// Informational:
<img src="/dashboard-screenshot.png" alt="Dashboard showing monthly revenue chart" />
```

---

## Focus States

### Never outline: none Without Replacement

Removing the browser's default focus outline without providing a replacement breaks keyboard navigation. Users can't see where focus is.

```css
/* Bad — removes focus indicator entirely: */
* { outline: none; }

/* Good — replace with custom: */
:focus-visible {
  outline: 2px solid var(--color-focus);
  outline-offset: 2px;
}
```

### Use :focus-visible, Not :focus

`:focus` shows the indicator for mouse clicks too, which is visually noisy. `:focus-visible` shows the indicator only when focus was reached via keyboard — which is the right behavior.

```css
/* Shows on mouse click (noisy) — avoid: */
button:focus { outline: 2px solid blue; }

/* Shows only on keyboard focus — preferred: */
button:focus-visible { outline: 2px solid var(--color-focus); }
```

### Focus Visible on Custom Components

Custom interactive components (built with `div` or non-semantic elements) don't inherit focus styles automatically. Add explicit `tabIndex={0}` and a `:focus-visible` style.

```tsx
<div
  tabIndex={0}
  className="... focus-visible:outline focus-visible:outline-2 focus-visible:outline-blue-500"
>
  Focusable item
</div>
```

---

## Forms

### autocomplete Attributes

Set `autocomplete` attributes on all relevant fields. This enables browser autofill, which reduces friction for users and speeds up form completion.

```html
<input type="email" name="email" autocomplete="email" />
<input type="tel" name="phone" autocomplete="tel" />
<input type="text" name="name" autocomplete="name" />
<input type="password" name="password" autocomplete="current-password" />
```

Full list: https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/autocomplete

### Correct Input Types

Use the right `type` for every input. Wrong types remove keyboard shortcuts (phone number pad on mobile), disable browser validation, and break autofill.

```html
<input type="email" />     <!-- Shows @ keyboard on mobile -->
<input type="tel" />       <!-- Shows number pad on mobile -->
<input type="number" />    <!-- Enables numeric validation -->
<input type="url" />       <!-- Shows .com key on mobile -->
<input type="date" />      <!-- Native date picker -->
<input type="search" />    <!-- Shows search keyboard and clear button -->
```

### Inline Error Messages

Display validation errors inline, adjacent to the failing field — not only as a toast or at the top of the form. Users need to see what's wrong and where.

```tsx
<div>
  <label htmlFor="email">Email</label>
  <input
    id="email"
    type="email"
    aria-describedby={emailError ? 'email-error' : undefined}
    aria-invalid={!!emailError}
  />
  {emailError && (
    <p id="email-error" role="alert" className="text-red-600 text-sm mt-1">
      {emailError}
    </p>
  )}
</div>
```

### Warn on Unsaved Changes

Warn the user before navigating away from a form with unsaved changes. Silent navigation loses work.

```tsx
useEffect(() => {
  if (!isDirty) return;

  const handleBeforeUnload = (e: BeforeUnloadEvent) => {
    e.preventDefault();
    e.returnValue = '';
  };

  window.addEventListener('beforeunload', handleBeforeUnload);
  return () => window.removeEventListener('beforeunload', handleBeforeUnload);
}, [isDirty]);
```

For Next.js router navigation, also intercept `router.beforePopState` or use the `navigation` API.

### Associate Labels with Inputs

Every `<input>`, `<select>`, and `<textarea>` needs a `<label>` with a matching `htmlFor`/`id` pair, or use `aria-label`. Placeholder text is not a label — it disappears when the user starts typing.

```tsx
// Good:
<label htmlFor="username">Username</label>
<input id="username" type="text" />

// Also good for visually hidden labels:
<input type="search" aria-label="Search products" />
```
