---
name: building-tailwind-design-system
description: Builds production-ready design systems with Tailwind CSS v4 using CSS-first configuration, design tokens, CVA component variants, and native CSS animations. Use this skill when creating component libraries, implementing design tokens with @theme, setting up dark mode with @custom-variant, migrating from Tailwind v3 to v4, building type-safe component variants, or standardizing UI patterns across a codebase. Apply when you see tailwind.config.ts, @tailwind directives, or any Tailwind-related question — v4 changes the setup significantly.
---

# Tailwind Design System

Tailwind v4 is a rewrite. The config file is gone — everything moves to CSS. This isn't just an API change; it's a shift in mental model: design tokens live in your CSS, not a JavaScript object. The result is faster builds, better tree-shaking, and CSS-native patterns (custom properties, cascade layers, container queries) without workarounds.

## When to Use This Skill

- Starting a new project with Tailwind CSS
- Migrating from Tailwind v3 to v4
- Building a component library that needs type-safe variants
- Implementing a design token system
- Setting up dark mode that works with server-rendered apps

## Workflow

1. **Set up the CSS entry point** — `@import "tailwindcss"` and `@theme` block
2. **Define the token hierarchy** — Brand → Semantic → Component
3. **Configure dark mode** — `@custom-variant dark`
4. **Set up CVA** — for component variants
5. **Add the `cn()` utility** — for conditional class merging
6. **Define animations** — `@keyframes` inside `@theme`

---

## Core Setup: CSS-First Configuration

Tailwind v4 is configured entirely in CSS. There is no `tailwind.config.ts`.

```css
/* app/globals.css */
@import "tailwindcss";

@theme {
  /* Brand tokens */
  --color-brand-50: oklch(97% 0.01 250);
  --color-brand-500: oklch(55% 0.2 250);
  --color-brand-900: oklch(20% 0.1 250);

  /* Semantic tokens */
  --color-background: var(--color-neutral-50);
  --color-foreground: var(--color-neutral-950);
  --color-border: var(--color-neutral-200);
  --color-primary: var(--color-brand-500);
  --color-primary-foreground: white;

  /* Typography */
  --font-sans: 'Inter', ui-sans-serif, system-ui, sans-serif;
  --font-mono: 'JetBrains Mono', ui-monospace, monospace;

  /* Spacing scale */
  --spacing-4: 1rem;
  --spacing-8: 2rem;

  /* Radius */
  --radius-sm: 0.25rem;
  --radius-md: 0.5rem;
  --radius-lg: 0.75rem;
}
```

**Remove all of these** — they're v3 patterns:
- `tailwind.config.ts` / `tailwind.config.js`
- `@tailwind base; @tailwind components; @tailwind utilities;`
- `theme.extend` in a config file

---

## Design Token Hierarchy

Structure tokens in 3 layers. Upper layers reference lower layers; component tokens reference semantic tokens.

```
Brand tokens         → raw values
  --color-blue-500: oklch(55% 0.2 265);

Semantic tokens      → reference brand tokens
  --color-primary: var(--color-blue-500);
  --color-background: white;
  --color-foreground: var(--color-gray-900);

Component tokens     → reference semantic tokens
  --button-bg: var(--color-primary);
  --button-text: var(--color-primary-foreground);
```

Components use component tokens; never use brand tokens directly in components.

---

## OKLCH Colors

Use OKLCH (`oklch(L% C H)`) instead of hex codes for perceptually uniform color scales. OKLCH produces palettes where each step is visually equal distance apart, unlike hex-based palettes.

```css
@theme {
  /* Perceptually uniform blue scale: */
  --color-blue-50:  oklch(97% 0.01 265);
  --color-blue-100: oklch(93% 0.03 265);
  --color-blue-200: oklch(87% 0.06 265);
  --color-blue-300: oklch(78% 0.1  265);
  --color-blue-400: oklch(65% 0.15 265);
  --color-blue-500: oklch(55% 0.2  265);
  --color-blue-600: oklch(45% 0.18 265);
  --color-blue-700: oklch(37% 0.15 265);
  --color-blue-800: oklch(28% 0.1  265);
  --color-blue-900: oklch(20% 0.06 265);
  --color-blue-950: oklch(14% 0.04 265);
}
```

---

## Dark Mode with @custom-variant

Define dark mode using `@custom-variant` to support both system preference and manual toggle.

```css
/* Supports class-based dark mode: */
@custom-variant dark (&:where(.dark, .dark *));

/* Or system preference only: */
@custom-variant dark (@media (prefers-color-scheme: dark));
```

Then override semantic tokens in the dark context:

```css
.dark {
  --color-background: oklch(10% 0.01 250);
  --color-foreground: oklch(95% 0.01 250);
  --color-border: oklch(25% 0.02 250);
  --color-primary: oklch(65% 0.2 250); /* lighter for dark bg */
}
```

