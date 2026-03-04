Activates the Product Analytics skill for a feature or question.

Usage: /metrics [feature name or analytical question]

What it does:
1. Loads the product-analytics skill
2. Asks: what decision needs to be made, what data is available, and whether this is an experiment design or a post-hoc analysis
3. Builds a metric tree (North Star → L1 → L2 metrics) or an A/B experiment design with sample size and duration
4. Output: docs/analytics/YYYY-MM-DD-[feature]-metrics.md or experiment design doc

When to use:
- When defining success criteria for a feature before launch
- When designing an A/B test (sizing, variants, guardrail metrics)
- When doing post-launch analysis ("did this feature work?")
- When building a tracking plan for a new feature

What NOT to use it for:
- Qualitative research (use /discovery instead)
- Business-level financial modeling (that's FP&A territory)

Example: /metrics did the new checkout flow improve conversion?
Example: /metrics design an A/B test for the onboarding email
Example: /metrics what metrics should I track for the new notifications feature?
