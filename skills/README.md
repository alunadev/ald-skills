# Global ALD Skills

This repository serves as the central hub for reusable agentic skills. These skills are designed to be portable and automatically discoverable by any AI agent (Claude Code, Codex, OpenCode, or any other).

## 🛠 Active Skills

### Product Management

### 1. Product Strategy
- **Path**: `skills/product-strategy/`
- **Purpose**: Decision-focused product strategy. Defines North Star, maps Opportunity Tree, and presents three bets with explicit trade-offs.
- **Triggers**: quarterly OKRs, roadmap prioritization, new product area, stakeholder misalignment on direction, north star definition, choosing what NOT to build.

### 2. PRD Writer
- **Path**: `skills/prd-writer/`
- **Purpose**: Modern, decision-focused PRDs for the AI era with behavior contracts and rollout precision.
- **Triggers**: writing a PRD, feature spec, AI product specification, reviewing an existing PRD.

### 3. Product Analytics
- **Path**: `skills/product-analytics/`
- **Purpose**: The whole analytics loop in one skill — metric trees and guardrails, event taxonomy and naming, instrumenting a flow, experiment design, post-launch analysis, and debugging events that don't fire. Amplitude is the reference standard: lowercase `snake_case`, object first, action second (`order_completed`); Title Case in the Amplitude UI only. Commands: `/metrics` (measurement) and `/tracking` (instrumentation).
- **Triggers**: defining success criteria, A/B design, post-launch analysis, "set up tracking", event naming, tagging onboarding or a new feature, "why isn't this event firing", GA4/GTM/Amplitude/Segment setup, UTM strategy.

### 4. Product Launch
- **Path**: `skills/product-launch/`
- **Purpose**: Go-to-market plans and launch checklists — GTM brief, technical/product/marketing readiness, rollout gates, post-launch review.
- **Triggers**: "prepare launch", "go-to-market", "Product Hunt", "launch checklist", rollout plan.

### 5. Competitor Analysis
- **Path**: `skills/competitor-analysis/`
- **Purpose**: Structured competitive analysis — profiles 5 competitors, identifies white space, and recommends a differentiated positioning. Produces a decision-ready competitive map, not a feature comparison table.
- **Triggers**: competitive analysis, competitor research, market landscape, differentiation, competitive positioning, market entry, who are our competitors, losing to a competitor, white space, pricing strategy.

### 6. User Personas
- **Path**: `skills/user-personas/`
- **Purpose**: Research-backed persona creation — max 3 personas per segment, grounded in JTBD, pain points, gains, and unexpected insights. Prevents persona theater (stock photos + demographics).
- **Triggers**: user persona, JTBD, persona creation, user segmentation, who is our user, target audience, customer profile.

### 7. Customer Journey Map
- **Path**: `skills/customer-journey-map/`
- **Purpose**: Maps end-to-end user journey from Awareness to Advocacy — touchpoints, emotions, friction, moments of truth, and prioritized improvements. Reveals where users get stuck, not just where they succeed.
- **Triggers**: customer journey, journey map, touchpoints, onboarding experience, churn points, aha moment, user flow, drop-off analysis.

### 8. Feature to Outcome
- **Path**: `skills/feature-to-outcome/`
- **Purpose**: Translates stakeholder feature requests into validated outcome statements using the 'One Framework. Four Questions.' protocol — Behavior Change → Assumption Test → Cheapest Test → Success Metric. Produces an Outcome Brief with embedded AI prompts ready to paste into any LLM.
- **Triggers**: stakeholder pushing a specific feature, "we need a dashboard", outcomes not features, what problem does this solve, feature factory, push back on a request, translate feature to outcome, outcome vs output, assumption testing, discovery before delivery.

### 9. Stakeholder Map
- **Path**: `skills/stakeholder-map/`
- **Purpose**: Maps stakeholders on a Power × Interest grid, produces a 4-quadrant communication plan, and surfaces conflict zones before they derail delivery.
- **Triggers**: stakeholder management, power interest grid, cross-functional alignment, stakeholder communication, who needs to be involved, buy-in, executive alignment.

### 10. Sprint Plan
- **Path**: `skills/sprint-plan/`
- **Purpose**: Produces a structured sprint plan — goal, capacity estimate, story selection, dependency map, and risk flags — before the sprint starts. Sprint planning as a decision, not a calendar event.
- **Triggers**: sprint planning, capacity planning, sprint goal, sprint prep, sprint kickoff, what goes in the sprint, sprint backlog.

