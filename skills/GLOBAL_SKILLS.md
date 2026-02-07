# Global Antigravity Skills

This repository serves as the central hub for reusable agentic skills. These skills are designed to be portable and automatically discoverable by AI agents like Antigravity and Claude Code.

## 🛠 Active Skills

### 1. Brainstorming
- **Path**: `skills/brainstorming/`
- **Purpose**: Socratic discovery and technical design.
- **Triggers**: vague ideas, architectural changes, complex tasks.

### 2. Planning
- **Path**: `skills/planning/`
- **Purpose**: Atomic, TDD-focused implementation plans.
- **Triggers**: spec-ready features, plan generation.

### 3. Brand Identity
- **Path**: `skills/brand-identity/`
- **Purpose**: Single Source of Truth for design, tech stack, and voice.
- **Triggers**: UI generation, styling, copywriting.

### 4. Error Handling Patterns
- **Path**: `skills/error-handling-patterns/`
- **Purpose**: Robust strategies for resilient applications.
- **Triggers**: API design, reliability improvements, debugging.

### 5. React Best Practices
- **Path**: `skills/react-best-practices/`
- **Purpose**: Performance optimization for React and Next.js.
- **Triggers**: component creation, layout shifts, bundle optimization.

### 6. Changelog Generator
- **Path**: `skills/changelog-generator/`
- **Purpose**: Technical-to-User-friendly release notes.
- **Triggers**: releases, weekly updates, customer comms.

### 7. Codebase Documenter
- **Path**: `skills/codebase-documenter/`
- **Purpose**: Creating beginner-friendly docs and architecture guides.
- **Triggers**: README updates, documentation audits.

### 8. Frontend Design
- **Path**: `skills/frontend-design/`
- **Purpose**: Create distinctive, production-grade frontend interfaces.
- **Triggers**: UI components, visual polish, web apps.

### 9. Interface Design
- **Path**: `skills/interface-design/`
- **Purpose**: Craft intentional interfaces for dashboards and SaaS.
- **Triggers**: SaaS apps, dashboards, admin panels.

### 10. Creating Skills
- **Path**: `skills/creating-skills/`
- **Purpose**: Meta-skill for generating new standardized skills.
- **Triggers**: "Build me a skill for X".

### 11. Deploying to GitHub
- **Path**: `skills/deploying-to-github/`
- **Purpose**: Automates version control workflows and pushes.
- **Triggers**: saving changes, pushing code, git operations.

### 12. Requesting Code Review
- **Path**: `skills/requesting-code-review/`
- **Purpose**: Superpowers:code-reviewer subagent for early issue detection.
- **Triggers**: PR review, feature completion, pre-commit check.

### 13. Running Inventory Tasks
- **Path**: `skills/running-inventory-tasks/`
- **Purpose**: Manages LALIGA advertising inventory and metrics.
- **Triggers**: inventory forecast, impressions, product capacity.

## 🔄 Workflow Integration
1.  **Ideate** → `brainstorming`
2.  **Plan** → `planning`
3.  **Build** → `react-best-practices` + `brand-identity` + `frontend-design` + `interface-design`
4.  **Review** → `requesting-code-review`
5.  **Harden** → `error-handling-patterns`
6.  **Document** → `codebase-documenter`
7.  **Release** → `changelog-generator` + `deploying-to-github`
