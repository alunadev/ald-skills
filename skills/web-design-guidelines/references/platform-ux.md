# Platform, UX & Copy

Source: Vercel Engineering / vercel-labs web-interface-guidelines

Covers: Touch & Interaction, Safe Areas, Dark Mode, Locale & i18n, Hydration, Hover States, and Content & Copy.

---

## Touch & Interaction

### touch-action: manipulation

Apply `touch-action: manipulation` to all interactive elements. Without it, mobile browsers wait up to 300ms before registering a tap to detect potential double-tap zoom gestures.

```css
button, a, [role="button"] {
  touch-action: manipulation;
}
```

In Tailwind: `touch-manipulation`. This single rule eliminates the 300ms tap delay on all interactive elements.

### overscroll-behavior: contain

Apply `overscroll-behavior: contain` to scrollable containers to prevent scroll chaining — where scrolling inside a modal or sidebar scrolls the page behind it.

```css
.modal-body {
  overflow-y: auto;
  overscroll-behavior: contain;
}
```

Without this, reaching the top or bottom of a modal's scroll area causes the background to scroll, which is disorienting.

### Minimum Touch Target Size

Interactive elements should be at least 44×44px to be reliably tappable on mobile. Small targets cause misses and frustration.

```css
.icon-button {
  min-width: 44px;
  min-height: 44px;
  display: flex;
  align-items: center;
  justify-content: center;
}
```

Use padding to increase the touch target without increasing the visual size.

---

## Safe Areas

### env(safe-area-inset-*)

For full-bleed layouts on mobile (edge-to-edge content), use `env(safe-area-inset-*)` CSS variables to avoid placing content behind the notch or home indicator.

```css
.nav-bar {
  padding-bottom: env(safe-area-inset-bottom);
}

.header {
  padding-top: env(safe-area-inset-top);
}

.fixed-bottom {
  bottom: env(safe-area-inset-bottom);
}
```

### viewport-fit=cover

Safe area insets only work when the viewport meta tag includes `viewport-fit=cover`:

```html
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover" />
```

Without this, `env(safe-area-inset-*)` returns 0 on all devices.

---

## Dark Mode

### color-scheme: dark

When implementing dark mode, set `color-scheme: dark` to tell the browser to render browser-native UI (scrollbars, form controls, selection highlight) in dark mode.

```css
html[data-theme="dark"] {
  color-scheme: dark;
}
```

Or via meta tag for system preference:

```html
<meta name="color-scheme" content="dark light" />
```

### theme-color Meta Tag

Set `<meta name="theme-color">` to match your app's primary color. This colors the browser chrome (address bar, status bar) on mobile.

```html
<!-- Light mode: -->
<meta name="theme-color" content="#ffffff" media="(prefers-color-scheme: light)" />
<!-- Dark mode: -->
<meta name="theme-color" content="#0a0a0a" media="(prefers-color-scheme: dark)" />
```

### CSS Variables for Theme Colors

Never hardcode hex colors in dark mode styles. Use CSS custom properties (variables) defined at the root level for theme colors — this enables clean theme switching.

```css
:root {
  --color-background: #ffffff;
  --color-text: #0a0a0a;
  --color-border: #e5e7eb;
}

[data-theme="dark"] {
  --color-background: #0a0a0a;
  --color-text: #f9fafb;
  --color-border: #374151;
}
```

---

## Locale & i18n

### Intl.DateTimeFormat for Dates

Use `Intl.DateTimeFormat` (or `Date.toLocaleDateString`) for all date formatting. Hardcoded date formats break for international users.

```ts
// Bad — US-only format:
const dateStr = `${date.getMonth() + 1}/${date.getDate()}/${date.getFullYear()}`;

// Good — locale-aware:
const dateStr = new Intl.DateTimeFormat('en-US', {
  year: 'numeric',
  month: 'long',
  day: 'numeric',
}).format(date);

// Or with user's locale:
const dateStr = date.toLocaleDateString(navigator.language, {
  dateStyle: 'medium',
});
```

