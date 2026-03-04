# Client-Side Data Fetching Rules

Source: Vercel Engineering / vercel-labs agent-skills

These rules apply to data fetching and browser API usage in Client Components (`"use client"`).

---

## client-swr-dedup

Use `useSWR` (or React Query) for client-side data fetching to get automatic request deduplication, revalidation on focus, and optimistic updates for free.

```tsx
import useSWR from 'swr';

function UserProfile({ id }: { id: string }) {
  const { data, error, isLoading } = useSWR(`/api/users/${id}`, fetcher);

  if (isLoading) return <Skeleton />;
  if (error) return <ErrorState />;
  return <Profile user={data} />;
}
```

Why: Multiple components mounting simultaneously with the same `useEffect + fetch` pattern will make duplicate network requests. SWR deduplicates concurrent requests for the same key — only one network call fires regardless of how many components request the same data.

---

## client-event-listeners

Deduplicate global event listeners by registering them once at the app level, not inside individual components. Components that add the same listener type independently create N listeners for N instances.

```tsx
// Bad — adds a listener per component instance:
function Tooltip({ id }: { id: string }) {
  useEffect(() => {
    document.addEventListener('keydown', handleKeyDown);
    return () => document.removeEventListener('keydown', handleKeyDown);
  }, []);
}

// Good — one listener at the app level dispatches to subscribers:
// Use a global event bus or context to coordinate listener registration
```

Why: Each `addEventListener` call without deduplication adds processing overhead per event. 20 Tooltip components = 20 `keydown` handlers firing for every keystroke.

---

## client-passive-event-listeners

Add `{ passive: true }` to scroll, touch, and wheel event listeners. Passive listeners tell the browser it doesn't need to wait for `preventDefault()` — enabling smooth scrolling optimization.

```tsx
useEffect(() => {
  const handler = (e: TouchEvent) => {
    // handle touch
  };

  element.addEventListener('touchstart', handler, { passive: true });
  return () => element.removeEventListener('touchstart', handler);
}, []);
```

Why: Browsers must wait for non-passive listeners to determine if `preventDefault()` was called before proceeding with scrolling. This creates scroll jank. Passive listeners allow the browser to scroll immediately while your handler runs asynchronously.

---

## client-localstorage-schema

Version your localStorage data and minimize what you store. Unversioned localStorage breaks silently when your data shape changes; bloated localStorage slows parse time on every page load.

```tsx
const STORAGE_KEY = 'app_prefs_v2'; // increment version when schema changes

interface AppPrefs {
  theme: 'light' | 'dark';
  density: 'compact' | 'comfortable';
}

function loadPrefs(): AppPrefs {
  try {
    const raw = localStorage.getItem(STORAGE_KEY);
    if (!raw) return DEFAULT_PREFS;
    return JSON.parse(raw) as AppPrefs;
  } catch {
    return DEFAULT_PREFS; // handle parse failures gracefully
  }
}
```

Why: When you change the shape of stored data without versioning, old data gets interpreted with a new schema — causing runtime errors or silent incorrect behavior. Version keys make migrations explicit.
