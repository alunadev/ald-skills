# Question Bank

Concrete questions per branch, with recommended defaults. Read only the section for the branch
you're currently on — don't load this whole file into your head at once. Adapt wording to the
conversation; don't read these verbatim as a form.

Every question below should be skipped if the answer is already visible in the codebase, an
existing doc, or something the user already said earlier in the conversation. Ask the ones that
are genuinely open.

## Table of Contents

1. Team & Constraints
2. Product Context & Personas
3. PRD
4. App Flow
5. Design System
6. Tech Stack
7. Backend Structure
8. Implementation Plan

---

## 1. Team & Constraints

- "Is this solo, or is there a team? Who owns product, tech, and design?"
  Recommended: solo (Adrian across all three) unless told otherwise.
- "Any hard technical constraint I should know before we go further? Mobile-first, must integrate
  with an existing system, must run on existing infra, a deadline?"
  Recommended: none stated — mark "no known constraints" rather than leaving it blank.
- "How do you want to work — ship fast and iterate, or get it right before shipping?"
  Recommended: ship fast, iterate (matches the Product Builder Loop: prototype → build → review →
  ship → learn).

## 2. Product Context & Personas

- "In one sentence: what does this do, and what's the ultimate future state if it works?"
  No default — this is the one question that must come from the user.
