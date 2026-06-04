# Global ALD Skills

This repository serves as the central hub for reusable agentic skills. These skills are designed to be portable and automatically discoverable by any AI agent (Claude Code, Codex, OpenCode, or any other).

## 🛠 Active Skills

### Product Management

### 1. User Discovery
- **Path**: `skills/user-discovery/`
- **Purpose**: Structured user research and discovery synthesis. Produces Opportunity Statements from raw interviews that feed into strategy and PRDs.
- **Triggers**: before writing a PRD, validating assumptions, exploring a new segment, understanding why a metric dropped.

### 2. Product Strategy
- **Path**: `skills/product-strategy/`
- **Purpose**: Decision-focused product strategy. Defines North Star, maps Opportunity Tree, and presents three bets with explicit trade-offs.
- **Triggers**: quarterly OKRs, roadmap prioritization, new product area, stakeholder misalignment on direction, north star definition, choosing what NOT to build.

### 3. PRD Writer
- **Path**: `skills/prd-writer/`
- **Purpose**: Modern, decision-focused PRDs for the AI era with behavior contracts and rollout precision.
- **Triggers**: writing a PRD, feature spec, AI product specification, reviewing an existing PRD.

### 4. Product Analytics
- **Path**: `skills/product-analytics/`
- **Purpose**: Metrics frameworks, experiment design, and tracking plans. Pre-build metric definition and post-launch impact analysis.
- **Triggers**: defining success criteria, designing an A/B test, setting up analytics tracking, post-launch analysis.

### 5. Product Launch
- **Path**: `skills/product-launch/`
- **Purpose**: Go-to-market plans and launch checklists — GTM brief, technical/product/marketing readiness, rollout gates, post-launch review.
- **Triggers**: "prepare launch", "go-to-market", "Product Hunt", "launch checklist", rollout plan.

### 6. Idea Validator
- **Path**: `skills/idea-validator/`
- **Purpose**: Validates and stress-tests product ideas before committing resources.
- **Triggers**: new idea, startup concept, feature proposal needing reality check.

### 7. Writing System
- **Path**: `skills/writing-system/`
- **Purpose**: Personal writing system for X threads, LinkedIn posts, newsletters, and blog posts with platform-specific structure.
- **Triggers**: "write a post", "draft newsletter", "write this up", "turn this into a thread", content calendar.

### 8. Email Builder
- **Path**: `skills/email-builder/`
- **Purpose**: Builds complete bilingual emails from intent and audience, including subject lines, preheaders, structured body copy, CTAs, safe placeholders, and useful variants.
- **Triggers**: write an email, draft outreach, customer update, follow-up, announcement, invite, sales email, campaign email, lifecycle email, subject lines, preheader, CTA, English and Spanish email.

### 9. LinkedIn Viral Post Writer
- **Path**: `skills/linkedin-viral-post-writer/`
- **Purpose**: Hook system and craftsmanship standards for high-performance LinkedIn content.
- **Triggers**: writing a LinkedIn post, content strategy, thought leadership.

### 10. Competitor Analysis
- **Path**: `skills/competitor-analysis/`
- **Purpose**: Structured competitive analysis — profiles 5 competitors, identifies white space, and recommends a differentiated positioning. Produces a decision-ready competitive map, not a feature comparison table.
- **Triggers**: competitive analysis, competitor research, market landscape, differentiation, competitive positioning, market entry, who are our competitors, losing to a competitor, white space, pricing strategy.

### 11. User Personas
- **Path**: `skills/user-personas/`
- **Purpose**: Research-backed persona creation — max 3 personas per segment, grounded in JTBD, pain points, gains, and unexpected insights. Prevents persona theater (stock photos + demographics).
- **Triggers**: user persona, JTBD, persona creation, user segmentation, who is our user, target audience, customer profile.

### 12. Customer Journey Map
- **Path**: `skills/customer-journey-map/`
- **Purpose**: Maps end-to-end user journey from Awareness to Advocacy — touchpoints, emotions, friction, moments of truth, and prioritized improvements. Reveals where users get stuck, not just where they succeed.
- **Triggers**: customer journey, journey map, touchpoints, onboarding experience, churn points, aha moment, user flow, drop-off analysis.

