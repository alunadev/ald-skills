# Metrics Framework Template

> Copy this template for every new initiative. Fill in BEFORE writing code or specs.

---

# Metrics Framework: [Feature / Initiative Name]

**Owner:** [Name]
**Date:** [YYYY-MM-DD]
**PRD link:** [Link to related PRD, if exists]
**Status:** `Pre-launch` / `Active Experiment` / `Post-Launch Analysis`

---

## Decision to Make

> [What specific product decision will these metrics help us make?]
> [Example: "Should we ship the new onboarding flow to all users?"]

**Threshold that would change our decision:**
> [Example: "If D7 retention doesn't improve by ≥5pp, we won't ship."]

---

## North Star Connection

**North Star:** [Metric name — should already be defined in product strategy]
**How this initiative affects it:** [One sentence causal link]
**Input metric most likely to move:** [The leading indicator closest to this feature]

---

## Metric Tree

```
North Star: [Metric]
│
├── Input Metric (primary target): [Metric] — current: [X]
│   ├── Sub-metric A: [Metric] — current: [X]
│   └── Sub-metric B: [Metric] — current: [X]
│
└── Input Metric (secondary): [Metric] — current: [X]
```

---

## Success Metrics

*What must improve for this initiative to be considered successful.*

| Metric | Baseline | Target | By When | Owner | Priority |
|---|---|---|---|---|---|
| [Primary metric] | [X] | [Y — specific, not "improve"] | [Date] | [Name] | Primary |
| [Secondary metric] | [X] | [Y] | [Date] | [Name] | Secondary |

**Primary metric definition:**
- **What it measures:** [Exact definition]
- **How it's measured:** [Tool, query, calculation]
- **Frequency:** [Daily / Weekly / Cohort-based]
- **Exclusions:** [Who/what is excluded from this metric]

---

## Guardrail Metrics

*Metrics that cannot degrade. If violated, stop and investigate.*

| Metric | Current | Threshold | Violation Action |
|---|---|---|---|
| [Guardrail 1] | [X] | Must stay ≥ [Y] | Pause rollout + investigate |
| [Guardrail 2] | [X] | Must stay ≤ [Y] | Rollback immediately |
| [Guardrail 3] | [X] | Must not drop by > [Z%] | Alert + 24h window to recover |

---

## OEC (Overall Evaluation Criterion)

*When metrics conflict, this is the tiebreaker.*

> [Example: "Primary metric (D30 retention) takes precedence. If it improves but page load time guardrail is violated, we rollback and optimize performance first."]

---

## Experiment Design *(if A/B testing)*

**Hypothesis:**
> If we [change], then [primary metric] will [improve/decrease] by [amount] because [causal mechanism].

| Field | Value |
|---|---|
| Control | [What users see today] |
| Variant(s) | [What we're testing — be specific] |
| Traffic split | [50/50 / 80/20 / other] |
| Randomization unit | [User-level / session-level / device-level] |
| Reason for this unit | [Why this prevents contamination] |

**Sample Size:**

| Field | Value |
|---|---|
| Baseline rate | [Current value of primary metric] |
| MDE (Minimum Detectable Effect) | [Smallest improvement worth detecting] |
| Statistical power | 80% |
| Significance level | p < 0.05 |
| Required sample (per variant) | [N] |
| Estimated duration at current traffic | [X days] |

**Decision Criteria** *(set before data collection — no changes allowed after)*:

| Outcome | Action |
|---|---|
| Primary metric improves ≥ MDE, p < 0.05, guardrails ok | **Ship** |
| Positive direction but underpowered | **Extend experiment or iterate** |
| No improvement, p > 0.05 | **Kill — learn and move on** |
| Any guardrail violated | **Stop immediately — investigate** |

---

## Tracking Plan

**Event naming convention:** `[action]_[object]_[context]`

### Required Events

| Event Name | Trigger | Key Properties |
|---|---|---|
| [event_name] | [When it fires] | variant, user_segment, timestamp |
| [event_name] | [When it fires] | [Properties] |

### User Properties (attach to all events)

| Property | Description |
|---|---|
| user_id | Stable identifier |
| user_segment | free / pro / enterprise |
| signup_date | For cohort analysis |
| variant | A/B test assignment (for experiments) |

### Funnel Definition

```
Step 1: [event_name] — [what it means]
Step 2: [event_name] — [what it means]
Step 3: [event_name] — [success state]

Conversion = reaching Step 3 within [X days] of Step 1
```

---

## Post-Launch Analysis *(fill in after launch)*

**Analysis date:** [YYYY-MM-DD]
**Data window:** [From X to Y — N days of data]

### Results

| Metric | Baseline | Result | Delta | Significant? |
|---|---|---|---|---|
| [Primary] | [X] | [Y] | [+/-Z%] | Yes / No (p=[val]) |
| [Secondary] | [X] | [Y] | [+/-Z%] | Yes / No |
| [Guardrail 1] | [X] | [Y] | [+/-Z%] | OK / VIOLATED |

### Segment Breakdown *(did different users behave differently?)*

| Segment | Primary Metric | Notes |
|---|---|---|
| [Segment 1] | [Result] | [Insight] |
| [Segment 2] | [Result] | [Insight] |

### Decision

**Decision:** `Ship` / `Iterate` / `Kill`

**Rationale:**
> [2-3 sentences. Reference the data, the decision criteria set in advance, and trade-offs.]

**If shipping:**
- Rollout plan: [% now → % in X days]
- Monitoring: [Who watches what for the first 2 weeks]
- PRD update: [Link to updated PRD with results]

**If iterating:**
- Hypothesis update: [What we now believe]
- Next test: [What we'll try next and why]

**If killing:**
- Key learning: [What this told us about the user need]
- Opportunity re-assessment: [Should we pursue this differently?]

---

## HEART Framework *(optional — for user experience initiatives)*

Google's HEART framework — useful when the primary success measure is qualitative or experience-based.

| Dimension | Metric | Baseline | Target | Method |
|---|---|---|---|---|
| **H**appiness | [NPS / CSAT / In-product sentiment] | [X] | [Y] | Survey |
| **E**ngagement | [Sessions, actions per user] | [X] | [Y] | Analytics |
| **A**doption | [% active users using feature] | [X] | [Y] | Analytics |
| **R**etention | [D7/D30 return rate] | [X] | [Y] | Analytics |
| **T**ask Success | [Completion rate, error rate] | [X] | [Y] | Analytics |

*Use 2-3 dimensions max. You don't need all 5 for every initiative.*
