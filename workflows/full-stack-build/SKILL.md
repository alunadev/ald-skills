---
name: full-stack-build
description: Multi-step workflow for building complete features end-to-end. Use when starting a new feature, building a side project from scratch, or coordinating multiple technical skills in sequence. Chains brainstorming → API design → database schema → React implementation → deployment with explicit gates between each step. Triggers on: /fullstack, "build feature end-to-end", "full stack feature", "new feature workflow".
---

# Full-Stack Build Workflow

Orchestrates a complete feature build by chaining specialized skills in sequence. Each step produces a documented output that the next step reads before proceeding. Do not skip steps.

## Skill Chain

```
brainstorming
    ↓
api-design-principles        [Gate: api.md must exist]
    ↓
supabase-postgres             [Gate: schema.md must exist]
    ↓
react-best-practices
+ vercel-composition-patterns [Gate: components/ must exist]
    ↓
deploying-to-github          [Gate: env vars + tracking verified]
```

---

## Step-by-Step Execution

### Phase 0 — Brainstorm

Before touching code, clarify:
1. One-sentence feature description (user, action, outcome)
2. Explicit non-goals (what this iteration does NOT do)
3. Success metric (what number changes if this works?)

Output: `docs/features/YYYY-MM-DD-[feature]/implementation-notes.md` (header section)

---

### Phase 1 — API Design

Load skill: `api-design-principles`

Define all endpoints or server actions for this feature before writing any implementation:
- Resource names (plural nouns)
- HTTP methods and paths
- Request/response TypeScript types
- Error codes as string constants
- Auth requirements per endpoint

**Gate:** `docs/features/YYYY-MM-DD-[feature]/api.md` must exist and be reviewed before proceeding to Phase 2.

---

### Phase 2 — Database Schema

Load skill: `supabase-postgres`

Design tables, constraints, indexes, and RLS policies:
- UUID primary keys with `gen_random_uuid()`
- RLS enabled on every table
- Index on every foreign key
- `TIMESTAMPTZ` for all timestamps
- Named RLS policies following `"[table]: users [action] own rows"` pattern

**Gate:** `docs/features/YYYY-MM-DD-[feature]/schema.md` must exist and Supabase migration must be applied before proceeding to Phase 3.

---

### Phase 3 — Frontend Implementation

Load skills: `react-best-practices` + `vercel-composition-patterns`

Build UI in this order:
1. TypeScript types matching API response shapes
2. Server component (fetch + layout)
3. Client components (interactions only)
4. Loading states (Suspense or `loading.tsx`)
5. Error states (user-visible, never silent)
6. Form validation (Zod on client + server)

**Gate:** All components type-check, loading and error states exist for every async operation.

---

### Phase 4 — Deploy

Load skill: `deploying-to-github` (if available) or follow checklist:

- [ ] All env vars added to Vercel project settings
- [ ] `.env.example` updated (keys only, no values)
- [ ] Feature flag added if gradual rollout needed
- [ ] Tracking event fires on primary user action
- [ ] Error monitoring capturing new code paths
- [ ] `implementation-notes.md` updated with post-build observations

---

## Output Artifacts

```
docs/features/YYYY-MM-DD-[feature-name]/
├── api.md                   # Phase 1 output
├── schema.md                # Phase 2 output
└── implementation-notes.md  # Phase 0 + Phase 4 output
```

## Gates Summary

| Gate | Condition to pass |
|------|-------------------|
| Phase 0 → Phase 1 | Feature scope + non-goals written |
| Phase 1 → Phase 2 | `api.md` reviewed and approved |
| Phase 2 → Phase 3 | `schema.md` complete, migration applied |
| Phase 3 → Phase 4 | All components type-check, loading/error states present |
| Phase 4 → Done | Tracking event verified, `implementation-notes.md` updated |

## See Also

- `building-fullstack-features` — The detailed single-skill version of this workflow
- `api-design-principles` — REST and GraphQL API conventions
- `supabase-postgres` — Database schema, RLS, and query optimization
- `react-best-practices` — React and Next.js performance patterns
- `vercel-composition-patterns` — Component architecture patterns
- `product-launch` — Go-to-market checklist after the feature ships
