# ALD Skills

**42 skills and 2 workflows that turn Claude Code into a product team.**

This is the public layer of [ald-os](https://github.com/alunadev) — a personal
AI Product Management Operating System I use daily to run the full product
loop with AI agents: `problem → context → PRD → prototype → build → ship → learn`.

Every skill here is battle-tested on real work — PRDs, product strategy,
full-stack side projects, design systems, interview prep, and content. Nothing
in this library is theoretical: if a skill stopped earning its place in my
daily workflow, it was rewritten or removed.

Built by [Adrian Luna Díaz](https://alunadev.vercel.app) — AI-first Senior
Product Manager and Product Builder.

---

## Install as a Claude Code Plugin (Recommended)

```bash
# 1. Add this repo as a plugin marketplace
claude plugin marketplace add alunadev/ald-skills

# 2. Install the plugin
claude plugin install ald-skills@ald-skills
```

All skills become auto-discoverable: Claude triggers them by context, or you
invoke them by name ("use prd-writer", "apply brainstorming").

### Alternative: Git Submodule

```bash
git submodule add https://github.com/alunadev/ald-skills.git ald-skills
git submodule update --init
```

Reference skills by path from your `CLAUDE.md`:
`ald-skills/skills/<name>/SKILL.md`

---

## Why this exists

AI coding agents are only as good as the context and process you give them.
Instead of re-explaining how I write PRDs, structure discovery, design
interfaces, or ship features in every session, each practice lives in a
skill: a markdown file with YAML frontmatter that Claude loads on demand.

The result is a system where product work compounds — every session starts
with the accumulated judgment of all previous ones.

---

## Featured Skill Map

### Product Management

| Skill | Slash Command | Purpose |
|-------|--------------|---------|
| `prd-writer` | `/prd` | Decision-focused PRDs with behavior contracts |
| `product-strategy` | `/strategy` | North Star, Opportunity Tree, 3 bets, OKRs |
| `product-analytics` | `/metrics` | Metric tree, A/B design, tracking plan, HEART |
| `analytics-tracking` | `/tracking` | Event naming, GA4/GTM/Amplitude setup, debugging |
| `ai-product-strategy` | `/ai-strategy` | Wedge, RAG vs. fine-tuning, autonomy, defensibility |
| `feature-to-outcome` | — | Translate stakeholder feature requests into validated outcomes |
| `product-launch` | — | GTM brief, readiness checklists, rollout gates |
| `competitor-analysis` | — | 5 competitor profiles, white space, where-to-win |

### Engineering & Development

| Skill | Purpose |
|-------|---------|
| `brainstorming` | Socratic discovery and technical design before code |
| `react-best-practices` | Performance optimization, 8 categories, 58 rules |
| `api-design-principles` | REST and GraphQL API design conventions |
| `error-handling-patterns` | Exceptions, Result types, graceful degradation |
| `prompt-engineering` | 6-step framework for production AI prompts |
| `prompt-engineering-patterns` | 9 production-tested prompting patterns |
| `agent-workflow` | Design and architect multi-agent AI workflows |
| `vercel-composition-patterns` | Compound components, CVA variants, React 19 |
| `vercel-react-native-skills` | FlashList, Reanimated, expo-router, monorepo |

### Design

| Skill | Purpose |
|-------|---------|
| `design-md` | Extract brand systems into AI-readable DESIGN.md tokens |
| `brand-identity` | Interview-driven brand generation per new project |
| `taste-skill` | Anti-slop frontend design for NEW UI, brief-first |
| `taste-redesign` | Audit and elevate an EXISTING UI to premium quality |
| `web-design-guidelines` | 100+ accessibility, UX and code quality rules |
| `figma-reverse-engineering` | Figma designs → implementation-ready specs |
| `frontend-slides` | Animation-rich HTML presentations, brief or PPT conversion |

### Content & Communication

| Skill | Purpose |
|-------|---------|
| `writing-system` | Orchestrator: idea capture, platform pick, blog + newsletter |
| `linkedin-post-writer` | LinkedIn posts in your own voice, no growth-hacking |
| `x-thread-writer` | Same voice standard, for X/Twitter threads |
| `email-builder` | Bilingual emails: subject lines, CTAs, variants |
| `changelog-generator` | Technical commits → user-friendly release notes |

### Career & Interviews

| Skill | Purpose |
|-------|---------|
| `case-study-solver` | Full methodology for PM/TPM hiring case studies, incl. wireframe standards |
| `pm-interview-communication` | SCQA/STAR/C-F-I scaffolding, English + Spanish under pressure |

### Documentation & Operations

| Skill | Purpose |
|-------|---------|
| `maintaining-documentation` | Keep docs as a living single source of truth |
| `creating-skills` | Meta-skill for generating new standardized skills |
| `autoresearch` | Self-optimize any skill via eval loops |
| `deploying-to-github` | Safe git flow: submodule-first, worktrees, no blanket `add .` |
| `requesting-code-review` | AI-powered code review subagent |

---

## Workflows

Chained skills with explicit gates between steps.

| Workflow | Slash Command | Chain |
|----------|--------------|-------|
| `systematic-debugging` | `/debug` | Root-cause-first debugging protocol |
| `content-publishing` | `/publish` | Idea capture → draft → edit → platform publish |

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
name: skill-name                   # lowercase, hyphens
description: Third person. What it does and when to trigger it. Max 1024 chars.
---
```

Use the `creating-skills` meta-skill to generate new skills following this
format, and `autoresearch` to optimize them against evals.

---

## Full Skill Index

See [skills/README.md](skills/README.md) for the complete index with trigger
conditions and the PM → Engineering → Release workflow integration.

---

## The System Behind This

ald-skills is one layer of a larger operating system for AI-first product
work. The other layers (private): per-product context folders, an evidence
and profile pipeline, session logs with automatic rollup between repos, and
hooks that enforce the operating rules. The concept: **product work should
compound, not restart every session.**

If you're building something similar, the skill format plus the
`creating-skills` meta-skill is the best place to start.

---

## References

- [Claude Code Skills Docs](https://code.claude.com/docs/en/skills)
- [Awesome Claude Skills (VoltAgent)](https://github.com/VoltAgent/awesome-claude-skills)
- [Agent Skills Marketplace](https://skills.sh/)

---

Built by [@adrianlunadiaz](https://x.com/adrianlunadiaz) ·
[Portfolio](https://alunadev.vercel.app) ·
[GitHub](https://github.com/alunadev)
