# Interview Protocol

This protocol adapts Matt Pocock's `grill-me` discipline (Skills for Real Engineers,
[github.com/mattpocock/skills](https://github.com/mattpocock/skills), MIT license) to the specific
job of filling in a canonical docs set. The mechanics are his; the branches are ours.

Read this file once per invocation, before asking the first question.

## The core discipline (do not water this down)

1. **Build the decision tree silently first.** Before asking anything, read whatever already
   exists — the target repo's code, README, existing partial docs, prior conversation context.
   Every question you're about to ask should be one that *can't* already be answered from what
   you can see. If the codebase already tells you the framework version, don't ask — state it and
   ask for confirmation instead of asking from scratch.

2. **One question at a time.** Never dump a list of 10 questions in one message. Each answer
   should inform the next question. This is slower per question but faster overall, because the
   user is never asked to hold five open threads in their head at once.

3. **Always pair the question with a recommended answer.** Every question ends with your best
   default, stated plainly: "Recommended: X, because Y." This is not optional — a question without
   a recommendation is half a question. The user should be able to reply "yes" and move on, or
   correct you and move on. Both are fast. An open-ended question with no anchor is slow.
   - If a multiple-choice question UI is available in this environment, use it and put your
     recommendation as the first option.
   - If not, ask in plain text and state the recommendation inline.

4. **Exhaust one branch before opening the next.** A "branch" here is one canonical doc (PRD, App
   Flow, Design System, Tech Stack, Backend Structure, Implementation Plan) or one context file
   (product-context, team-context, user-personas). Do not jump from a tech-stack question to a
   design-system question and back — finish the doc you're on, write it, then move to the next.
   See "Branch order" below for the sequence.

5. **Push back on weak answers, don't just transcribe them.** If the user says "just use whatever
   is standard" or "I don't care, you decide," that is not the same as "I've thought about it and
   any option works." Restate your recommendation as a concrete, specific choice and ask them to
   confirm or override it — don't silently write "standard stack" into a file that's supposed to
   eliminate ambiguity. The whole point of these docs is that nothing in them is vague. If the
   user pushes back a second time with the same non-answer, that's a real signal — stop pressing
   and log it as an open question (see below) rather than turning this into an interrogation.

6. **A genuine "I don't know yet" is a valid answer — mark it, don't fake it.** Some things really
   aren't decided yet (e.g., payments provider before there's revenue). When the user says so
   explicitly, write `[FILL IN — open question, revisit when: <condition>]` in the doc's Open
   Questions section instead of inventing a placeholder value. Never leave a bare `[FILL IN]` in a
   file you present as finished — every remaining gap must be an explicit, labeled open question,
   not silence.

7. **Resolve and close each branch.** After a doc's questions are exhausted, write the file, then
   give a 2-4 line summary: what was confirmed, what was marked open. Ask "Look right so far?"
   before moving to the next branch. Don't wait until the very end to show anything — that's how
   users lose track of 40 minutes of answers.

## When this protocol runs

This is a deliberate, heavyweight tool — it commits real time from the user. Only run it when they
have clearly asked for it: they named the skill/workflow, invoked `/canonical-docs`, said
something like "quiero documentar este proyecto en canonical docs" / "grill me on the canonical
docs" / "vamos a precisar los docs de \<producto\>", or they're starting a brand-new product and
ask what canonical docs are needed. Do not auto-fire this on a vague "build me an app" — that's
`brainstorming`'s or `idea-validator`'s job. If someone asks for a lighter one-shot version, offer
the abbreviated interview (see SKILL.md's "Fast mode") instead of forcing the full grill.

## New project vs. existing project

Before starting the branch order, determine which situation you're in — this changes what you
read in step 1, not the discipline itself:

- **Greenfield** (no canonical docs exist yet): copy the template set from `resources/templates/`
  into the target location first (see SKILL.md for exact paths), then interview branch by branch,
  filling every file from scratch.
- **Existing / partial** (some canonical docs, or the lighter `context/*.md` + `CLAUDE.md` +
  `progress.txt` set, already exist — e.g. an `ald-system/products/<name>/` folder that's
  graduating from notes to a real build): read every existing file fully before asking anything.
  Never re-ask what's already answered in a file — surface it back ("I see the North Star is
  already set to X in product-context.md — still accurate?") instead of asking blind. Only
  interview for what's genuinely missing or stale. This is the "precisar un proyecto en curso"
  case — the goal is closing gaps, not starting over.

## Branch order

Ask about branches in this order. Each branch corresponds to one output file (or file group).
Rationale: constraints and vision first (cheap, orients everything downstream), then what we're
building, then how a user experiences it, then how it looks, then how it's built, then in what
order.

1. **Team & constraints** → `context/team-context.md` — who's involved, ways of working, hard
   technical constraints. Quick; keeps later questions grounded in reality (e.g., no point
   designing a multi-tenant backend for a single-user tool).
2. **Product context & personas** → `context/product-context.md` + `context/user-personas.md` —
   vision, North Star, who this is for.
3. **PRD** → `docs/product/prd.md` — problem, target user, success metrics, scope in/out,
   behavior contracts, rollout.
4. **App Flow** → `docs/product/app-flow.md` — navigation tree, core user flows, auth flow,
   error/edge states, key routes.
5. **Design System** → `docs/design-system/design-system.md` — color/type/spacing tokens,
   component inventory, visual style, accessibility target.
6. **Tech Stack** → `docs/system/tech-stack.md` — every layer of the stack, pinned versions,
   architecture decisions, env vars, deployment model.
7. **Backend Structure** → `docs/system/backend-structure.md` — schema, auth/authz, API
   contracts, storage rules, edge cases, background jobs.
8. **Implementation Plan** → `docs/system/implementation-plan.md` — phases, gates, risks. This
   branch is intentionally light here — hand off to the `planning` skill for the atomic,
   commit-sized breakdown once phases are agreed.

Question content for each branch lives in `references/question-bank.md` — read the relevant
section when you reach that branch, not all of it upfront.

## Closing the whole interview

After all branches are resolved (or explicitly deferred):

1. Write/update `progress.txt` — set "Last Session" to this setup session, "Active Task" to
   whatever the user says comes next, and copy every open question from every doc into
   "Blockers" so they're visible in one place.
2. Write/update `CLAUDE.md` (or `CLAUDE.template.md` → `CLAUDE.md`) with the confirmed tech stack,
   conventions, and current focus.
3. Give one final summary: list every doc written, one line per doc on what's confirmed, and a
   consolidated list of every open question across all docs (not buried per-file). Recommend the
   next skill: `planning` if the Implementation Plan phases are ready to atomize, `brainstorming`
   if a specific design decision still needs exploring, or nothing further if the user just wanted
   the docs in place.
