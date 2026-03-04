Activates the PRD Writer skill for a specific feature or product.

Usage: /prd [feature name or brief description]

What it does:
1. Loads the prd-writer skill
2. Asks: current stage (planning / kickoff / solution review), feature type (UI / AI / infrastructure), and whether existing documentation is available
3. Guides you through the 5-stage PRD evolution: Opportunity → Hypothesis → Solution → Spec → Handoff
4. Produces a structured PRD document in docs/prd/YYYY-MM-DD-[feature].md

When to use:
- Before engineering starts on any non-trivial feature
- When you need to align stakeholders on what you're building and why
- When a feature spans multiple sprint cycles and needs a living document

What NOT to use it for:
- Bug fixes (write a ticket, not a PRD)
- Minor UI copy changes (just do it)

Example: /prd user onboarding flow
Example: /prd AI-powered search
Example: /prd subscription billing upgrade
