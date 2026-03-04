# Re-render Optimization Rules

Source: Vercel Engineering / vercel-labs agent-skills

These rules reduce unnecessary re-renders in React components. A re-render isn't free — it runs the component function, reconciles the virtual DOM, and potentially triggers child re-renders. Minimize them in hot paths.

---

## rerender-defer-reads

Defer reading from state or context until the value is actually needed. Reading early in a component body creates a reactive dependency even if the value isn't used in rendering.

```tsx
// Bad — reads context at component top, re-renders on every context change:
function Item({ id }: { id: string }) {
  const store = useStore();
  if (!shouldRender) return null;
  return <div>{store.getValue(id)}</div>;
}

// Good — defer the read until it's needed:
function Item({ id }: { id: string }) {
  if (!shouldRender) return null;
  const store = useStore();
  return <div>{store.getValue(id)}</div>;
}
```

---

## rerender-memo

Wrap components with `React.memo` when they receive stable props but render inside a parent that re-renders frequently. Without memoization, every parent re-render triggers all children.

```tsx
const ExpensiveItem = React.memo(({ item }: { item: Item }) => {
  return <div>{item.name}</div>;
});
```

Only memoize when you've confirmed the re-renders are actually happening — don't pre-optimize.

---

## rerender-memo-with-default-value

When a memoized component receives a prop that might be `undefined`, provide a stable default value to prevent unnecessary re-renders caused by `undefined → value` transitions.

```tsx
const DEFAULT_STYLES = {}; // stable reference, created once

const Card = React.memo(({ styles = DEFAULT_STYLES }: { styles?: CSSProperties }) => {
  return <div style={styles}>...</div>;
});
```

Why: Without a stable default, `styles={undefined}` in one render and `styles={{}}` in another will always be different references — defeating memoization.

---

## rerender-dependencies

Keep `useEffect`, `useMemo`, and `useCallback` dependency arrays minimal and accurate. Listing more dependencies than needed causes excess re-runs; listing fewer causes stale closures.

```tsx
// If you only need `id` from `user`, depend on `user.id`, not `user`:
useEffect(() => {
  fetchData(user.id);
}, [user.id]); // not [user]
```

---

## rerender-derived-state

Compute derived values during render rather than storing them in state. State triggers re-renders; derived values computed from existing state are free.

```tsx
// Bad — derived state in useState causes double renders:
const [items, setItems] = useState([]);
const [sortedItems, setSortedItems] = useState([]);
useEffect(() => {
  setSortedItems([...items].sort(compare));
}, [items]);

// Good — compute during render:
const [items, setItems] = useState([]);
const sortedItems = [...items].sort(compare); // or useMemo for expensive sorts
```

---

## rerender-derived-state-no-effect

Never use `useEffect` + `setState` to compute derived state. It causes an extra render cycle — render with stale derived value, then render again with updated derived value.

```tsx
// Bad — two render cycles:
const [fullName, setFullName] = useState('');
useEffect(() => {
  setFullName(`${firstName} ${lastName}`);
}, [firstName, lastName]);

// Good — computed inline:
const fullName = `${firstName} ${lastName}`;
```

---

## rerender-functional-setstate

When new state depends on previous state, use the functional updater form to avoid stale closure bugs. This guarantees you're always working with the most recent state value.

```tsx
// Bad — can read stale count in concurrent mode:
setCount(count + 1);

// Good — always reads current state:
setCount(prev => prev + 1);
```

---

## rerender-lazy-state-init

For expensive initial state computation, pass a function to `useState` rather than calling the function directly. React only calls the initializer on the first render.

```tsx
// Bad — computeExpensive() runs on every render:
const [state, setState] = useState(computeExpensive());

// Good — computeExpensive() runs once:
const [state, setState] = useState(() => computeExpensive());
```

---

## rerender-simple-expression-in-memo

Don't use `useMemo` for simple expressions — the overhead of memoization (storing previous args, comparison) exceeds the cost of recomputing a simple value.

```tsx
// Unnecessary — string concatenation is trivial:
const label = useMemo(() => `${first} ${last}`, [first, last]);

// Just compute it:
const label = `${first} ${last}`;
```

Reserve `useMemo` for operations that are measurably expensive: sorting large arrays, filtering datasets, complex object transformations.

---

## rerender-move-effect-to-event

If an effect runs in response to a user action (click, submit, keypress), move that logic into the event handler instead of an effect. Effects are for synchronizing with external systems, not reacting to events.

```tsx
// Bad — effect triggered by state change from a button click:
const [clicked, setClicked] = useState(false);
useEffect(() => {
  if (clicked) { doSomething(); setClicked(false); }
}, [clicked]);

// Good — logic directly in the handler:
function handleClick() {
  doSomething();
}
```

---

## rerender-transitions

Use `useTransition` to mark non-urgent state updates so they don't block the UI. Urgent updates (typing, clicking) render immediately; deferred updates (filtering a large list) render when the browser is idle.

```tsx
const [isPending, startTransition] = useTransition();

function handleSearch(query: string) {
  startTransition(() => {
    setFilteredResults(expensiveFilter(allItems, query));
  });
}
```

---

## rerender-use-ref-transient-values

Use `useRef` for values that need to persist across renders but don't need to trigger re-renders — like timers, animation frames, previous values, or DOM measurements.

```tsx
const timerRef = useRef<ReturnType<typeof setTimeout> | null>(null);

function startTimer() {
  timerRef.current = setTimeout(() => { /* ... */ }, 1000);
}

function stopTimer() {
  if (timerRef.current) clearTimeout(timerRef.current);
}
```
