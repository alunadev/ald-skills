# Global Antigravity Skills

This repository serves as the central hub for reusable agentic skills. These skills are designed to be portable and automatically discoverable by AI agents like Antigravity and Claude Code.

## 🛠 Active Skills

### Product Management

### 1. User Discovery
- **Path**: `skills/user-discovery/`
- **Purpose**: Structured user research and discovery synthesis. Produces Opportunity Statements from raw interviews that feed into strategy and PRDs.
- **Triggers**: before writing a PRD, validating assumptions, exploring a new segment, understanding why a metric dropped.

### 2. Product Strategy
- **Path**: `skills/product-strategy/`
- **Purpose**: Decision-focused product strategy. Defines North Star, maps Opportunity Tree, and presents three bets with explicit trade-offs.
- **Triggers**: quarterly OKRs, roadmap prioritization, new product area, stakeholder misalignment on direction.

### 3. PRD Writer
- **Path**: `skills/prd-writer/`
- **Purpose**: Modern, decision-focused PRDs for the AI era with behavior contracts and rollout precision.
- **Triggers**: writing a PRD, feature spec, AI product specification, reviewing an existing PRD.

### 4. Product Analytics
- **Path**: `skills/product-analytics/`
- **Purpose**: Metrics frameworks, experiment design, and tracking plans. Pre-build metric definition and post-launch impact analysis.
- **Triggers**: defining success criteria, designing an A/B test, setting up analytics tracking, post-launch analysis.

### 5. Idea Validator
- **Path**: `skills/idea-validator/`
- **Purpose**: Validates and stress-tests product ideas before committing resources.
- **Triggers**: new idea, startup concept, feature proposal needing reality check.

### 6. LinkedIn Viral Post Writer
- **Path**: `skills/linkedin-viral-post-writer/`
- **Purpose**: Hook system and craftsmanship standards for high-performance LinkedIn content.
- **Triggers**: writing a LinkedIn post, content strategy, thought leadership.

---

### Engineering & Development

### 7. Brainstorming
- **Path**: `skills/brainstorming/`
- **Purpose**: Socratic discovery and technical design.
- **Triggers**: vague ideas, architectural changes, complex tasks.

### 8. Planning
- **Path**: `skills/planning/`
- **Purpose**: Atomic, TDD-focused implementation plans.
- **Triggers**: spec-ready features, plan generation.

### 9. Brand Identity
- **Path**: `skills/brand-identity/`
- **Purpose**: Single Source of Truth for design, tech stack, and voice.
- **Triggers**: UI generation, styling, copywriting.

### 10. Error Handling Patterns
- **Path**: `skills/error-handling-patterns/`
- **Purpose**: Robust strategies for resilient applications.
- **Triggers**: API design, reliability improvements, debugging.

### 11. React Best Practices
- **Path**: `skills/react-best-practices/`
- **Purpose**: Performance optimization for React and Next.js.
- **Triggers**: component creation, layout shifts, bundle optimization.

### 12. Frontend Design
- **Path**: `skills/frontend-design/`
- **Purpose**: Create distinctive, production-grade frontend interfaces.
- **Triggers**: UI components, visual polish, web apps.

### 13. Interface Design
- **Path**: `skills/interface-design/`
- **Purpose**: Craft intentional interfaces for dashboards and SaaS.
- **Triggers**: SaaS apps, dashboards, admin panels.

### 14. Prompt Engineering
- **Path**: `skills/prompt-engineering/`
- **Purpose**: 6-step optimization framework for production AI prompts.
- **Triggers**: optimizing a system prompt, building an AI feature, prompt failure analysis.

### 15. Prompt Engineering Patterns
- **Path**: `skills/prompt-engineering-patterns/`
- **Purpose**: Library of 9 production-tested prompting patterns (CoT, Few-Shot, Structured Output, Tool-Use Routing, etc.)
- **Triggers**: selecting a prompting technique, building AI pipelines, reviewing prompts for failure modes.

---

### Documentation & Operations

### 16. Changelog Generator
- **Path**: `skills/changelog-generator/`
- **Purpose**: Technical-to-User-friendly release notes.
- **Triggers**: releases, weekly updates, customer comms.

### 17. Codebase Documenter
- **Path**: `skills/codebase-documenter/`
- **Purpose**: Creating beginner-friendly docs and architecture guides.
- **Triggers**: README updates, documentation audits.

### 18. Maintaining Documentation
- **Path**: `skills/maintaining-documentation/`
- **Purpose**: Keeps documentation as a living single source of truth.
- **Triggers**: feature completion, architecture changes, pre-push doc check.

### 19. Creating Skills
- **Path**: `skills/creating-skills/`
- **Purpose**: Meta-skill for generating new standardized skills.
- **Triggers**: "Build me a skill for X".

### 20. Deploying to GitHub
- **Path**: `skills/deploying-to-github/`
- **Purpose**: Automates version control workflows and pushes.
- **Triggers**: saving changes, pushing code, git operations.

### 21. Requesting Code Review
- **Path**: `skills/requesting-code-review/`
- **Purpose**: Superpowers:code-reviewer subagent for early issue detection.
- **Triggers**: PR review, feature completion, pre-commit check.

---

## 🔄 Workflow Integration

### Full PM → Engineering → Release Flow

```
DISCOVER → STRATEGIZE → SPECIFY → BUILD → REVIEW → HARDEN → DOCUMENT → RELEASE
```

1. **Discover** → `user-discovery` *(understand user problems before building)*
2. **Strategize** → `product-strategy` *(define bets, North Star, OKRs)*
3. **Specify** → `prd-writer` + `product-analytics` *(write the PRD + define success metrics)*
4. **Design** → `brainstorming` + `brand-identity` + `frontend-design` + `interface-design`
5. **Plan** → `planning` *(atomic, TDD-focused implementation plan)*
6. **Build** → `react-best-practices` + `prompt-engineering-patterns` *(if AI features)*
7. **Review** → `requesting-code-review`
8. **Harden** → `error-handling-patterns`
9. **Document** → `codebase-documenter` + `maintaining-documentation`
10. **Release** → `changelog-generator` + `deploying-to-github`
11. **Measure** → `product-analytics` *(post-launch impact analysis)*

### Workflows

- `workflows/systematic-debugging/` — Root-cause-first debugging protocol with `/debug` slash command
- `workflows/feature-documenter/` — Feature documentation automation
