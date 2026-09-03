Activates Product Analytics on the instrumentation side — defining, naming, and
shipping events.

Usage: /tracking [feature or flow — "onboarding", "the export feature"]

What it does:
1. Loads the product-analytics skill, Parts 2, 3 and 5
2. Confirms the naming standard: lowercase snake_case, object first, action second
   (`order_completed`), Title Case in the Amplitude UI only
3. Builds the tracking plan — events, triggers, properties, priority — with every
   event traced to a business question
4. Identifies the held-constant property each funnel needs, so funnel analysis
   doesn't silently break
5. Writes the actual calls for the tool in use (Amplitude, GA4/GTM, Segment, PostHog),
   matching any instrumentation pattern already in the codebase
6. Runs the validation and privacy checklists before calling it done
7. Output: docs/analytics/YYYY-MM-DD-[feature]-tracking-plan.md

When to use:
- Tagging onboarding, or any new feature
- First analytics setup for a product
- Auditing tracking that has drifted — inconsistent names, mismatched properties
- An event isn't firing, fires twice, or arrives with undefined properties

For the measurement side — metric trees, guardrails, experiment design, post-launch
analysis — use `/metrics`. Same skill, other half.
