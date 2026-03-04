Activates the Full-Stack Build workflow for a feature.

Usage: /fullstack [feature name or brief description]

What it does:
1. Loads the full-stack-build workflow
2. Asks you to define feature scope in one sentence (user, action, outcome) and explicit non-goals
3. Runs through 4 phases: API design → DB schema → Frontend → Deploy
4. Gates between phases — does not proceed until each phase's output doc exists
5. Creates docs/features/YYYY-MM-DD-[feature]/ with api.md, schema.md, and implementation-notes.md

When to use:
- Starting a new feature from scratch on a side project
- When you want a systematic end-to-end build instead of jumping straight to code
- When you need to coordinate API + DB + React work in the right order

What NOT to use it for:
- Small bug fixes or UI tweaks (just fix them)
- Refactors that don't add new API surface (use react-best-practices directly)

Example: /fullstack user invite system
Example: /fullstack export data to CSV
Example: /fullstack onboarding checklist

Stack assumed: Next.js 15 + React 19 + TypeScript + Tailwind v4 + Supabase + Vercel
