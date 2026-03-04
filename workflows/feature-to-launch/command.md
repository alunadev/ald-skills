Activates the Feature to Launch workflow — builds a feature end-to-end and launches it publicly.

Usage: /feature-launch [feature name]

What it does:
1. Verifies PRD exists with success metrics defined (docs/prd/)
2. Runs full-stack-build workflow: API design → DB schema → frontend → deploy
3. Waits for Gate 2: feature live on production + monitoring active
4. Runs changelog-generator: transforms commits into user-facing release notes
5. Runs product-launch: GTM brief, readiness checklists, rollout gates
6. Produces: docs/features/ + docs/launches/ with T+7 and T+30 review dates scheduled

When to use:
- When a PRD is approved and you're ready to build and ship
- For any feature that needs a coordinated launch (not just a silent deploy)
- When you want the complete build → changelog → launch cycle with no steps skipped

What NOT to use it for:
- Hotfixes and urgent patches (deploy directly, write brief changelog)
- Features without a PRD (run /idea first)
- Internal tooling with no user-facing launch

Prerequisite: A completed PRD in docs/prd/YYYY-MM-DD-[feature].md with:
- Problem statement + target user
- Success metrics (at least 1 with target value)
- Solution overview
- Scope: in / out
- Rollout plan

Example: /feature-launch user invite system
Example: /feature-launch export to CSV
Example: /feature-launch subscription billing
