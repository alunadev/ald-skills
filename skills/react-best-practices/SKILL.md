---
name: following-react-best-practices
description: React and Next.js performance optimization guidelines from Vercel Engineering. This skill should be used when writing, reviewing, or refactoring React/Next.js code to ensure optimal performance patterns. Triggers on tasks involving React components, Next.js pages, data fetching, bundle optimization, or performance improvements.
---

# React Best Practices

Comprehensive performance optimization guide for React and Next.js applications, covering bundle size, server-side performance, and rendering optimization.

## When to use this skill
- Writing new React components or Next.js pages.
- Implementing data fetching (client or server-side).
- Reviewing code for performance issues or refactoring existing code.
- Optimizing bundle size or load times.

## Workflow
1.  **Analyze Component Type**: Determine if it's a Server or Client component.
2.  **Optimize Data Fetching**: Eliminate waterfalls using parallel fetching or strategic Suspense boundaries.
3.  **Optimize Bundle Size**: Avoid barrel file imports and use dynamic imports for heavy components.
4.  **Refine Rendering**: Use memoization (`useMemo`, `useCallback`, `React.memo`) and minimize re-renders.
5.  **Verify Performance**: Check for hydration mismatches and efficient state management.

## Instructions

### 1. Eliminating Waterfalls
- **Defer Await**: Move `await` operations into the branches where they're actually used.
- **Parallel Fetching**: Use `Promise.all()` for independent operations.
- **Suspense Boundaries**: Use Suspense to show wrapper UI faster while data streams in.

### 2. Bundle Size Optimization
- **Direct Imports**: Avoid barrel files (e.g., `import { Button } from '@mui/material'`).
- **Dynamic Imports**: Use `next/dynamic` for heavy components not needed on initial render.
- **Conditional Loading**: Load large modules only when a feature is activated.

### 3. State & Rendering
- **Keep Components Small**: Single responsibility.
- **Memoization**: Memoize expensive calculations and callbacks.
- **Context API**: Use for global state, but avoid prop drilling.

## Resources
- `references/waterfall-elimination.md`
- `references/bundle-size-optimization.md`
- `references/server-performance.md`