### 13. Value Proposition
- **Path**: `skills/value-proposition/`
- **Purpose**: Designs a value proposition using a 6-part JTBD template (Who / Why / What Before / How / What After / Alternatives). One value prop per customer segment — not a tagline, a positioning decision.
- **Triggers**: value proposition, value prop, JTBD, customer value, why us, positioning statement, product differentiation, customer benefit, what problem do we solve, win/loss, customer confusion, elevator pitch.

### 14. Feature to Outcome
- **Path**: `skills/feature-to-outcome/`
- **Purpose**: Translates stakeholder feature requests into validated outcome statements using the 'One Framework. Four Questions.' protocol — Behavior Change → Assumption Test → Cheapest Test → Success Metric. Produces an Outcome Brief with embedded AI prompts ready to paste into any LLM.
- **Triggers**: stakeholder pushing a specific feature, "we need a dashboard", outcomes not features, what problem does this solve, feature factory, push back on a request, translate feature to outcome, outcome vs output, assumption testing, discovery before delivery.

### 15. Prioritization Frameworks
- **Path**: `skills/prioritization-frameworks/`
- **Purpose**: Selects and applies the right prioritization framework — Opportunity Score, RICE, ICE, MoSCoW, Kano — for the current context. Produces a ranked backlog with explicit scoring rationale.
- **Triggers**: prioritization, RICE, ICE, MoSCoW, Kano, backlog prioritization, roadmap prioritization, what to build next, feature ranking, sprint backlog.

### 16. Stakeholder Map
- **Path**: `skills/stakeholder-map/`
- **Purpose**: Maps stakeholders on a Power × Interest grid, produces a 4-quadrant communication plan, and surfaces conflict zones before they derail delivery.
- **Triggers**: stakeholder management, power interest grid, cross-functional alignment, stakeholder communication, who needs to be involved, buy-in, executive alignment.

### 17. Pre-Mortem
- **Path**: `skills/pre-mortem/`
- **Purpose**: Identifies launch risks using the Tigers / Paper Tigers / Elephants framework before execution begins. Produces a launch-blocking action plan — not a risk list that sits in a doc.
- **Triggers**: pre-mortem, risk analysis, launch readiness, what could go wrong, failure modes, risk register, risk assessment.

### 18. Sprint Plan
- **Path**: `skills/sprint-plan/`
- **Purpose**: Produces a structured sprint plan — goal, capacity estimate, story selection, dependency map, and risk flags — before the sprint starts. Sprint planning as a decision, not a calendar event.
- **Triggers**: sprint planning, capacity planning, sprint goal, sprint prep, sprint kickoff, what goes in the sprint, sprint backlog.

### 19. Retro
- **Path**: `skills/retro/`
- **Purpose**: Facilitates sprint retrospectives using Start/Stop/Continue, 4Ls, or Sailboat format. Produces 2-3 prioritized action items with owners and deadlines — not a venting session.
- **Triggers**: retrospective, retro, sprint review, what went well, lessons learned, team improvement, action items, start stop continue, post-mortem, sprint reflection.

### 20. Growth Loops
- **Path**: `skills/growth-loops/`
- **Purpose**: Identifies and designs growth loops (flywheels) for sustainable traction — evaluating 5 loop types: Viral, Usage, Collaboration, User-Generated, Referral. Includes K coefficient estimation and a build plan.
- **Triggers**: growth loop, flywheel, viral loop, referral program, product-led growth, PLG, user acquisition, growth strategy, retention loop, compounding growth.

### 21. Draft NDA
- **Path**: `skills/draft-nda/`
- **Purpose**: Drafts a Non-Disclosure Agreement covering parties, information types, duration, jurisdiction, and key clauses — with ⚠️ markers on clauses requiring legal review. For contractor and partnership work on side projects.
- **Triggers**: NDA, non-disclosure agreement, confidentiality agreement, contractor agreement, partnership NDA, freelancer agreement.

### 22. Privacy Policy
- **Path**: `skills/privacy-policy/`
- **Purpose**: Drafts a privacy policy covering data types collected, user rights, jurisdiction-specific requirements (GDPR, CCPA), and compliance considerations — with ⚠️ markers for legal review.
- **Triggers**: privacy policy, GDPR, CCPA, data protection, data privacy, user data, cookie policy, compliance, data collection.

