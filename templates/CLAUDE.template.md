# CLAUDE.md — [PROJECT NAME]

> This file tells Claude Code who I am, how I work, and what this project is.
> Copy this template to the root of each project and fill in the bracketed sections.
> Delete any section that doesn't apply.

---

## Project Identity

**What it does:** [One sentence. E.g. "A task management app for freelancers that syncs with Google Calendar."]
**Who uses it:** [Target user. E.g. "Solo freelancers managing multiple clients."]
**Stage:** [Idea / MVP / Beta / Production]
**North Star Metric:** [E.g. "Weekly active users who complete at least 3 tasks"]

---

## Tech Stack

```
Frontend:   Next.js 15 · React 19 · TypeScript · Tailwind CSS · shadcn/ui
Backend:    [Supabase / PlanetScale / Prisma + Postgres]
Auth:       [Supabase Auth / NextAuth / Clerk]
Payments:   [Stripe / Lemon Squeezy]
Deploy:     Vercel
Testing:    Vitest · Playwright (E2E)
```

---

## Active Skills

These skills are loaded for this project. Reference them explicitly when relevant.

```
@ald-skills/brainstorming          — Use before any new feature
@ald-skills/planning               — Use after design is approved
@ald-skills/prd-writer             — Use for any non-trivial feature spec
@ald-skills/brand-identity         — Use for any UI/copy work
@ald-skills/frontend-design        — Use for new components
@ald-skills/react-best-practices   — Use for all React code
@ald-skills/error-handling-patterns — Use when writing API calls
@ald-skills/systematic-debugging   — Use when something is broken
@ald-skills/codebase-documenter    — Use when updating docs
@ald-skills/changelog-generator    — Use before each release
```

---

## Code Conventions

### Naming
- Components: `PascalCase` (e.g. `UserProfileCard.tsx`)
- Functions/hooks: `camelCase` (e.g. `useUserProfile`)
- Constants: `SCREAMING_SNAKE_CASE` (e.g. `MAX_RETRY_COUNT`)
- Files: `kebab-case` (e.g. `user-profile-card.tsx`)
- DB tables: `snake_case` (e.g. `user_profiles`)

### Commits
- Language: English
- Format: imperative present tense (`Add`, `Fix`, `Update`, `Remove`)
- Scope: one concern per commit
- Branch naming: `feat/`, `fix/`, `chore/`, `docs/`

### TypeScript
- Strict mode always on
- No `any` — use `unknown` and narrow properly
- Prefer interfaces over types for objects
- Export types from `types/` directory

### Components
- One component per file
- Props interface defined at top of file
- No inline styles — Tailwind only
- shadcn/ui components before custom implementations

---

## Behavior Rules for Claude Code

### The Non-Negotiables

**Fix minimally.** When fixing a bug, change only what's needed to fix that bug. NEVER refactor unrelated code in the same commit.

**No evidence = not complete.** A task is done when tests pass and the code runs. Not when you've written it.

**Fight entropy.** Leave the codebase better than you found it — but only within the scope of the current task.

**One TODO at a time.** Mark a task `in_progress` before starting. Mark `completed` immediately after. Never batch completions.

**Before following patterns, assess them.** If you see conflicting patterns in the codebase, ask: "I see X and Y patterns. Which should I follow?"

### What to Do When Uncertain

Before writing code for an ambiguous request:
```
I notice [observation].
This might cause [problem] because [reason].
Alternative: [your suggestion].
Should I proceed with your original request, or try the alternative?
```

### What NOT to Do

- Don't add dependencies without asking
- Don't create files outside the established structure
- Don't write comments that explain WHAT the code does — only WHY
- Don't use `console.log` in production code (use the project's logger)
- Don't generate placeholder/lorem ipsum content in components

---

## Project Structure

```
/
├── app/                    # Next.js App Router
│   ├── (auth)/            # Auth-required routes
│   ├── (public)/          # Public routes
│   └── api/               # API routes
├── components/
│   ├── ui/                # shadcn/ui base components
│   └── [feature]/         # Feature-specific components
├── lib/
│   ├── db/                # Database client + queries
│   ├── auth/              # Auth utilities
│   └── utils.ts           # Shared utilities
├── types/                 # TypeScript type definitions
├── hooks/                 # Custom React hooks
├── docs/
│   ├── designs/           # Brainstorming outputs (YYYY-MM-DD-topic.md)
│   └── plans/             # Planning outputs (YYYY-MM-DD-topic-plan.md)
└── CLAUDE.md              # This file
```

---

## Environment Variables

```bash
# Required — do not proceed without these
NEXT_PUBLIC_SUPABASE_URL=
NEXT_PUBLIC_SUPABASE_ANON_KEY=
SUPABASE_SERVICE_ROLE_KEY=

# Optional features
STRIPE_SECRET_KEY=
STRIPE_WEBHOOK_SECRET=
```

Never log env vars. Never commit `.env.local`.

---

## Testing

```bash
# Unit tests
npm run test

# E2E tests
npm run test:e2e

# Type check
npm run typecheck

# Lint
npm run lint
```

**Rule:** Run `npm run typecheck && npm run lint` before marking any task complete.

---

## Current Focus

> Update this section weekly.

**This week:** [What you're building right now]
**Blocked on:** [Any blockers]
**Next up:** [What comes after]

---

## Context for AI

Things Claude should know about how I work:

- I'm a Senior PM — explain trade-offs, not just solutions
- When in doubt between two approaches, show both and state your recommendation
- I prefer small, atomic PRs over large feature branches
- If something will take >2h to implement, flag it before starting
- I use the brainstorming skill before any significant new feature — don't skip it