### 11. Growth Loops
- **Path**: `skills/growth-loops/`
- **Purpose**: Identifies and designs growth loops (flywheels) for sustainable traction — evaluating 5 loop types: Viral, Usage, Collaboration, User-Generated, Referral. Includes K coefficient estimation and a build plan.
- **Triggers**: growth loop, flywheel, viral loop, referral program, product-led growth, PLG, user acquisition, growth strategy, retention loop, compounding growth.

---

### Content & Social Media

### 12. Writing System
- **Path**: `skills/writing-system/`
- **Purpose**: Orchestrator — idea capture and platform selection, then hands off to `linkedin-post-writer` or `x-thread-writer`; Blog and Newsletter drafting stays here.
- **Triggers**: "write a post", "draft newsletter", "write this up", "turn this into a thread", content calendar.

### 13. Email Builder
- **Path**: `skills/email-builder/`
- **Purpose**: Builds complete bilingual emails from intent and audience, including subject lines, preheaders, structured body copy, CTAs, safe placeholders, and useful variants.
- **Triggers**: write an email, draft outreach, customer update, follow-up, announcement, invite, sales email, campaign email, lifecycle email, subject lines, preheader, CTA, English and Spanish email.

### 14. LinkedIn Post Writer
- **Path**: `skills/linkedin-post-writer/`
- **Purpose**: Writes LinkedIn posts in Adrian's own voice from a real observation — the Nota (short, dated) or the longer Insight Post — with a hard ban on growth-hacking/engagement-bait constructions.
- **Triggers**: writing a LinkedIn post, turning a work observation into a post, reviewing a LinkedIn draft for tone.

### 15. X Thread Writer
- **Path**: `skills/x-thread-writer/`
- **Purpose**: Same voice standard as `linkedin-post-writer`, adapted for X/Twitter's shorter format — single tweets or threads, same banned-construction list.
- **Triggers**: writing an X/Twitter thread, turning an insight into a tweet, reviewing a thread draft for tone.

---

### Career & Interviews

### 16. Case Study Solver
- **Path**: `skills/case-study-solver/`
- **Purpose**: Structured methodology for solving, writing, and presenting hiring case studies for Senior PM and Technical PM roles. Covers the full process from problem understanding to final delivery, including data analysis, written response, interactive presentation (with wireframe standards from real feedback), and verbal delivery protocol.
- **Triggers**: case study, PM interview, TPM interview, hiring exercise, data analysis for interview, case study presentation, interview preparation.

### 17. PM Interview Communication
- **Path**: `skills/pm-interview-communication/`
- **Purpose**: Structured verbal communication framework for Senior PM and TPM interviews. Covers SCQA/STAR/C-F-I scaffolding, answer templates by question type, pushback handling, English- and Spanish-under-pressure tactics, and post-interview debrief methodology.
- **Triggers**: interview preparation, how do I answer this, rehearse with me, how would you say this, practice interview question, STAR answer, SCQA, behavioral question, verbal delivery.

---

### Engineering & Development

### 18. Brainstorming
- **Path**: `skills/brainstorming/`
- **Purpose**: Socratic discovery and technical design. Explores ideas, architecture decisions, and design trade-offs before implementation. Produces a validated design doc with 2-3 options and a recommendation.
- **Triggers**: vague ideas, architectural decisions, complex tasks, "should we use X or Y", "help me think through", "what's the best approach for", trade-off analysis, design before coding.

### 19. Error Handling Patterns
- **Path**: `skills/error-handling-patterns/`
- **Purpose**: Robust strategies for resilient applications.
- **Triggers**: API design, reliability improvements, debugging.

### 20. Vercel Composition Patterns
- **Path**: `skills/vercel-composition-patterns/`
- **Purpose**: React composition patterns — compound components, CVA variants, React 19 APIs (no forwardRef, use()).
- **Triggers**: components with too many boolean props, compound components, reusable APIs, context providers.

### 21. Web Design Guidelines
- **Path**: `skills/web-design-guidelines/`
- **Purpose**: Audits web interfaces for accessibility, performance, UX, and code quality (100+ rules in 18 categories).
- **Triggers**: "review my UI", "check accessibility", "audit design", pre-merge frontend check.

### 22. React Native Best Practices
- **Path**: `skills/vercel-react-native-skills/`
- **Purpose**: React Native and Expo performance patterns — FlashList, Reanimated, expo-router, monorepo setup.
- **Triggers**: React Native or Expo app, list performance, animations, native modules, monorepo.

