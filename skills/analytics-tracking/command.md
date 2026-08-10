Activates the Analytics Tracking skill to build or audit event instrumentation.

Usage: /tracking [feature or product name]

What it does:
1. Loads the analytics-tracking skill
2. Locks (or confirms) the event naming convention
3. Builds the tracking plan: events, triggers, properties, priority
4. Implements the calls for the tool in use (Amplitude, GA4/GTM, Segment, PostHog)
5. Sets up UTM strategy if campaign traffic matters
6. Runs the validation and privacy checklists
7. Output: docs/analytics/YYYY-MM-DD-[feature]-tracking-plan.md

When to use:
- Setting up tracking for a new product or feature
- Auditing existing tracking that's drifted or inconsistent
- Debugging an event that isn't firing, or is firing wrong
- Translating a product-analytics tracking-plan spec into real event calls

What NOT to use it for:
- Deciding what to measure and why — that's /metrics or the product-analytics skill, use it first
- A/B test statistical design — that's product-analytics' experiment design step

Example: /tracking onboarding flow for [product name]
Example: /tracking audit — our event names are a mess across GA4 and Amplitude
Example: /tracking why isn't the signup_completed event firing
