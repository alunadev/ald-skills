---
name: building-fullstack-features
description: Guides end-to-end implementation of features in side projects, from design decision to deployment. Use when building a new feature from scratch, connecting frontend to backend, setting up a new side project architecture, or following a complete implementation checklist. Triggers on: "build this feature", "implement end-to-end", "new feature from scratch", "set up project structure", "ship this". Covers the Next.js 15 + React 19 + Supabase + Vercel stack.
---

# Building Fullstack Features

## Core Philosophy

Ship end-to-end, then iterate. A half-built feature is a bug waiting to happen — it creates confused state between the DB, API, and UI that takes longer to debug than building it right from the start.

Define the contract before writing a single line of code. The order is: **scope → API contract → DB schema → frontend → deploy**. Never skip to UI before the API is defined.

---

## Workflow

### Step 1 — Feature Scope

Write one sentence that answers: what does this feature do, who uses it, and what problem does it solve?

```
Feature: [Name]
Sentence: [User] can [action] so that [outcome].
```

Then list explicit non-goals — features that sound related but are out of scope for this iteration. Non-goals prevent scope creep during implementation.

Output: annotate the sentence + non-goals at the top of your implementation doc.

---

### Step 2 — API Contract (before writing code)

Define every endpoint or server action before implementing any of them:

```typescript
// Resource: [resource name]
// Base: /api/[resource]

POST   /api/[resource]          // Create
GET    /api/[resource]          // List (cursor-based pagination)
GET    /api/[resource]/:id      // Get one
PATCH  /api/[resource]/:id      // Update (partial)
DELETE /api/[resource]/:id      // Soft delete
```

For each endpoint, document:
- **Request body**: TypeScript type
- **Response (success)**: type + status code
- **Response (error)**: `{ error: string, code: string, message: string }`
- **Auth requirement**: public / authenticated / role-scoped

Define error codes as string constants, not raw HTTP codes. `RESOURCE_NOT_FOUND` is more useful than `404` in client error handling.

Output: `docs/features/YYYY-MM-DD-[feature-name]/api.md`

---

### Step 3 — Database Schema

Design tables before writing any SQL migration:

```sql
-- [table_name]
CREATE TABLE [table_name] (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id     UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  [fields]    [types] NOT NULL,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Indexes
CREATE INDEX idx_[table]_user_id ON [table_name](user_id);
CREATE INDEX idx_[table]_created_at ON [table_name](created_at DESC);

-- RLS
ALTER TABLE [table_name] ENABLE ROW LEVEL SECURITY;

CREATE POLICY "[table]: users read own rows"
  ON [table_name] FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "[table]: users insert own rows"
  ON [table_name] FOR INSERT
  WITH CHECK (auth.uid() = user_id);
```

Rules to follow:
- Enable RLS on every table — skipping this is a security vulnerability, not a shortcut
- Index every foreign key column — Postgres does not do this automatically
- Use `TIMESTAMPTZ`, not `TIMESTAMP` — timezone-aware by default
- Add a `NOT NULL` constraint unless `NULL` has explicit semantic meaning for that field

Output: `docs/features/YYYY-MM-DD-[feature-name]/schema.md`

---

### Step 4 — Frontend Implementation

Implement UI in this order: data shape → server component → client component → loading state → error state.

**Data shape first:**
```typescript
// types/[feature].ts
export interface FeatureItem {
  id: string
  userId: string
  // ...fields from schema
  createdAt: string
}
```

**Server component (fetch + layout):**
```typescript
// app/[route]/page.tsx
export default async function FeaturePage() {
  const data = await getFeatureItems() // server-side fetch
  return <FeatureList items={data} />
}
```

**Client component (interactions):**
```typescript
"use client"
// Only interactive parts need "use client"
// Keep server boundary as high as possible
```

**Loading state:** Every fetch must have a `loading.tsx` or `Suspense` fallback.

**Error state:** Every mutation must have explicit error handling shown to the user — no silent failures.

**Form validation:** Use Zod schema on both client (for UX) and server (for security):
```typescript
const schema = z.object({ field: z.string().min(1) })
// Validate on client with react-hook-form + zodResolver
// Re-validate on server action before DB write
```

Output: components in `components/[feature]/`, hooks in `hooks/use-[feature].ts`

---

### Step 5 — Deploy & Monitor

Before pushing to production:

**Environment variables checklist:**
- [ ] All new env vars added to Vercel project settings
- [ ] Local `.env.local` updated
- [ ] `.env.example` updated with key names (not values)

**Feature flag (if gradual rollout):**
```typescript
// lib/flags.ts
export const FEATURE_FLAGS = {
  newFeature: process.env.NEXT_PUBLIC_FF_NEW_FEATURE === 'true'
}
```

**First metric:** Define what success looks like in numbers before launch. Example: "This feature succeeds if 30% of active users use it within 7 days." Add the tracking event:
```typescript
// Track the primary action
analytics.track('feature_action_completed', { userId, featureId })
```

**Error tracking:** Verify errors in the new code paths are captured by your error monitoring (Sentry, etc.).

Output: `docs/features/YYYY-MM-DD-[feature-name]/implementation-notes.md`

---

## Tech Stack Reference

| Layer | Technology |
|-------|-----------|
| Framework | Next.js 15 (App Router) |
| UI | React 19 + TypeScript |
| Styling | Tailwind CSS v4 + shadcn/ui |
| Database | Supabase (Postgres + Auth + Realtime) |
| Deployment | Vercel |
| Validation | Zod |
| Forms | react-hook-form |
| API client | SWR (client-side) |

---

## Output Artifacts

```
docs/features/YYYY-MM-DD-[feature-name]/
├── api.md               # Endpoint contracts, request/response types
├── schema.md            # DB tables, indexes, RLS policies
└── implementation-notes.md  # Decisions, gotchas, first metric
```

## Quality Checklist

- [ ] Feature scope defined in one sentence with explicit non-goals
- [ ] API contract documented before any implementation code
- [ ] All tables have RLS enabled
- [ ] All foreign key columns have an index
- [ ] Every fetch has a loading state; every mutation has an error state
- [ ] Zod validation on both client and server
- [ ] First metric and tracking event defined before launch
- [ ] Environment variables documented in `.env.example`

## Common Antipatterns

- **Building UI before API contract** — The UI ends up driving the DB shape instead of the domain model. Define the contract first.
- **Skipping RLS "for now"** — There is no "later" for security. Enable RLS in the migration that creates the table.
- **No loading/error states** — Users see blank screens. Every async operation needs a visual state for loading and failure.
- **Magic strings for error codes** — Use string constants. `SUBSCRIPTION_LIMIT_REACHED` is debuggable; `422` is not.

## See Also

- `api-design-principles` — For REST and GraphQL API design conventions
- `supabase-postgres` — For database schema, RLS, and query optimization
- `react-best-practices` — For React and Next.js performance patterns
- `vercel-composition-patterns` — For component architecture and React 19 patterns
- `product-launch` — For go-to-market checklist after the feature ships
