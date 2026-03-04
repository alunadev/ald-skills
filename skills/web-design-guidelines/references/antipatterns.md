# Anti-patterns

Source: Vercel Engineering / vercel-labs web-interface-guidelines

Common patterns in UI code that should be rejected in code review. These are not edge cases — they appear in most codebases and have clear, better alternatives.

---

## Interaction Anti-patterns

### Using div onClick as Interactive Elements

`<div>` elements clicked with JavaScript are invisible to screen readers, keyboard users, and voice navigation.

```tsx
// Bad:
<div onClick={handleClick} className="btn">Delete</div>

// Good:
<button onClick={handleClick}>Delete</button>
```

### Missing aria-label on Icon Buttons

Icon-only buttons with no text content are announced as "button" to screen readers with no context.

```tsx
// Bad:
<button><TrashIcon /></button>

// Good:
<button aria-label="Delete item"><TrashIcon /></button>
```

### Removing outline Without Focus-Visible Replacement

Global `outline: none` destroys keyboard navigation for all users.

```css
/* Bad — never do this globally: */
* { outline: none; }

/* Good: */
:focus-visible { outline: 2px solid var(--color-focus); }
```

### Nesting Interactive Elements

Nested interactive elements (`<a>` inside `<a>`, `<button>` inside `<a>`) are invalid HTML and cause unpredictable behavior.

```tsx
// Bad:
<a href="/product">
  <h3>Product Name</h3>
  <button onClick={addToCart}>Add to cart</button> {/* invalid */}
</a>

// Good — separate the concerns:
<div className="card">
  <a href="/product"><h3>Product Name</h3></a>
  <button onClick={addToCart}>Add to cart</button>
</div>
```

---

## Layout Anti-patterns

### Overflow Without min-width: 0

Text truncation inside flex containers doesn't work without `min-width: 0` on the flex child.

```css
/* Bad — text overflows: */
.flex { display: flex; }
.child { overflow: hidden; text-overflow: ellipsis; }

/* Good: */
.flex { display: flex; }
.child { min-width: 0; overflow: hidden; text-overflow: ellipsis; }
```

### Fixed Heights for Text Content

Setting `height` (not `min-height`) on elements containing text clips content when font size changes or text wraps.

```css
/* Bad — clips content at larger font sizes: */
.card { height: 200px; }

/* Good: */
.card { min-height: 200px; }
```

### Hardcoded Pixel Values for Responsive Layouts

Hardcoded pixel widths break on different screen sizes. Use relative units, percentage, or responsive CSS.

```css
/* Bad: */
.sidebar { width: 280px; }

/* Good: */
.sidebar { width: 280px; max-width: 100%; }
/* or: */
.sidebar { width: min(280px, 100%); }
```

---

## Performance Anti-patterns

### Large Unvirtualized Lists

Rendering 500+ items at once into the DOM causes long paint times and slow scroll performance.

```tsx
// Bad — all 1000 items in DOM:
{allUsers.map(user => <UserRow key={user.id} user={user} />)}

// Good — only visible items in DOM:
// Use @tanstack/react-virtual or similar
```

### Animating Layout Properties

Animating `height`, `width`, `margin`, or `top/left` triggers layout recalculation on every frame.

```css
/* Bad — layout thrash on every frame: */
.panel { transition: height 300ms; }

/* Good — GPU composited: */
.panel { transition: transform 300ms, opacity 300ms; }
```

### Missing Loading States for Async Data

Empty areas while data loads read as broken pages to users.

```tsx
// Bad — blank screen while loading:
function List() {
  const { data } = useSWR('/api/items', fetcher);
  return <ul>{data?.map(item => <li key={item.id}>{item.name}</li>)}</ul>;
}

// Good — explicit loading state:
function List() {
  const { data, isLoading } = useSWR('/api/items', fetcher);
  if (isLoading) return <ListSkeleton />;
  return <ul>{data.map(item => <li key={item.id}>{item.name}</li>)}</ul>;
}
```

---

## Copy Anti-patterns

### Generic CTA Labels

Labels that don't describe the action leave users guessing what will happen when they click.

```
Bad:  "Submit"  "Click here"  "OK"  "Continue"
Good: "Create account"  "Download report"  "Delete post"  "Continue to payment"
```

### Vague Error Messages

Errors like "Something went wrong" provide no actionable information.

```tsx
// Bad:
<p>An error occurred. Please try again.</p>

// Good:
<p>
  We couldn't load your dashboard data.{' '}
  <button onClick={retry}>Try again</button> or{' '}
  <a href="/support">contact support</a> if this continues.
</p>
```

### Hardcoded Date Formats

```ts
// Bad — US-only, breaks for international users:
`${date.getMonth() + 1}/${date.getDate()}/${date.getFullYear()}`

// Good:
date.toLocaleDateString(navigator.language, { dateStyle: 'medium' })
```

---

## Hydration Anti-patterns

### Rendering Client-Only Values on Server

Values from `Date.now()`, `Math.random()`, `window`, or `localStorage` differ between server and client renders, causing hydration errors.

```tsx
// Bad — timestamp differs between server and client:
<p>Loaded at {Date.now()}</p>

// Good — defer to client:
const [loadedAt, setLoadedAt] = useState<number | null>(null);
useEffect(() => { setLoadedAt(Date.now()); }, []);
```

### Uncontrolled → Controlled Input Switch

Switching an input from uncontrolled (`defaultValue`) to controlled (`value`) mid-lifecycle causes React warnings and unexpected behavior.

```tsx
// Bad — switches between controlled and uncontrolled:
<input value={name || undefined} onChange={...} />

// Good — always controlled:
<input value={name ?? ''} onChange={...} />
```