### 23. API Design Principles
- **Path**: `skills/api-design-principles/`
- **Purpose**: REST and GraphQL API design — naming, error formats, versioning, pagination, OpenAPI-first.
- **Triggers**: new API endpoint, API contract review, GraphQL schema, API conventions.

### 24. Agent Workflow
- **Path**: `skills/agent-workflow/`
- **Purpose**: Expert system for designing and architecting AI agent workflows. Covers the 9-step building process, 8-layer architecture framework, MCP integration, and single vs. multi-agent decision making.
- **Triggers**: "build an agent", "design agent workflow", "multi-agent system", "agent architecture", "how should I structure this agent", MCP integration, ReAct pattern, tool calling design.

### 25. Figma Reverse Engineering
- **Path**: `skills/figma-reverse-engineering/`
- **Purpose**: Reverse engineers Figma designs into complete technical specifications ready for code implementation — design tokens, layout structure, CSS properties, and implementation spec.
- **Triggers**: "reverse engineering del diseño", "documenta este Figma", "quiero implementar este diseño", "dame las propiedades CSS", "convierte este diseño a código", screenshots of Figma designs, Figma layers and properties.

### 26. Frontend Slides
- **Path**: `skills/frontend-slides/`
- **Purpose**: Creates zero-dependency, animation-rich HTML presentations from scratch or by converting PowerPoint files. Uses a project's `DESIGN.md` tokens when one exists, otherwise offers 12 curated presets. Helps non-designers discover their aesthetic through visual exploration.
- **Triggers**: "build a presentation", "convert PPT to web", "create slides", "HTML presentation", "slide deck for a talk", "pitch slides".

---

### Documentation & Operations

### 27. Changelog Generator
- **Path**: `skills/changelog-generator/`
- **Purpose**: Transforms technical git commits into a clear, compact, user-friendly changelog — flat one-line-per-entry format, no emoji.
- **Triggers**: releases, weekly updates, customer comms.

### 28. Maintaining Documentation
- **Path**: `skills/maintaining-documentation/`
- **Purpose**: Maintains the real canonical docs structure (CLAUDE.md, progress.txt, docs/product+system+design-system, context/) and keeps `log.md` (append-only session history) distinct from `progress.txt` (current-state snapshot).
- **Triggers**: feature completion, architecture changes, pre-push doc check.

### 29. Deploying to GitHub
- **Path**: `skills/deploying-to-github/`
- **Purpose**: General GitHub workflow — branching model, commit hygiene, pull requests and code review, secrets hygiene, tags/releases, submodules, and git worktrees for parallel work.
- **Triggers**: saving changes, pushing code, opening a PR, git operations, working with a submodule, setting up or cleaning up a worktree.

### 30. Prompt Clarifier
- **Path**: `skills/prompt-clarifier/`
- **Purpose**: Enriches vague, low-detail prompts into structured agent-optimized XML before execution. Runs a 2-3 question Socratic interview to extract intent, constraints, success criteria, and entry point. Use proactively — before any tool use — when a prompt is short, ambiguous, or missing success criteria. Also activates automatically via a UserPromptSubmit hook that detects vagueness without any LLM call.
- **Triggers**: "clarify", "enrich this prompt", "help me describe this better", CLARIFIER_ADVISORY in context, any prompt under 10 words with no file path or error message, "fix the bug", "add authentication", "make this better", "refactor this", "clean this up", "improve performance", "add payments", "build the feature", "make it work".

### 31. Taste Redesign
- **Path**: `skills/taste-redesign/`
- **Purpose**: Audits an EXISTING UI/codebase for generic AI patterns and applies craft fixes (layout, interactivity, content, iconography, code quality) without overriding a project's own identity — checks for a `DESIGN.md` first and skips typography/color changes if one exists.
- **Triggers**: "improve the design", "looks generic", "not polished enough", "redesign this", "elevate the UI", "apply taste", design review.

### 32. Taste Skill
- **Path**: `skills/taste-skill/`
- **Purpose**: Anti-slop frontend design for building NEW UI from a brief — brief-first, three configurable dials (variance/motion/density), and an extensive banned-pattern checklist (em-dashes, generic names, fake screenshots, marketing-copy tells) to avoid default-AI output. Defers to an existing `DESIGN.md` when one exists.
- **Triggers**: "build a landing page", "design a portfolio", "make this not look generic/templated/AI-generated", "anti-slop", starting UI work with a brief but no identity yet.

