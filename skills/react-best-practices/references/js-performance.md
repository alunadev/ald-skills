# JavaScript Performance Rules

Source: Vercel Engineering / vercel-labs agent-skills

These micro-optimizations compound at scale. Apply during dedicated performance audits, not during initial feature development. Each rule has O(n) → O(1) or similar impact on hot code paths.

---

## js-batch-dom-css

Batch DOM reads and writes separately to avoid layout thrashing. Reading a layout property (e.g., `offsetWidth`) after a write forces the browser to recalculate layout synchronously.

```ts
// Bad — forced synchronous layout (read-write-read-write):
elements.forEach(el => {
  const width = el.offsetWidth; // forces layout
  el.style.width = width * 2 + 'px'; // write
});

// Good — batch reads, then writes:
const widths = elements.map(el => el.offsetWidth); // batch reads
elements.forEach((el, i) => {
  el.style.width = widths[i] * 2 + 'px'; // batch writes
});
```

---

## js-index-maps

Pre-compute a `Map` or record from arrays when you perform repeated key-based lookups. Array `.find()` is O(n); Map lookup is O(1).

```ts
// Bad — O(n²) for n items with n lookups:
const getUser = (id: string) => users.find(u => u.id === id);

// Good — O(n) build, O(1) lookups:
const userMap = new Map(users.map(u => [u.id, u]));
const getUser = (id: string) => userMap.get(id);
```

---

## js-cache-property-access

Cache deeply nested property access in a local variable when accessed multiple times in a function. Property chain traversal has overhead; a local reference is direct.

```ts
// Bad — traverses the chain on every iteration:
for (let i = 0; i < items.length; i++) {
  process(config.settings.display.theme.colors[items[i].type]);
}

// Good — cache the reference:
const colorMap = config.settings.display.theme.colors;
for (let i = 0; i < items.length; i++) {
  process(colorMap[items[i].type]);
}
```

---

## js-cache-function-results

Memoize pure functions with expensive computations using a `Map` or a memoization utility. Only applies to pure functions (same input → same output, no side effects).

```ts
const cache = new Map<string, ProcessedData>();

function processExpensive(input: string): ProcessedData {
  if (cache.has(input)) return cache.get(input)!;
  const result = doExpensiveWork(input);
  cache.set(input, result);
  return result;
}
```

For unbounded input sets, use an LRU cache to prevent memory leaks.

---

## js-cache-storage

Avoid repeated `localStorage.getItem()` / `sessionStorage.getItem()` calls. Storage access has synchronous I/O overhead; read once and cache in memory.

```ts
let cachedTheme: string | null;

function getTheme(): string {
  if (cachedTheme !== undefined) return cachedTheme ?? 'light';
  cachedTheme = localStorage.getItem('theme');
  return cachedTheme ?? 'light';
}
```

---

## js-combine-iterations

Merge multiple `.map()`, `.filter()`, or `.forEach()` loops over the same array into a single pass. Each iteration creates a new array and traverses all elements.

```ts
// Bad — 3 passes over items:
const active = items.filter(i => i.active);
const names = active.map(i => i.name);
const upperNames = names.map(n => n.toUpperCase());

// Good — 1 pass:
const upperActiveNames = items.reduce<string[]>((acc, i) => {
  if (i.active) acc.push(i.name.toUpperCase());
  return acc;
}, []);
```

---

## js-length-check-first

Check array length before processing when the empty case is common. Avoids unnecessary function call overhead and allocation.

```ts
function processItems(items: Item[]) {
  if (items.length === 0) return;
  // ... expensive processing
}
```

---

## js-early-exit

Add guard clauses at the top of functions to exit as early as possible. This reduces indentation, improves readability, and skips expensive work for invalid inputs.

```ts
function processUser(user: User | null) {
  if (!user) return null;
  if (!user.isActive) return null;
  if (!user.permissions.canEdit) return null;

  return doExpensiveProcessing(user);
}
```

---

## js-hoist-regexp

Create `RegExp` objects outside of functions when the pattern doesn't change. RegExp creation and compilation has overhead; module-level constants are compiled once.

```ts
// Bad — compiles the regex on every call:
function isEmail(str: string) {
  return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(str);
}

// Good — compiled once:
const EMAIL_RE = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
function isEmail(str: string) {
  return EMAIL_RE.test(str);
}
```

---

## js-min-max-loop

Avoid using `Math.min(...array)` or `Math.max(...array)` for large arrays — the spread operator can exceed the call stack limit and is slower than a manual loop.

```ts
// Bad — breaks for large arrays:
const max = Math.max(...largeArray);

// Good — O(n) single pass:
let max = -Infinity;
for (const val of largeArray) {
  if (val > max) max = val;
}
```

---

## js-set-map-lookups

Use `Set` for membership checks and `Map` for key-value lookups. Both are O(1); array `includes()` and `find()` are O(n).

```ts
// Bad — O(n) for each check:
const ALLOWED = ['admin', 'editor', 'viewer'];
if (ALLOWED.includes(role)) { ... }

// Good — O(1):
const ALLOWED = new Set(['admin', 'editor', 'viewer']);
if (ALLOWED.has(role)) { ... }
```

---

## js-tosorted-immutable

Use `.toSorted()`, `.toReversed()`, and `.toSpliced()` (ES2023) for immutable array operations instead of copy-then-mutate patterns. These methods return new arrays without mutating the original.

```ts
// Bad — copies then mutates:
const sorted = [...items].sort(compare);

// Good — immutable, no manual copy:
const sorted = items.toSorted(compare);
```

Check browser compatibility; polyfill if targeting older environments. In Next.js with modern Node.js targets, these are safe to use.