### Intl.NumberFormat for Numbers and Currency

Use `Intl.NumberFormat` for formatting numbers and currency. Different locales use different decimal separators and digit grouping.

```ts
// Bad — US-only format:
const priceStr = `$${price.toFixed(2)}`;

// Good — locale-aware:
const priceStr = new Intl.NumberFormat('en-US', {
  style: 'currency',
  currency: 'USD',
}).format(price);
```

### Relative Time Formatting

Use `Intl.RelativeTimeFormat` for "3 days ago" style formatting instead of hardcoded strings.

```ts
const rtf = new Intl.RelativeTimeFormat('en', { numeric: 'auto' });

function timeAgo(date: Date): string {
  const seconds = Math.floor((Date.now() - date.getTime()) / 1000);
  if (seconds < 60) return rtf.format(-seconds, 'second');
  if (seconds < 3600) return rtf.format(-Math.floor(seconds / 60), 'minute');
  if (seconds < 86400) return rtf.format(-Math.floor(seconds / 3600), 'hour');
  return rtf.format(-Math.floor(seconds / 86400), 'day');
}
```

---

## Hydration

### Controlled Inputs Need onChange

React controlled inputs (`<input value={...}>`) require an `onChange` handler. Without it, React renders the input as read-only and logs a warning.

```tsx
// Bad — read-only input with warning:
<input value={name} />

// Good:
<input value={name} onChange={(e) => setName(e.target.value)} />

// Or uncontrolled with default:
<input defaultValue={name} />
```

### Avoid Client-Specific Values in SSR

Values that differ between server and client (timestamps, random IDs, window dimensions, localStorage) cause hydration mismatches. Defer them to a client-side effect.

```tsx
// Bad — renders different timestamp on server vs client:
function Footer() {
  return <p>© {new Date().getFullYear()} Acme Corp</p>;
}

// Good — constant that matches:
const YEAR = new Date().getFullYear(); // computed at build time in RSC

// Or use useEffect for truly dynamic client values:
function LocaleDisplay() {
  const [locale, setLocale] = useState<string>('');
  useEffect(() => {
    setLocale(navigator.language);
  }, []);
  return <p>Locale: {locale || 'Loading...'}</p>;
}
```

---

## Hover & Interactive States

### Hover States on All Interactive Elements

Every button, link, and clickable element needs a visible hover state. It signals to the user that the element is interactive.

```css
button:hover {
  background-color: var(--color-button-hover);
}

a:hover {
  text-decoration: underline;
  color: var(--color-link-hover);
}
```

### cursor: pointer

Apply `cursor: pointer` to all clickable non-link elements. Buttons inside HTML forms already get pointer cursor. Custom interactive elements (card clicks, list items) need it explicitly.

```css
[role="button"], .clickable-card {
  cursor: pointer;
}
```

---

## Content & Copy

### Active Voice

Write labels, button text, and messages in active voice. Active voice is shorter, more direct, and feels more responsive.

```
Bad:  "Changes will be saved"
Good: "Save changes"

Bad:  "Your account has been created"
Good: "Account created"

Bad:  "It is required that all fields are filled in"
Good: "Fill in all required fields"
```

### Title Case for Headings

Use Title Case for page headings, section headings, and navigation labels. Use sentence case for body text, descriptions, and longer labels.

```
Title Case (headings):   "User Settings"  "Activity Log"
Sentence case (labels):  "Enable notifications"  "Add new member"
```

### Specific CTAs

Call-to-action labels should describe the exact action, not be generic. Users should know exactly what will happen when they click.

```
Bad:  "Click here"  "Submit"  "OK"  "Yes"
Good: "Download invoice"  "Save changes"  "Delete account"  "Yes, cancel subscription"
```

### Numeric Quantities Over Vague Words

When showing counts, use numbers over vague words like "many" or "several".

```
Bad:  "Many users are affected"
Good: "47 users are affected"

Bad:  "a few minutes ago"
Good: "3 minutes ago"
```