### 23. Case Study Solver
- **Path**: `skills/case-study-solver/`
- **Purpose**: Structured methodology for solving, writing, and presenting hiring case studies for Senior PM and Technical PM roles. Covers the full process from problem understanding to final delivery, including data analysis, written response, interactive presentation, and verbal delivery protocol.
- **Triggers**: case study, PM interview, TPM interview, hiring exercise, data analysis for interview, case study presentation, interview preparation.

### 24. PM Interview Communication
- **Path**: `skills/pm-interview-communication/`
- **Purpose**: Structured verbal communication framework for Senior PM and TPM interviews. Covers SCQA/STAR scaffolding, answer templates by question type, pushback handling, English-under-pressure tactics, and post-interview debrief methodology.
- **Triggers**: interview preparation, how do I answer this, rehearse with me, how would you say this, practice interview question, STAR answer, SCQA, behavioral question, verbal delivery.

---

### Engineering & Development

### 25. Brainstorming
- **Path**: `skills/brainstorming/`
- **Purpose**: Socratic discovery and technical design. Explores ideas, architecture decisions, and design trade-offs before implementation. Produces a validated design doc with 2-3 options and a recommendation.
- **Triggers**: vague ideas, architectural decisions, complex tasks, "should we use X or Y", "help me think through", "what's the best approach for", trade-off analysis, design before coding.

### 26. Planning
- **Path**: `skills/planning/`
- **Purpose**: Atomic, TDD-focused implementation plans. Breaks approved designs into commit-sized tasks with exact file paths, test commands, and Red→Green→Refactor steps.
- **Triggers**: spec-ready features, "write me a plan", "break this into tasks", "implementation steps for", "what order should I build", TDD plan, sprint breakdown.

### 27. Brand Identity
- **Path**: `skills/brand-identity/`
- **Purpose**: Single Source of Truth for design, tech stack, and voice.
- **Triggers**: UI generation, styling, copywriting.

### 28. Error Handling Patterns
- **Path**: `skills/error-handling-patterns/`
- **Purpose**: Robust strategies for resilient applications.
- **Triggers**: API design, reliability improvements, debugging.

### 29. React Best Practices
- **Path**: `skills/react-best-practices/`
- **Purpose**: Performance optimization for React and Next.js.
- **Triggers**: component creation, layout shifts, bundle optimization.

### 30. Frontend Design
- **Path**: `skills/frontend-design/`
- **Purpose**: Create distinctive, production-grade frontend interfaces.
- **Triggers**: UI components, visual polish, web apps.

### 31. Interface Design
- **Path**: `skills/interface-design/`
- **Purpose**: Craft intentional interfaces for dashboards and SaaS.
- **Triggers**: SaaS apps, dashboards, admin panels.

### 32. Prompt Engineering
- **Path**: `skills/prompt-engineering/`
- **Purpose**: 6-step optimization framework for production AI prompts.
- **Triggers**: optimizing a system prompt, building an AI feature, prompt failure analysis.

### 33. Prompt Engineering Patterns
- **Path**: `skills/prompt-engineering-patterns/`
- **Purpose**: Library of 9 production-tested prompting patterns (CoT, Few-Shot, Structured Output, Tool-Use Routing, etc.)
- **Triggers**: selecting a prompting technique, building AI pipelines, reviewing prompts for failure modes.

### 34. Vercel Composition Patterns
- **Path**: `skills/vercel-composition-patterns/`
- **Purpose**: React composition patterns — compound components, CVA variants, React 19 APIs (no forwardRef, use()).
- **Triggers**: components with too many boolean props, compound components, reusable APIs, context providers.

### 35. Web Design Guidelines
- **Path**: `skills/web-design-guidelines/`
- **Purpose**: Audits web interfaces for accessibility, performance, UX, and code quality (100+ rules in 18 categories).
- **Triggers**: "review my UI", "check accessibility", "audit design", pre-merge frontend check.

