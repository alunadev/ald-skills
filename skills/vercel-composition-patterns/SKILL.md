---
name: applying-composition-patterns
description: Applies React composition patterns to build flexible, maintainable components. Use this skill when refactoring components that have accumulated too many boolean props, designing a reusable component API from scratch, building compound components (Tabs, Accordion, Select), working with context providers, or reviewing components that are hard to extend. Triggers on: "this component is getting hard to use", "too many props", "how do I make this reusable", "compound component", "component API design", "context pattern".
---

# Composition Patterns

Boolean props are a tax on the future. Every `isLoading`, `isDisabled`, `hasIcon`, `withBorder` prop you add makes a component harder to understand and impossible to extend without touching the component itself. Composition inverts this: instead of configuring everything through props, you compose behavior through structure.

These patterns come from Vercel Engineering's production experience with large React codebases.

## When to use this skill

- A component has grown beyond 5-6 boolean/variant props
- You need to share a component across contexts that have different internal layouts
- You're reaching for render props to customize internals
- A context provider is leaking implementation details into its consumers
- You're about to add `forwardRef` — consider React 19's ref-as-prop first

## Workflow

1. **Identify the prop smell** — list all boolean/variant props; any prop that controls rendering of a sub-part is a composition candidate
2. **Define the compound structure** — which pieces are independently composable?
3. **Extract internal state to context** — the parent manages state; children consume it
4. **Define explicit variants with CVA** — replace boolean prop combinations with named variants
5. **Verify** — the new API should read like prose and require no boolean combinatorics

---

## Component Architecture

### Avoid Boolean Props

Replace `isDisabled`, `hasIcon`, `withBorder` boolean prop combinations with explicit named variants using CVA (Class Variance Authority). Boolean props multiply: 3 booleans = 8 possible states.

```tsx
import { cva } from 'class-variance-authority';

const button = cva('base-styles', {
  variants: {
    intent: {
      primary: 'bg-blue-500 text-white',
      secondary: 'bg-gray-100 text-gray-900',
      destructive: 'bg-red-500 text-white',
    },
    size: {
      sm: 'px-3 py-1 text-sm',
      md: 'px-4 py-2 text-base',
      lg: 'px-6 py-3 text-lg',
    },
  },
  defaultVariants: { intent: 'primary', size: 'md' },
});

// Instead of: <Button isPrimary isLarge hasDestructiveStyle />
// Write: <Button intent="destructive" size="lg" />
```

### Compound Components

When a component's internals need to be independently positioned or extended, split it into a parent + named sub-components sharing state via context.

```tsx
// Instead of: <Tabs items={items} activeIndex={idx} onTabClick={fn} renderContent={fn} />

// Compound API:
<Tabs defaultValue="account">
  <Tabs.List>
    <Tabs.Trigger value="account">Account</Tabs.Trigger>
    <Tabs.Trigger value="security">Security</Tabs.Trigger>
  </Tabs.List>
  <Tabs.Content value="account"><AccountForm /></Tabs.Content>
  <Tabs.Content value="security"><SecurityForm /></Tabs.Content>
</Tabs>
```

The parent manages the active state via context. Children read from it. No prop drilling, no render props.

---

## State Management Patterns

### Decouple Implementation from Interface

Expose a clean context interface — functions and values the consumer needs — without leaking the internal state shape. Consumers shouldn't need to know how state is managed internally.

```tsx
// Bad — exposes internal dispatch:
const { state, dispatch } = useTabsContext();
dispatch({ type: 'SET_ACTIVE', payload: 'account' });

// Good — exposes intent:
const { activeTab, setActiveTab } = useTabsContext();
setActiveTab('account');
```

### Context as Interface, Not State Dump

Put only what consumers need in context. Putting your entire state object in context means any state change re-renders all consumers, even unrelated ones.

```tsx
// Split into targeted contexts:
const TabsActiveContext = createContext<string>('');
const TabsSetterContext = createContext<(val: string) => void>(() => {});

// Components that only read value don't re-render when setter changes
```

### Lift State to the Right Level

State belongs at the lowest common ancestor of the components that need it — no higher. State lifted too high causes unnecessary re-renders across the tree.

---

## Implementation Patterns

### Explicit Variants with CVA

Use `cva()` from `class-variance-authority` to define component variants with compile-time type safety. The `VariantProps` helper ensures consumers can only use defined variant combinations.

```tsx
import { cva, type VariantProps } from 'class-variance-authority';

const card = cva('rounded border', {
  variants: {
    padding: { compact: 'p-3', comfortable: 'p-6' },
    elevation: { flat: '', raised: 'shadow-md' },
  },
  compoundVariants: [
    { padding: 'compact', elevation: 'raised', class: 'shadow-sm' },
  ],
});

interface CardProps extends VariantProps<typeof card> {
  children: React.ReactNode;
}
```

### Children Over Render Props

Prefer `children` composition over render props for injecting content into specific slots. Render props are harder to read and require more boilerplate.

```tsx
// Prefer:
<Card>
  <Card.Header>Title</Card.Header>
  <Card.Body>Content</Card.Body>
</Card>

// Over:
<Card
  renderHeader={() => <span>Title</span>}
  renderBody={() => <div>Content</div>}
/>
```

---

## React 19 APIs

### No forwardRef

In React 19, `ref` is a regular prop. Remove `forwardRef` wrappers — they add noise and a wrapping function call that serves no purpose in React 19+.

```tsx
// React 18 — required forwardRef:
const Input = forwardRef<HTMLInputElement, InputProps>((props, ref) => (
  <input {...props} ref={ref} />
));

// React 19 — ref is a prop:
function Input({ ref, ...props }: InputProps & { ref?: React.Ref<HTMLInputElement> }) {
  return <input {...props} ref={ref} />;
}
```

Check your Next.js version — this is available in Next.js 15 with React 19.

### use() Instead of useContext

Use the `use()` hook for reading context in React 19+. Unlike `useContext`, `use()` can be called conditionally and inside loops.

```tsx
// React 18:
const theme = useContext(ThemeContext);

// React 19:
const theme = use(ThemeContext);

// use() can be conditional:
if (needsTheme) {
  const theme = use(ThemeContext);
}
```

---

## Quality Checklist

- [ ] No component has more than 4 boolean/behavior props (variant props excepted)
- [ ] Shared state between sibling components goes through context, not prop drilling
- [ ] Compound components expose a readable, prose-like API at the call site
- [ ] CVA variants are exhaustive — no ad-hoc className string manipulation
- [ ] `forwardRef` only used if targeting React < 19
- [ ] Context values contain only what consumers need — no full state objects

## Common Antipatterns

- Adding `if (props.variant === 'primary' && props.isLarge && props.hasIcon)` to a render function
- Passing `renderHeader={...}` when `<Component.Header>` would read more clearly
- Putting the entire reducer state in a single context
- Using `useContext` inside deeply nested components that only need one field from a large context

## See Also

- `react-best-practices` — For rendering, bundle, and server-side performance patterns
- `tailwind-design-system` — For CVA integration with Tailwind v4 design tokens
