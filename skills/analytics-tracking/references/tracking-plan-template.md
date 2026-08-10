# Tracking Plan Template

Copy-paste starting point for `docs/analytics/YYYY-MM-DD-[feature-or-product]-tracking-plan.md`.

```markdown
# Tracking Plan: [Feature / Product Name]

**Tools:** [e.g. Amplitude, GA4, Segment]
**Naming convention:** [e.g. Title Case, Object-Action — "Order Completed"]
**Owner:** [Name]
**Last updated:** [Date]

## Business Questions This Plan Answers

1. [Question from product-analytics' metric tree]
2. [Question]
3. [Question]

## Events

| Event Name | Trigger | Properties | Priority | Question It Answers |
|---|---|---|---|---|
| | | | Required | |
| | | | Required | |
| | | | Nice-to-have | |

## Standard Properties (reused across events)

| Property | Type | Applies To | Notes |
|---|---|---|---|
| user_id | string | all events | stable identifier |
| session_id | string | all events | for funnel/session analysis |
| | | | |

## Funnel Definitions

### [Funnel name]
Step 1: [Event] → Step 2: [Event] → Step 3: [Event]
Held-constant property: [property present on every step, e.g. product_id]
Success window: [e.g. within 24 hours / same session]

## UTM Parameters in Use

| Source | Medium | Campaign examples |
|---|---|---|
| | | |

## Privacy Notes

- PII fields excluded: [list what's deliberately NOT tracked]
- Consent gating: [where/how tracking is gated on consent, if applicable]

## Validation Status

| Event | Firing correctly | Properties correct | No duplicates | PII check |
|---|---|---|---|---|
| | ☐ | ☐ | ☐ | ☐ |
```
