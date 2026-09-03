Activates Product Analytics on the measurement side — what to measure and whether it worked.

Usage: /metrics [feature name or analytical question]

What it does:
1. Loads the product-analytics skill, Part 1 and Part 4
2. Asks what decision the data will inform, what's available, and whether this is
   experiment design or post-hoc analysis
3. Builds the metric tree (North Star → input metrics → sub-metrics), or an A/B
   design with sample size, MDE, and ship/iterate/kill criteria
4. Names guardrails — what cannot degrade — with the action if violated
5. Output: docs/analytics/YYYY-MM-DD-[feature]-metrics.md

When to use:
- Defining success criteria before a feature is built (feeds prd-writer)
- Designing an experiment before the first line of code
- Analyzing impact after launch to decide ship / iterate / kill
- Data exists but nobody knows which numbers matter

For the instrumentation side — naming events, building the tracking plan, tagging
a flow, debugging events that don't fire — use `/tracking`. Same skill, other half.
