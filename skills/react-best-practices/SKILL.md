---
name: following-react-best-practices
description: React and Next.js performance optimization guidelines from Vercel Engineering. Use this skill when writing, reviewing, or refactoring React/Next.js code. Apply it proactively whenever working on React components, Next.js pages, API routes, data fetching (server or client), bundle size, rendering performance, re-renders, server actions, hydration, animations, or JavaScript optimizations. If the code involves React or Next.js, use this skill — even if performance isn't the stated goal, these patterns prevent issues before they arise.
---

# React Best Practices

Performance in React isn't one thing — it's a stack of decisions made at every layer, from how you fetch data to how you structure a conditional. These guidelines cover 8 categories derived from Vercel Engineering's production patterns. Apply the HIGH priority categories first; revisit MEDIUM/LOW during review or refactoring phases.

## Workflow

1. **Identify the component type** — Server Component (default in Next.js App Router) or Client Component (`"use client"`). This determines which categories apply.
2. **Check for waterfalls** — Sequential awaits where parallel fetching is possible are the most common performance killer.
3. **Check bundle contributions** — Barrel imports and unguarded dynamic dependencies inflate initial load.
4. **Audit server-side patterns** — Caching, serialization, and auth in server actions.
5. **Review client-side state** — Re-renders, SWR usage, event listener patterns.
6. **Apply low-priority optimizations** — JS micro-optimizations and advanced patterns during dedicated perf reviews.

For the full rule catalog, read the `references/` file for the relevant category before implementing.

---

## Categories

### 1. Eliminating Waterfalls — CRITICAL

Sequential async operations block the render pipeline. Every unnecessary sequential await adds to Time to First Byte and visible loading time.

**Key rules:**
- **Defer await**: Move `await` into the branch where the value is first used, not at the top of a component.
- **Parallel fetching**: Use `Promise.all()` or `Promise.allSettled()` for independent operations.
- **Suspense boundaries**: Wrap independent data-fetching components in `<Suspense>` to stream UI progressively.

```tsx
// Instead of sequential:
const user = await getUser();
const posts = await getPosts();

// Use parallel:
const [user, posts] = await Promise.all([getUser(), getPosts()]);
```

---

### 2. Bundle Size Optimization — CRITICAL

Every kilobyte added to the initial bundle delays interactivity. Barrel files and eager imports are the primary culprits in Next.js apps.

**Key rules:**
- **Direct imports**: Import specific files, not barrel index files (`import Button from '@ui/Button'` not `import { Button } from '@ui'`).
- **Dynamic imports**: Use `next/dynamic` with `ssr: false` for components not needed on initial render (charts, modals, editors).
- **Conditional loading**: Load heavy modules (e.g., PDF renderers, video players) only when the feature activates.

```tsx
const PDFViewer = dynamic(() => import('@/components/PDFViewer'), { ssr: false });
```

---

### 3. Server-Side Performance — HIGH

Server Components run on the server per request. Inefficient I/O, redundant serialization, and missing caches multiply costs across concurrent users.

**Key rules:**
- **`React.cache()`** for per-request deduplication — wrap data fetching functions called in multiple components within a single render.
- **LRU cache** for cross-request caching of stable data (e.g., config lookups, CMS content with short TTLs).
- **Hoist static I/O** — fonts, default images, and config loaded at module level, not inside render functions.
- **Minimize RSC props** — data passed to Client Components must be serialized; pass only what the client actually renders.

> Read `references/server-performance.md` for all 8 rules with examples (server-auth-actions, server-cache-react, server-cache-lru, server-dedup-props, server-hoist-static-io, server-serialization, server-parallel-fetching, server-after-nonblocking).

---

### 4. Client-Side Data Fetching — MEDIUM-HIGH

Client-side fetching patterns affect perceived performance and network efficiency. Uncoordinated requests duplicate work; passive event listeners block scrolling.

**Key rules:**
- **SWR deduplication**: Use `useSWR` for client data fetching — it automatically deduplicates concurrent requests for the same key.
- **Passive event listeners**: Add `{ passive: true }` to scroll and touch handlers to avoid blocking the main thread.

> Read `references/client-fetching.md` for all 4 rules (client-swr-dedup, client-event-listeners, client-passive-event-listeners, client-localstorage-schema).

---

### 5. Re-render Optimization — MEDIUM

Unnecessary re-renders are the most common runtime performance issue. React re-renders when state changes — the goal is making sure only the components that need to update actually do.

