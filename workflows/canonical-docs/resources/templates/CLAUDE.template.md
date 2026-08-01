# [FILL IN: Project Name]

[FILL IN: One sentence — what this product does, who uses it, and what the core value is.]

## Project Identity

- **What it does**: [FILL IN]
- **Who uses it**: [FILL IN]
- **Stage**: [idea | MVP | growth | mature]
- **North Star Metric**: [FILL IN]

## Tech Stack

- **Frontend**: [FILL IN — see `docs/system/tech-stack.md` for full detail]
- **Backend**: [FILL IN]
- **Auth**: [FILL IN]
- **Payments**: [FILL IN]
- **Deploy**: [FILL IN]

## Active Skills

Load these skills when relevant (works with Claude Code, Codex, or any agent that reads
`SKILL.md` files):

- Brainstorming → `@[PATH_TO_ALD_SKILLS]/skills/brainstorming/SKILL.md`
- Planning → `@[PATH_TO_ALD_SKILLS]/skills/planning/SKILL.md`
- PRD Writer → `@[PATH_TO_ALD_SKILLS]/skills/prd-writer/SKILL.md`
- Debugging → `@[PATH_TO_ALD_SKILLS]/workflows/systematic-debugging/SKILL.md`

All available skills: `@[PATH_TO_ALD_SKILLS]/skills/README.md`

> Replace `[PATH_TO_ALD_SKILLS]` with the relative or absolute path to the `ald-skills` folder
> (submodule, plugin install, or cloned copy) on this machine.

## Product Context

Read these files for business context:
- `@context/product-context.md` — vision, North Star, strategic pillars, market
- `@context/team-context.md` — team structure, ways of working, constraints
- `@context/user-personas.md` — who we're building for

## Project Context

Read these files for full project context:
- `@docs/product/prd.md` — problem statement, success metrics, solution
- `@docs/product/app-flow.md` — navigation, user flows, routes
- `@docs/design-system/design-system.md` — tokens, components, visual style
- `@docs/system/tech-stack.md` — stack decisions and rationale
- `@docs/system/backend-structure.md` — schema, auth, API contracts, storage rules
- `@docs/system/implementation-plan.md` — build sequence and phase gates
- `@progress.txt` — current state, last decisions, blockers

## Code Conventions

**Naming:**
- Components: `PascalCase` (one per file)
- Functions/hooks: `camelCase`
- Files: `kebab-case`
- DB tables: `snake_case`
- Constants: `SCREAMING_SNAKE_CASE`

**Commits:** English, imperative tense (`Add`, `Fix`, `Update`, not `Added`, `Fixed`)

**TypeScript:** [FILL IN: strict mode? `any` policy? interface vs type?]

**Components:** [FILL IN: styling approach, one component per file, etc.]

## Behavior Rules for the Agent

**Non-negotiables:**
- Fix the minimum needed — don't refactor unrelated code
- No evidence (passing tests, working demo) = not complete
- One TODO at a time — finish before starting the next
- Run typecheck + lint before marking any task complete
- Flag tasks estimated >2h and break them down first

**What NOT to do:**
- No new dependencies without asking first
- No files created outside the project structure
- No console.log in production code
- No comments for self-evident code

## Current Focus

> Update this section every week. Keep it to 3-5 bullet points.

- [FILL IN: what you're building this week]
- [FILL IN: current blocker or decision pending]

Read `progress.txt` for detailed daily state.

## Testing

```bash
[FILL IN: unit test command]
[FILL IN: e2e test command]
[FILL IN: typecheck command]
[FILL IN: lint command]
```

Run typecheck + lint before marking any task complete.