### 36. React Native Best Practices
- **Path**: `skills/vercel-react-native-skills/`
- **Purpose**: React Native and Expo performance patterns — FlashList, Reanimated, expo-router, monorepo setup.
- **Triggers**: React Native or Expo app, list performance, animations, native modules, monorepo.

### 37. Tailwind Design System
- **Path**: `skills/tailwind-design-system/`
- **Purpose**: Build design systems with Tailwind CSS v4 — CSS-first @theme config, OKLCH tokens, CVA variants.
- **Triggers**: Tailwind v4, design tokens, CVA, dark mode setup, migrating from Tailwind v3.

### 38. API Design Principles
- **Path**: `skills/api-design-principles/`
- **Purpose**: REST and GraphQL API design — naming, error formats, versioning, pagination, OpenAPI-first.
- **Triggers**: new API endpoint, API contract review, GraphQL schema, API conventions.

### 39. Supabase & Postgres Best Practices
- **Path**: `skills/supabase-postgres/`
- **Purpose**: Supabase and PostgreSQL best practices — indexes, RLS, connection pooling, schema design.
- **Triggers**: SQL queries, database schema, RLS policies, Postgres optimization, Supabase setup.

### 40. Stitch Skills
- **Path**: `skills/stitch-skills/`
- **Purpose**: Convert Stitch AI design tool screens to production-ready React code and documentation.
- **Triggers**: Stitch MCP server, "convert Stitch screen", "generate DESIGN.md", Stitch to React.

### 41. Fullstack Developer
- **Path**: `skills/fullstack-developer/`
- **Purpose**: End-to-end feature implementation — scope → API contract → DB schema → frontend → deploy.
- **Triggers**: "build this feature", "implement end-to-end", "new feature from scratch", side project setup.

### 42. Agent Workflow
- **Path**: `skills/agent-workflow/`
- **Purpose**: Expert system for designing and architecting AI agent workflows. Covers the 9-step building process, 8-layer architecture framework, MCP integration, and single vs. multi-agent decision making.
- **Triggers**: "build an agent", "design agent workflow", "multi-agent system", "agent architecture", "how should I structure this agent", MCP integration, ReAct pattern, tool calling design.

### 43. Design Guide
- **Path**: `skills/design-guide/`
- **Purpose**: Modern UI design system and guidelines for building clean, professional interfaces with consistent spacing, typography, colors, and interaction patterns.
- **Triggers**: creating or modifying UI components, web pages, React components, HTML/CSS, visual interfaces, design consistency, spacing guidelines.

### 44. Figma Reverse Engineering
- **Path**: `skills/figma-reverse-engineering/`
- **Purpose**: Reverse engineers Figma designs into complete technical specifications ready for code implementation — design tokens, layout structure, CSS properties, and implementation spec.
- **Triggers**: "reverse engineering del diseño", "documenta este Figma", "quiero implementar este diseño", "dame las propiedades CSS", "convierte este diseño a código", screenshots of Figma designs, Figma layers and properties.

### 45. Frontend Slides
- **Path**: `skills/frontend-slides-main/`
- **Purpose**: Creates zero-dependency, animation-rich HTML presentations from scratch or by converting PowerPoint files. Helps non-designers discover their aesthetic through visual exploration.
- **Triggers**: "build a presentation", "convert PPT to web", "create slides", "HTML presentation", "slide deck for a talk", "pitch slides".

---

### Documentation & Operations

### 46. Changelog Generator
- **Path**: `skills/changelog-generator/`
- **Purpose**: Technical-to-User-friendly release notes.
- **Triggers**: releases, weekly updates, customer comms.

### 47. Codebase Documenter
- **Path**: `skills/codebase-documenter/`
- **Purpose**: Creating beginner-friendly docs and architecture guides.
- **Triggers**: README updates, documentation audits.

### 48. Maintaining Documentation
- **Path**: `skills/maintaining-documentation/`
- **Purpose**: Keeps documentation as a living single source of truth.
- **Triggers**: feature completion, architecture changes, pre-push doc check.

### 49. Creating Skills
- **Path**: `skills/creating-skills/`
- **Purpose**: Meta-skill for generating new standardized skills.
- **Triggers**: "Build me a skill for X".