**Key rules:**
- **`useMemo` with default value**: Provide stable defaults to avoid undefined → value transitions that cause downstream re-renders.
- **Derived state without effect**: Compute derived values during render, not in `useEffect` with `setState`.
- **Functional setState**: Use the callback form `setState(prev => ...)` when new state depends on previous.
- **Lazy state init**: Pass a function to `useState` for expensive initial values: `useState(() => computeExpensive())`.

> Read `references/rerender-optimization.md` for all 12 rules (rerender-defer-reads, rerender-memo, rerender-memo-with-default-value, rerender-dependencies, rerender-derived-state, rerender-derived-state-no-effect, rerender-functional-setstate, rerender-lazy-state-init, rerender-simple-expression-in-memo, rerender-move-effect-to-event, rerender-transitions, rerender-use-ref-transient-values).

---

### 6. Rendering Performance — MEDIUM

Browser rendering is the last mile. DOM mutations, layout thrashing, and unoptimized SVGs cause jank even when React itself is efficient.

**Key rules:**
- **`content-visibility: auto`**: Apply to off-screen content sections to skip layout and paint for invisible areas.
- **Hoist JSX constants**: Move static JSX outside component functions to avoid object recreation on every render.
- **Suppress hydration warnings carefully**: Only use `suppressHydrationWarning` for genuinely client-only values (e.g., timestamps, random IDs) — not to hide real mismatches.

> Read `references/rendering-performance.md` for all 9 rules (rendering-animate-svg-wrapper, rendering-content-visibility, rendering-hoist-jsx, rendering-svg-precision, rendering-hydration-no-flicker, rendering-hydration-suppress-warning, rendering-activity, rendering-conditional-render, rendering-usetransition-loading).

---

### 7. JavaScript Performance — LOW-MEDIUM

These micro-optimizations compound at scale. Prioritize during dedicated performance audits, not during initial development.

**Key rules:**
- **Index maps over repeated array finds**: Pre-compute a `Map` or record from arrays used in loops or repeated lookups.
- **Early exit**: Add guard clauses to exit expensive functions as early as possible.
- **Set/Map lookups**: Use `Set` for membership checks and `Map` for key-value lookups — both are O(1) vs array's O(n).

> Read `references/js-performance.md` for all 12 rules (js-batch-dom-css, js-index-maps, js-cache-property-access, js-cache-function-results, js-cache-storage, js-combine-iterations, js-length-check-first, js-early-exit, js-hoist-regexp, js-min-max-loop, js-set-map-lookups, js-tosorted-immutable).

---

### 8. Advanced Patterns — LOW

These patterns solve specific edge cases. Apply only when the simpler alternatives have been exhausted.

- **Event handler refs**: Store event handlers in refs when they need to be stable across renders without `useCallback` dependencies.
- **Init once**: Use module-level initialization for app-wide singletons (analytics, feature flags) to prevent re-initialization on HMR.
- **useLatest**: Keep a ref that always points to the current callback — useful for event listeners that outlive their render cycle.

> Read `references/advanced-patterns.md` for implementation details on all 3 patterns (advanced-event-handler-refs, advanced-init-once, advanced-use-latest).

---

## Output Format

When auditing existing code, report issues as:

```
[CATEGORY] [PRIORITY] rule-name
File: path/to/file.tsx:line
Issue: What the current code does wrong
Fix: What to change and why it matters
```

When writing new code, apply the applicable rules silently and note any trade-offs made.

## Quality Checklist

- [ ] No sequential awaits where parallel fetching is possible
- [ ] No barrel file imports from large libraries
- [ ] Server Components don't pass unnecessary data to Client Components
- [ ] `React.cache()` used for functions called in multiple components per request
- [ ] No derived state computed in `useEffect` + `setState`
- [ ] Heavy client-only components use `next/dynamic`
- [ ] Static JSX objects hoisted out of render functions

## Common Antipatterns

- Putting `"use client"` at the top of a file "just to be safe" — pushes serialization costs to the client unnecessarily
- `useEffect(() => { setDerived(compute(value)) }, [value])` — compute during render instead
- `import { everything } from 'library'` — import specific files
- `const x = { key: 'value' }` inside render — hoist to module level if static

## References

- `references/server-performance.md` — 8 server-side rules
- `references/client-fetching.md` — 4 client-side data fetching rules
- `references/rerender-optimization.md` — 12 re-render optimization rules
- `references/rendering-performance.md` — 9 browser rendering rules
- `references/js-performance.md` — 12 JavaScript micro-optimization rules
- `references/advanced-patterns.md` — 3 advanced React patterns


## See Also
- `vercel-composition-patterns` — Para patterns de composición React avanzados (compound components, CVA, React 19 APIs)