### 33. design-md
- **Path**: `skills/design-md/`
- **Purpose**: Write, read, and apply DESIGN.md files — Google Stitch's open AI-readable design-system format (YAML tokens + Markdown rationale). Covers the spec, canonical section order, and the reverse-engineering process for extracting a brand's visual identity from decks/sites/screenshots into agent-ready tokens.
- **Triggers**: "create a design.md", "extract a design system from...", "document this brand for AI tools", "Stitch design system", reverse-engineering a brand identity.

### 34. AI Product Strategy
- **Path**: `skills/ai-product-strategy/`
- **Purpose**: Decision-focused strategy for products built on LLMs or agents — wedge selection, RAG vs. fine-tuning, non-deterministic UX design, graduated autonomy, and defensibility. Not general product strategy — see `product-strategy` for that.
- **Triggers**: "should this be an agent", "RAG vs fine-tuning", "how much autonomy should this feature have", "is this AI feature defensible", "our AI feature keeps hallucinating and users don't trust it", "AI product wedge", "human-in-the-loop design".

### 35. Design Engineering (emil-design-eng)
- **Path**: `skills/emil-design-eng/`
- **Purpose**: Emil Kowalski's design engineering philosophy — the reference/philosophy layer for interaction craft: animation decision framework, spring configs, component-building principles, CSS transform mastery, performance rules. The 8 skills below (44-51) are the task-specific pieces of this same philosophy.
- **Triggers**: general animation/UI-polish questions, "why does this feel off", reviewing component craft.

### 36. Animation
- **Path**: `skills/animation/`
- **Purpose**: All motion work at one craft bar, in four modes — **build** an animation from scratch (full decision sequence, recipes), **review** a diff against ten non-negotiable standards, **audit** a codebase into prioritized self-contained implementation plans, **discover** what should animate but doesn't (and reject what shouldn't). Restraint is the default; "this shouldn't animate" is a valid result in every mode.
- **Triggers**: "animate this", "add a transition", "make it feel alive", "review the motion", "improve the animations", "audit the motion", "what could be animated here".

### 37. Animation Vocabulary
- **Path**: `skills/animation-vocabulary/`
- **Purpose**: Reverse-lookup glossary — turns a vague motion description ("the bouncy popover thing") into its exact term ("Pop in"), for naming an effect, not building it.
- **Triggers**: "what's it called when...", describing a motion effect without knowing its name.

### 38. Apple Design
- **Path**: `skills/apple-design/`
- **Purpose**: Apple's fluid-interface physics translated for the web — interruptible springs, velocity handoff, momentum projection, rubber-banding, translucent materials, optical typography. Deeper gesture/spring model than `emil-design-eng` covers.
- **Triggers**: gesture-driven UI, spring animations, drag/swipe/sheet interactions, translucent materials, "make this feel like iOS".

### 39. Ask Sonner
- **Path**: `skills/ask-sonner/`
- **Purpose**: Setup, styling, theming, and troubleshooting guide for Sonner (the React toast library) — Toaster placement, promise/loading toasts, the styling escalation ladder, common failure symptoms.
- **Triggers**: working with Sonner, toasts that don't appear/duplicate/lose styles/ignore dark mode.

### 40. Design Lab
- **Path**: `skills/design-lab/`
- **Purpose**: Full design exploration workflow — interview, infer the project's real visual language, generate 5 distinct variants of a component or page, collect real feedback on the rendered route, synthesize, and produce an implementation plan + Design Memory. For exploring a direction that's still open, before writing production code. Auto-triggers, and available as `/design-lab`. Deliberately heavier than `prototype` — that one handles a single component whose direction is already clear.
- **Triggers**: explicit invocation only — "run design-lab", "explore design options for X", "redesign this component/page" when you want the full interview + feedback + plan.

### 41. Prototype
- **Path**: `skills/prototype/`
- **Purpose**: Fast, no-interview variant picker — 3-5 genuinely different versions of one described UI piece, behind a live keyboard-driven picker, flip and promote a winner. Lighter weight than `design-lab`. **Auto-triggers** — Adrian wants this reflexive whenever a new feature, layout, section, visual, or UI decision comes up, not just on request.
- **Triggers**: evaluating a new feature/layout/section/visual/design/UI, "show me a few options for this button/card/toast", any UI decision worth diverging on before settling.

---

### Engineering Discipline (mattpocock/skills)

