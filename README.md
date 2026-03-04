# ALD Skills

A public library of reusable AI skills for Claude Code. Each skill is a markdown file with YAML frontmatter that Claude loads on demand — giving it specialized knowledge for product management, engineering, and content workflows.

Used as a submodule inside [ald-system](https://github.com/alunadev/ald-system), the personal AI configuration repo.

---

## Quick Start

### As a Git Submodule (Recommended)

```bash
# Add to your project
git submodule add https://github.com/alunadev/ald-skills.git ald_skills
git submodule update --init
```

Then reference in your project's `CLAUDE.md`:

```markdown
## Available Skills
@ald_skills/skills/GLOBAL_SKILLS.md
```

### Standalone Clone

```bash
git clone https://github.com/alunadev/ald-skills.git
```

Reference skills by path: `@ald_skills/skills/<name>/SKILL.md`

---

## Skills (31)

### Product Management

| Skill | Slash Command | Purpose |
|-------|--------------|---------|
| `user-discovery` | `/discovery` | Interview protocol, synthesis, Opportunity Statements |
| `product-strategy` | `/strategy` | North Star, Opportunity Tree, 3 bets, OKRs |
| `prd-writer` | `/prd` | Decision-focused PRDs with behavior contracts |
| `product-analytics` | `/metrics` | Metric tree, A/B design, tracking plan, HEART |
| `product-launch` | — | GTM brief, readiness checklists, rollout gates |
| `idea-validator` | — | Brutal honest validation before committing resources |
| `writing-system` | — | X threads, LinkedIn, blog, newsletter |
| `linkedin-viral-post-writer` | — | Hook system for high-performance LinkedIn content |

### Engineering & Development

| Skill | Purpose |
|-------|---------|
| `brainstorming` | Socratic discovery and technical design |
| `planning` | Atomic, TDD-focused implementation plans |
| `brand-identity` | Design tokens, tech stack, voice & tone |
| `frontend-design` | Production-grade frontend interfaces |
| `interface-design` | Dashboards, SaaS apps, admin panels |
| `react-best-practices` | Performance optimization, 8 categories, 58 rules |
| `vercel-composition-patterns` | Compound components, CVA variants, React 19 |
| `tailwind-design-system` | Tailwind v4, CSS-first @theme, OKLCH tokens |
| `stitch-skills` | Convert Stitch AI screens to production React |
| `web-design-guidelines` | 100+ accessibility, UX and code quality rules |
| `api-design-principles` | REST and GraphQL API design conventions |
| `supabase-postgres` | Indexes, RLS, connection pooling, schema design |
| `fullstack-developer` | Scope → API → DB schema → frontend → deploy |
| `error-handling-patterns` | Exceptions, Result types, graceful degradation |
| `prompt-engineering` | 6-step framework for production AI prompts |
| `prompt-engineering-patterns` | 9 production-tested prompting patterns |
| `vercel-react-native-skills` | FlashList, Reanimated, expo-router, monorepo |
| `agent-workflow` | Design and architect multi-agent AI workflows |

### Documentation & Operations

| Skill | Purpose |
|-------|---------|
| `changelog-generator` | Technical commits → user-friendly release notes |
| `codebase-documenter` | READMEs, architecture guides, API docs |
| `maintaining-documentation` | Keep docs as a living single source of truth |
| `creating-skills` | Meta-skill for generating new standardized skills |
| `deploying-to-github` | Automates version control workflows |
| `requesting-code-review` | AI-powered code review subagent |

---

## Workflows

Chained skills with explicit gates between steps.

| Workflow | Slash Command | Chain |
|----------|--------------|-------|
| `systematic-debugging` | `/debug` | Root-cause-first debugging protocol |
| `idea-to-prd` | `/idea` | idea-validator → brainstorming → prd-writer |
| `full-stack-build` | `/fullstack` | API design → DB schema → frontend → deploy |
| `feature-to-launch` | `/feature-launch` | PRD → build → changelog → product-launch |
| `content-publishing` | `/publish` | Idea capture → draft → edit → platform publish |
| `feature-documenter` | — | Feature documentation automation |

---

## Skill Format

Every skill is a directory with a `SKILL.md` file:

```
skills/<name>/
├── SKILL.md          ← Required: YAML frontmatter + skill body
└── references/       ← Optional: large rule sets loaded on demand
```

YAML frontmatter:

```yaml
---
name: name-in-gerund-form          # lowercase, hyphens
description: Third person. What it does and when to trigger it. Max 1024 chars.
---
```

Use the `creating-skills` meta-skill to generate new skills following this format.

---

## Full Skill Index

See `skills/GLOBAL_SKILLS.md` for the complete index with trigger conditions and the PM → Engineering → Release workflow integration.

---

## References

- [Claude Code Skills Docs](https://code.claude.com/docs/en/skills)
- [Awesome Claude Skills (VoltAgent)](https://github.com/VoltAgent/awesome-claude-skills)
- [Agent Skills Marketplace](https://skills.sh/)

---

Built by [@adrianlunadiaz](https://x.com/adrianlunadiaz)