### 50. Deploying to GitHub
- **Path**: `skills/deploying-to-github/`
- **Purpose**: Automates version control workflows and pushes.
- **Triggers**: saving changes, pushing code, git operations.

### 51. Requesting Code Review
- **Path**: `skills/requesting-code-review/`
- **Purpose**: Superpowers:code-reviewer subagent for early issue detection.
- **Triggers**: PR review, feature completion, pre-commit check.

### 52. Autoresearch
- **Path**: `skills/autoresearch/`
- **Purpose**: Autonomously optimizes any Claude Code skill by running it repeatedly, scoring outputs against binary evals, mutating the prompt, and keeping improvements. Based on Karpathy's autoresearch methodology.
- **Triggers**: "optimize this skill", "improve this skill", "run autoresearch on", "make this skill better", "self-improve skill", "benchmark skill", "eval my skill", "run evals on".

### 53. Prompt Clarifier
- **Path**: `skills/prompt-clarifier/`
- **Purpose**: Enriches vague, low-detail prompts into structured agent-optimized XML before execution. Runs a 2-3 question Socratic interview to extract intent, constraints, success criteria, and entry point. Use proactively — before any tool use — when a prompt is short, ambiguous, or missing success criteria. Also activates automatically via a UserPromptSubmit hook that detects vagueness without any LLM call.
- **Triggers**: "clarify", "enrich this prompt", "help me describe this better", CLARIFIER_ADVISORY in context, any prompt under 10 words with no file path or error message, "fix the bug", "add authentication", "make this better", "refactor this", "clean this up", "improve performance", "add payments", "build the feature", "make it work".

### 54. Web Research
- **Path**: `skills/web-research/`
- **Purpose**: Correct protocol for crawling external websites — homepage first, extract real hrefs, then visit confirmed URLs. Prevents the pattern of guessing URL paths that leads to cascading 404s.
- **Triggers**: "research this site", "check their website", "find what X does", "scrape this competitor", "crawl this URL", "fetch pages from", any task requiring multiple pages from the same domain. Use proactively before any multi-page web crawl.

### 55. Taste Redesign
- **Path**: `skills/taste-redesign/`
- **Purpose**: Upgrades existing UIs to premium quality by auditing generic AI patterns and applying high-end design standards.
- **Triggers**: "improve the design", "looks generic", "not polished enough", "redesign this", "elevate the UI", "apply taste", design review.

---

## 🔄 Workflow Integration

### Full PM → Engineering → Release Flow

```
DISCOVER → STRATEGIZE → SPECIFY → BUILD → REVIEW → HARDEN → DOCUMENT → RELEASE
```

1. **Discover** → `user-discovery` *(understand user problems before building)*
2. **Reframe** → `feature-to-outcome` *(translate stakeholder features into validated outcomes)*
3. **Strategize** → `product-strategy` *(define bets, North Star, OKRs)*
4. **Specify** → `prd-writer` + `product-analytics` *(write the PRD + define success metrics)*
5. **Design** → `brainstorming` + `brand-identity` + `frontend-design` + `interface-design`
6. **Plan** → `planning` *(atomic, TDD-focused implementation plan)*
7. **Build** → `react-best-practices` + `prompt-engineering-patterns` *(if AI features)*
8. **Review** → `requesting-code-review`
9. **Harden** → `error-handling-patterns`
10. **Document** → `codebase-documenter` + `maintaining-documentation`
11. **Release** → `changelog-generator` + `deploying-to-github`
12. **Measure** → `product-analytics` *(post-launch impact analysis)*

### Workflows

- `workflows/systematic-debugging/` — Root-cause-first debugging protocol with `/debug` slash command
- `workflows/feature-documenter/` — Feature documentation automation
- `workflows/full-stack-build/` — End-to-end feature workflow: API design → DB schema → React → deploy, with `/fullstack` slash command
- `workflows/idea-to-prd/` — idea-validator → brainstorming → prd-writer with gates, with `/idea` slash command
- `workflows/feature-to-launch/` — PRD → full-stack-build → changelog → product-launch with readiness gates, with `/feature-launch` slash command
- `workflows/content-publishing/` — writing-system → edit pass → platform publishing, with `/publish` slash command