In components, use dark: variant:

```tsx
<div className="bg-background dark:bg-background text-foreground">
  Content
</div>
```

---

## CVA: Type-Safe Component Variants

Use `cva()` from `class-variance-authority` to define component variants with TypeScript type safety.

```tsx
import { cva, type VariantProps } from 'class-variance-authority';

const buttonVariants = cva(
  // base styles applied to all variants:
  'inline-flex items-center justify-center rounded-md font-medium transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-primary disabled:opacity-50',
  {
    variants: {
      variant: {
        default:   'bg-primary text-primary-foreground hover:bg-primary/90',
        secondary: 'bg-secondary text-secondary-foreground hover:bg-secondary/80',
        outline:   'border border-border bg-background hover:bg-accent',
        ghost:     'hover:bg-accent hover:text-accent-foreground',
        destructive: 'bg-destructive text-destructive-foreground hover:bg-destructive/90',
      },
      size: {
        sm: 'h-9 px-3 text-sm',
        md: 'h-10 px-4 text-base',
        lg: 'h-11 px-8 text-lg',
        icon: 'h-10 w-10',
      },
    },
    defaultVariants: {
      variant: 'default',
      size: 'md',
    },
  }
);

interface ButtonProps
  extends React.ButtonHTMLAttributes<HTMLButtonElement>,
    VariantProps<typeof buttonVariants> {
  asChild?: boolean;
}

export function Button({ variant, size, className, ...props }: ButtonProps) {
  return (
    <button
      className={cn(buttonVariants({ variant, size }), className)}
      {...props}
    />
  );
}
```

---

## cn() Utility

Set up the `cn()` utility for conditional class merging. It combines `clsx` (conditional classes) with `tailwind-merge` (deduplicates conflicting Tailwind classes).

```ts
// lib/utils.ts
import { clsx, type ClassValue } from 'clsx';
import { twMerge } from 'tailwind-merge';

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs));
}
```

```tsx
// Usage:
<div className={cn('base-class', isActive && 'active-class', className)}>
```

Without `tailwind-merge`, `cn('px-4', 'px-8')` would produce `px-4 px-8` (both classes). With it: `px-8` (the last one wins, correctly).

---

## Native CSS Animations

Define animations inside `@theme` using `@keyframes`. They become part of your design token system.

```css
@theme {
  --animate-fade-in: fade-in 200ms ease-out;
  --animate-slide-up: slide-up 300ms cubic-bezier(0.16, 1, 0.3, 1);
  --animate-spin: spin 1s linear infinite;
}

@keyframes fade-in {
  from { opacity: 0; }
  to   { opacity: 1; }
}

@keyframes slide-up {
  from { transform: translateY(8px); opacity: 0; }
  to   { transform: translateY(0);   opacity: 1; }
}
```

Use in components:

```tsx
<div className="animate-fade-in">Content</div>
```

---

## Container Queries

Tailwind v4 supports container queries natively. Define containers with `@container` and use `@container` breakpoints.

```css
/* In your component styles or globals: */
.card-wrapper {
  container-type: inline-size;
}
```

```tsx
<div className="card-wrapper">
  {/* Changes layout based on card-wrapper's width, not viewport */}
  <div className="grid grid-cols-1 @md:grid-cols-2 @lg:grid-cols-3">
    {items.map(item => <Card key={item.id} item={item} />)}
  </div>
</div>
```

---

## Quality Checklist

- [ ] No `tailwind.config.ts` — all configuration in CSS `@theme`
- [ ] No `@tailwind` directives — using `@import "tailwindcss"`
- [ ] Color tokens use OKLCH, not hex
- [ ] Dark mode via `@custom-variant dark` with semantic token overrides
- [ ] Component variants use CVA with `VariantProps` TypeScript types
- [ ] `cn()` utility uses `clsx` + `tailwind-merge`
- [ ] No arbitrary values (`[16px]`, `[#ff0000]`) — use tokens instead
- [ ] Animations defined as `@keyframes` inside `@theme`

## Common Antipatterns

- Using `tailwind.config.ts` for v4 — it's not read in v4
- `theme.extend.colors` — v4 uses `@theme` CSS block
- `style={{ color: '#ff0000' }}` for one-off colors — add a token instead
- Arbitrary `[value]` classes for values that will be reused — add to `@theme`
- `bg-blue-500` directly on components — use semantic token (`bg-primary`) so dark mode works
- Multiple conflicting classes without `cn()` — `px-4 px-8` is ambiguous without tailwind-merge

## See Also

- `vercel-composition-patterns` — For CVA integration with compound components and React 19 patterns
- `frontend-design` — For overall design direction and aesthetic decisions
- `brand-identity` — For brand color primitives that feed into your `@theme` token system