### 42. Grilling
- **Path**: `skills/grilling/`
- **Purpose**: Short clarifying interview before non-trivial engineering work — surfaces the actual requirement, what's explicitly out of scope, and what proves it's done, before code gets written. The engineering counterpart to `design-md`'s design interview. Operationalizes Engineering #12 in `product-builder-principles.md`.
- **Triggers**: starting a task whose requirement, scope, or definition of done isn't already unambiguous; "let's build X" with no clear spec yet.

### 43. TDD
- **Path**: `skills/tdd/`
- **Purpose**: Red-green-refactor test-driven development discipline — write a failing test at the public interface first, minimal code to pass it, refactor later rather than inside the loop. Mock only at system boundaries. Operationalizes Engineering #13 in `product-builder-principles.md`.
- **Triggers**: writing new logic, fixing a bug (write the regression test first), any code where correctness matters more than raw speed.

### 44. Writing for Agents
- **Path**: `skills/writing-for-agents/`
- **Purpose**: Writing standards for any document an agent consumes — a skill, `CLAUDE.md`/`AGENTS.md`, or a doc reached by a pointer. Context pointers, context load vs. cognitive load, progressive disclosure, leading words, pruning. Operationalizes Engineering #14 in `product-builder-principles.md`.
- **Triggers**: creating or editing a skill, writing/editing `CLAUDE.md` or `AGENTS.md`, any reference doc meant for agent consumption.

### 45. Codebase Design
- **Path**: `skills/codebase-design/`
- **Purpose**: Shared vocabulary for designing deep modules — small interface, lots of behavior behind it. Module/Interface/Seam/Adapter/Depth glossary, the deletion test, the one-vs-two-adapters rule for when a seam is real. Operationalizes Engineering #1 and #10 in `product-builder-principles.md`.
- **Triggers**: designing or improving a module's interface, deciding where a seam belongs, deciding whether to extract or merge modules, making code more testable.

### 46. Domain Modeling
- **Path**: `skills/domain-modeling/`
- **Purpose**: Maintains a project's `CONTEXT.md` glossary and gated ADRs (`docs/adr/`) as decisions get made, not documentation written once and left to rot. Reduced-scope port — single-project only, no `CONTEXT-MAP.md`/bounded contexts. Operationalizes Engineering #14-15 in `product-builder-principles.md`.
- **Triggers**: terminology conflicts or turns fuzzy, a decision that's hard to reverse/surprising/a real trade-off, a stated domain rule that doesn't match what the code does.

### 47. Art Direction
- **Path**: `skills/art-direction/`
- **Purpose**: Sets a new product's visual territory before any font, hex value or screen exists — central idea, drawable visual attributes, cultural references from outside the sector, photographic direction, three divergent typographic/chromatic concepts, and the permanent anti-cliche list. Produces `ART-DIRECTION.md`, the input `design-md` turns into tokens. Slash command: `/art-direction`.
- **Triggers**: a new product or brand with no visual identity yet, an identity being rebuilt from zero, the moment the next step would be picking colors on a blank canvas.

---

## 🔄 Workflow Integration

### Full PM → Engineering → Release Flow

```
STRATEGIZE → SPECIFY → DESIGN → BUILD → REVIEW → HARDEN → DOCUMENT → RELEASE
```

1. **Reframe** → `feature-to-outcome` *(translate stakeholder features into validated outcomes)*
2. **Strategize** → `product-strategy` *(define bets, North Star, OKRs)*
3. **Specify** → `prd-writer` + `product-analytics` *(write the PRD + define success metrics)*
4. **Design** → `art-direction` *(new product with no identity yet)* → `design-md` + `brainstorming`
5. **Build** → `taste-skill` (new UI from the brief) or `taste-redesign` (upgrading existing UI) — or `design-lab`/`prototype` first if the direction itself is still open — + `animation`/`emil-design-eng` for motion + the `vercel` plugin's `react-best-practices` *(React/Next.js)*
6. **Review** → the built-in `code-review` skill or `pr-review-toolkit` agents
7. **Harden** → `error-handling-patterns`
8. **Document** → `maintaining-documentation`
9. **Release** → `changelog-generator` + `deploying-to-github`
10. **Measure** → `product-analytics` *(post-launch impact analysis)*

### Workflows

- `workflows/systematic-debugging/` — Root-cause-first debugging protocol with `/debug` slash command
- `workflows/content-publishing/` — writing-system → edit pass → platform publishing (real publish via Zernio, Gate 3 confirmation required), with `/publish` slash command
