# Advanced React Patterns

Source: Vercel Engineering / vercel-labs agent-skills

These patterns solve specific edge cases that simpler approaches can't handle cleanly. Apply when you've exhausted `useCallback`, `useMemo`, and standard memoization.

---

## advanced-event-handler-refs

Store event handler functions in a ref when you need a stable function identity across renders but the handler references values that change frequently — avoiding both stale closures and `useCallback` dependency churn.

```tsx
function useEventHandlerRef<T extends (...args: unknown[]) => unknown>(handler: T) {
  const handlerRef = useRef<T>(handler);

  // Keep ref current without causing re-renders:
  useLayoutEffect(() => {
    handlerRef.current = handler;
  });

  // Return a stable function that delegates to the current handler:
  return useCallback((...args: Parameters<T>) => {
    return handlerRef.current(...args);
  }, []); // empty deps — the ref handles currency
}

// Usage:
const stableOnClick = useEventHandlerRef(onClick);
// stableOnClick is stable across renders, but always calls the latest onClick
```

When to use: event listeners registered via `addEventListener` that need to be stable (to avoid remove/re-add on every render) while still accessing the latest component state.

---

## advanced-init-once

Initialize app-wide singletons (analytics clients, feature flag SDKs, WebSocket connections) at module level with a guard, not inside components or effects. Ensures initialization happens exactly once per app lifetime, even with React Strict Mode double-invocation.

```ts
// analytics.ts — module-level singleton
let initialized = false;

export function initAnalytics() {
  if (initialized) return;
  initialized = true;
  Analytics.init({ apiKey: process.env.NEXT_PUBLIC_ANALYTICS_KEY });
}

// Call once in app entry:
// app/layout.tsx
initAnalytics();
```

Why `useEffect` isn't sufficient: React Strict Mode calls effects twice in development (mount → unmount → mount). A `useEffect`-based init that doesn't handle double-invocation will initialize twice, potentially duplicating events or creating race conditions.

---

## advanced-use-latest

Implement a `useLatest` hook to keep a ref that always points to the current value of a callback or variable. Solves the stale closure problem for callbacks passed to `addEventListener` or third-party libraries.

```tsx
function useLatest<T>(value: T): React.RefObject<T> {
  const ref = useRef<T>(value);

  useLayoutEffect(() => {
    ref.current = value;
  });

  return ref;
}

// Usage in a component:
function SearchInput({ onSearch }: { onSearch: (q: string) => void }) {
  const onSearchRef = useLatest(onSearch);

  useEffect(() => {
    const subscription = searchEvents.subscribe((query) => {
      onSearchRef.current(query); // always calls the latest onSearch
    });
    return () => subscription.unsubscribe();
  }, []); // no dependency on onSearch — useLatest handles currency
}
```

When to use: whenever you have a long-lived subscription (WebSocket, event bus, third-party observer) that needs to call a function from the component's closure, but you don't want the subscription to re-register every time the function reference changes.
