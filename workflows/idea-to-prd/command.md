Activates the Idea to PRD workflow — validates an idea, designs a solution, and writes a complete PRD.

Usage: /idea [description of idea]

What it does:
1. Loads idea-validator → evaluates market, demand, feasibility, monetization
2. If verdict is "Build it" or "Maybe", loads brainstorming → designs solution with trade-offs
3. Saves design to docs/designs/YYYY-MM-DD-[topic].md
4. Loads prd-writer → writes PRD with problem, metrics, solution, scope, rollout
5. Saves PRD to docs/prd/YYYY-MM-DD-[feature].md
6. Hands off to full-stack-build or planning

When to use:
- Starting any new feature or side project from a raw idea
- When you want to validate before committing time to design or engineering
- When a stakeholder or partner proposes an idea that needs formal evaluation

What NOT to use it for:
- Updating an existing PRD (use /prd directly)
- Urgent bug fixes or hotfixes (skip straight to /debug)
- Pure technical refactors with no user-facing change

Example: /idea AI-powered invoice generator for freelancers
Example: /idea habit tracker with social accountability
Example: /idea add export to CSV feature