- "What's the North Star metric — the one number that means this is working?"
  Recommended: propose one based on the vision statement (e.g., "weekly active users completing
  the core action") and ask them to confirm or replace it.
- "Who is the primary user? Give me a specific segment, not 'everyone.'"
  Recommended: if this is a personal/internal tool, "Adrian himself" is a valid, specific answer —
  don't force an external-user framing where none exists.
- "Any secondary persona worth naming, or is one enough for now?"
  Recommended: one persona is enough at this stage; a second only if the product genuinely serves
  two distinct user types with different needs.
- "What's the market context — is this competing with existing tools, or filling a gap nothing
  else covers?"
  Recommended: skip this if it's a private/internal tool with no market dimension — say so
  explicitly rather than forcing a competitive-analysis answer.

## 3. PRD

- "What's the problem, concretely — what's broken or missing today, and how do you know it's
  real (not just assumed)?"
  No default — push for evidence (a metric, a repeated manual workaround, a specific frustration)
  rather than accepting "it would be nice to have."
- "What does success look like, numerically? Give me one primary metric with a target value."
  Recommended: derive a candidate from the North Star metric already captured in step 2 and
  propose it as the PRD's primary success metric.
- "What's explicitly IN scope for the first version?"
  No default — this must come from the user, but summarize back what you heard to confirm scope
  boundaries are unambiguous.
- "What's explicitly OUT of scope — the things you're deliberately not building yet?"
  Recommended: propose 2-3 plausible scope cuts based on what would make the first version take
  too long (e.g., "multi-user support," "payment processing," "mobile app") and ask which to
  formally exclude.
- "Any behavior contract that needs to be explicit — what happens on error, what happens on the
  empty state?"
  Recommended: flag the obvious ones (empty state, network error) and ask only about
  domain-specific edge cases the user would know and you wouldn't.
- "How does this roll out — straight to production, a feature flag, a staged percentage?"
  Recommended: for a solo/personal project, "no flag — build and ship directly" unless there's a
  real reason to stage it.

## 4. App Flow

- "What are the 2-4 main areas of the app — the top-level navigation?"
  Recommended: derive a starting tree from the PRD's in-scope features and confirm it.
- "Walk me through the primary flow — the one action this product exists to let someone do."
  No default — this is the flow the whole product hinges on; get the exact steps.
- "Is there a secondary flow worth documenting now, or is one enough at this stage?"
  Recommended: one primary flow is enough for a first PRD; add secondary flows only if they're
  genuinely different paths, not just variations of the same one.
- "How does auth work — is there a login at all? New user vs. returning user vs. no-auth access?"
  Recommended: for an internal/personal tool, "no auth — single user, no login" is a legitimate
  and simpler default; don't assume auth is needed just because most apps have it.
- "Any specific error state or empty state that needs a particular message, beyond the generic
  ones?"
  Recommended: generic network-error and first-time-empty-state copy is fine as a placeholder;
  only dig deeper if the user flags a state that needs special handling.

## 5. Design System

- "Do you already have brand colors / a visual identity, or are we defining one now?"
  Recommended: if a `brand-identity` or `design-system.json` already exists elsewhere in the
  user's system, read and reuse it instead of asking from scratch — say so and confirm.
- "Any existing component library preference, or default to what you already use?"
  Recommended: shadcn/ui + Tailwind, matching Adrian's established default stack — confirm rather
  than re-deriving from zero.
- "3-5 adjectives for the visual direction — how should this feel to use?"
  No default — this is a taste call only the user can make, though you can offer 2-3 candidate
  adjective sets based on the product's purpose as a starting point to react to.
- "Any accessibility requirement beyond standard WCAG AA?"
  Recommended: WCAG AA, 4.5:1 contrast minimum — the sensible default unless the product has a
  specific accessibility mandate (e.g., public sector, healthcare).

## 6. Tech Stack

- "Confirm the stack — is this still Next.js 15 / React 19 / TypeScript / Tailwind v4 /
  shadcn/ui / Vercel, or does this project need something different?"
  Recommended: yes, Adrian's established default stack, unless the project has a specific reason
  to deviate (e.g., a CLI tool, a Chrome extension, a non-web product).
- "Backend/DB — Supabase, or something else this time?"
  Recommended: Supabase (Postgres + Auth + Storage in one), Adrian's established default, unless
  there's a specific reason otherwise (e.g., needs a different auth provider, already has a DB).
- "Payments — Stripe, or none for this version?"
  Recommended: none, if the PRD's scope doesn't include monetization yet — don't add a payments
  dependency the PRD didn't ask for.
- "Error monitoring and analytics — same as your other projects, or skip for now?"
  Recommended: propose Adrian's usual choices if this is a recurring pattern across his products;
  otherwise mark as "add before first real users" open question rather than picking one blind.
- "Any architecture decision worth recording now — e.g., server components by default, a specific
  data-fetching pattern?"
  Recommended: server components as default (matches the standard Next.js 15 App Router
  approach) unless the project has a reason to lean client-heavy.

## 7. Backend Structure

- "What are the core entities/tables this product needs? Name them — we'll define columns next."
  No default — this comes directly from the PRD's scope; propose a first-pass table list based on
  what the PRD described and confirm before detailing columns.
- "For each table: what's the relationship to the others — one-to-many, many-to-many?"
  Recommended: infer the obvious relationships from the entity names (e.g., a `user` has many of
  most things) and confirm rather than asking blind per table.
- "Auth method and session strategy — same as the stack default, or different for this project?"
  Recommended: whatever was confirmed in Tech Stack (e.g., Supabase Auth, httpOnly cookies) —
  don't re-ask, just carry it forward and confirm it maps cleanly onto the schema.
- "Any row-level security / access rule beyond 'a user can only see their own data'?"
  Recommended: default to per-user row-level security (RLS) unless the product is explicitly
  multi-tenant or has shared/public data.
- "What are the API endpoints the frontend needs? Let's list them against the App Flow's screens."
  Recommended: derive a first-pass endpoint list directly from `docs/product/app-flow.md`'s key
  routes and flows, and confirm rather than starting from a blank page.
- "Any file/image upload involved? If so, where's it stored and what are the limits?"
  Recommended: if the PRD doesn't mention file uploads, mark storage as "none — no file storage
  needed" rather than asking about buckets that don't apply.
- "Any background job, scheduled task, or webhook this backend needs to handle?"
  Recommended: "none for v1" unless the PRD's scope implies one (e.g., a recurring digest, a
  third-party webhook).

## 8. Implementation Plan

- "How many phases make sense — thinking in terms of 'what has to exist before the next part is
  buildable,' not calendar time?"
  Recommended: propose a 3-phase default (Backend & Data Model → Frontend → Integration & Deploy)
  and adjust based on what the PRD/Backend Structure actually require.
- "What's the gate between each phase — the condition that must be true before moving on?"
  Recommended: propose one gate per phase (e.g., "schema migrated and API contract tests pass"
  before frontend starts) and confirm.
- "Any external dependency or risk that could block this — a third-party API, a design asset not
  ready yet, access to a service?"
  Recommended: none, unless something specific came up earlier in the interview (e.g., a payments
  provider not yet chosen) — cross-reference open questions from earlier branches rather than
  asking fresh.

Once phases are agreed, tell the user this file is intentionally light on task-level detail and
hand off to the `planning` skill for the atomic, TDD-focused breakdown — don't try to write
commit-sized tasks here yourself.
