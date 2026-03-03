---
name: product-analytics
description: Expert product analytics advisor for Senior PMs. Use when defining success metrics for a PRD, designing an A/B experiment, setting up an analytics tracking plan, analyzing post-launch impact, or when data exists but there's no clarity on what to measure. Produces structured metrics frameworks that connect to product decisions, not dashboards.
---

# Product Analytics

This skill turns the vague intent to "be data-driven" into specific, decision-ready metrics frameworks. It covers pre-PRD metric definition, experiment design, tracking plans, and post-launch impact analysis.

## Core Philosophy

**Metrics without decisions are vanity. Every metric needs an owner and a threshold.**

"We'll track engagement" is not a success criterion. "D30 retention ≥55%, measured 30 days post-launch, with a kill switch if D7 drops below 40%" is a success criterion.

Great product analytics:
- Defines metrics before building, not after
- Ties every metric to a decision it will inform
- Names guardrails (what cannot degrade) alongside success criteria
- Makes experiment design boring and rigorous, not exciting and sloppy

**The fatal flaw of bad product analytics**: Beautiful dashboards that nobody uses to make decisions.

## When to use this skill

- **Pre-PRD:** To define success criteria before writing specs (feeds into prd-writer's "Success Measurement" section)
- **Pre-build:** To design an A/B test before writing the first line of code
- **Pre-launch:** To build the analytics tracking plan and instrument events
- **Post-launch:** To analyze impact and decide to iterate, scale, or kill
- **Ad hoc:** When metrics exist but there's no clarity on which ones matter and why

## Key Principles

1. **Decision first** — Every metric answers a decision. "Should we ship this?" "Should we iterate or kill?" "Which variant wins?"
2. **North Star alignment** — Every metric has a clear causal link to the North Star. Metrics that don't tie to value creation are noise.
3. **Guardrails are non-negotiable** — Define what cannot degrade. Ship nothing that violates a guardrail.
4. **Specificity wins** — "≥10% improvement" not "improve." "D30 retention" not "retention."
5. **Fewer metrics, used well** — 3 great metrics > 15 metrics that sit in a dashboard nobody reads.

## Workflow

### Step 1: Goal Clarification

Before defining any metric, answer:

```
Decision to make: [What choice will these metrics help us make?]
Time horizon: [When will we have enough data to decide?]
Stakes: [What's the cost of a false positive? Of a false negative?]
```

Ask the user:
> "When you have the data from this, what decision will you make? And what threshold would change your mind?"

### Step 2: Metric Tree

Build a causal tree from North Star down to measurable signals.

**Format:**
```
North Star: [Metric — measures user value]
│
├── Input Metric 1: [Leading indicator — what drives North Star]
│   ├── Sub-metric A: [More specific signal]
│   └── Sub-metric B: [More specific signal]
│
├── Input Metric 2: [Another leading indicator]
│   └── Sub-metric C: [Specific signal]
│
└── Input Metric 3: [Another leading indicator]
```

**Example:**
```
North Star: Weekly users completing ≥1 core workflow
│
├── Activation: Users completing first workflow within day 1 (D1 activation)
│   ├── Onboarding completion rate
│   └── Time to first action (median, in minutes)
│
├── Retention: Users returning in week 2 (D7 retention)
│   ├── Notification click-through rate
│   └── Session frequency per user per week
│
└── Engagement: Workflows completed per active user per week
    └── Feature adoption rate (% of active users using feature X)
```

### Step 3: Define Success + Guardrail Metrics

For each initiative or experiment:

```
## Success Metrics (what must improve)

| Metric | Current baseline | Target | By when | Owner |
|---|---|---|---|---|
| [Primary metric] | [X] | [Y — specific threshold] | [Date] | [Name] |
| [Secondary metric] | [X] | [Y] | [Date] | [Name] |

## Guardrail Metrics (what cannot degrade)

| Metric | Current | Threshold | Action if violated |
|---|---|---|---|
| [Guardrail 1] | [X] | Must stay ≥ [Y] | Stop and investigate |
| [Guardrail 2] | [X] | Must stay ≤ [Y] | Rollback immediately |

## OEC (Overall Evaluation Criterion)
[If metrics conflict, which one wins? Define the hierarchy.]
"Primary metric takes precedence. If primary improves but [guardrail] is violated, we rollback."
```

### Step 4: Experiment Design (A/B Test)

Use this when testing a specific hypothesis with a control and variant.

**Hypothesis format:**
```
If we [change], then [metric] will [improve/decrease] by [amount],
because [causal mechanism].
```

**Experiment spec:**
```
## Experiment: [Name]

Hypothesis: [Full hypothesis statement]
Primary metric: [Metric — this is what determines winner/loser]
Guardrails: [Metrics that cannot degrade]

Control: [What users see today]
Variant(s): [What we're testing — be specific]

Traffic split: [50/50 / 80/20 / other — and why]
Randomization unit: [User-level / session-level / device-level]
Why this unit: [Prevents contamination because...]

## Sample Size Calculation
Baseline rate: [Current conversion/metric value]
Minimum Detectable Effect (MDE): [Smallest improvement worth detecting — e.g., +5%]
Statistical power: 80% (standard)
Significance level: 5% (p < 0.05)
Required sample: [N users per variant]
Estimated duration: [X days at current traffic levels]

## Decision Criteria
Ship if: Primary metric improves ≥ MDE, p < 0.05, no guardrail violations
Iterate if: Results are directionally positive but underpowered
Kill if: Primary metric doesn't improve, or guardrail violated
```

**Power calculation reference:**
```
Sample size (per variant) ≈ (16 × σ²) / δ²

Where:
σ = standard deviation of the metric
δ = minimum detectable effect (absolute, not relative)

For binary metrics (conversion rates):
n ≈ (2 × p̄(1-p̄)) / δ²   × 8    [for 80% power, 5% significance]

Where p̄ = average conversion rate and δ = MDE
```

### Step 5: Analytics Tracking Plan

Define what to instrument before writing a single line of code.

**Event taxonomy:**
```
[Action]_[Object]_[Context]

Examples:
- button_click_upgrade_pricing_page
- form_submit_onboarding_step2
- feature_activate_dashboard_first_time
- error_display_api_call_failed
```

**Tracking plan format:**

```
## Tracking Plan: [Feature/Experiment Name]

### Events to Instrument

| Event Name | Trigger | Properties | Priority |
|---|---|---|---|
| [event_name] | [When it fires] | [Key properties to capture] | Required/Nice |
| [event_name] | [When it fires] | [Properties] | Required/Nice |

### Properties Reference

User properties (capture once, reuse):
- user_id: [Stable identifier]
- user_segment: [e.g., free / pro / enterprise]
- signup_date: [For cohort analysis]
- [Other stable user attributes]

Event properties (capture per event):
- timestamp: [Always]
- session_id: [For funnel analysis]
- variant: [For A/B tests — always include]
- [Relevant context for this specific event]

### Funnel Definition

Step 1: [Event] → Step 2: [Event] → Step 3: [Event]

Success = reaching Step [N] within [X days/sessions]
```

### Step 6: Post-Launch Analysis

After enough time has passed:

**Analysis checklist:**
```
□ Primary metric: [actual result] vs target [Y] → [Hit / Miss / Underpowered]
□ Statistical significance: p = [value] → [Significant / Not significant]
□ Guardrails: [Status of each guardrail metric]
□ Segment breakdown: [Did results differ by user segment, platform, cohort?]
□ Unexpected signals: [Any metrics that moved that we didn't expect?]
```

**Decision:**
```
## Ship / Iterate / Kill

Decision: [Ship / Iterate / Kill]

Rationale: [2-3 sentences on why, referencing the data]

If shipping:
- Rollout plan: [% → %, timeline, who monitors]
- Monitoring: [What we'll watch for the first 2 weeks post full-ship]

If iterating:
- Hypothesis update: [What we now believe, based on results]
- Next experiment: [What we'll test next]

If killing:
- What we learned: [1-2 key learnings to carry forward]
- What this tells us about the opportunity: [Should we pursue it differently?]
```

### Step 7: Output

Save the metrics framework:
```
docs/analytics/YYYY-MM-DD-[feature-or-topic]-metrics.md
```

## Output Format

```markdown
# Metrics Framework: [Feature / Initiative]

**Owner:** [Name]
**Date:** [YYYY-MM-DD]
**Status:** Pre-launch / Active experiment / Post-launch analysis

## Decision to Make
[What choice will these metrics inform?]

## Metric Tree
[North Star → Input Metrics → Sub-metrics — causal tree]

## Success Metrics
[Table: metric, baseline, target, date, owner]

## Guardrail Metrics
[Table: metric, baseline, threshold, action if violated]

## Experiment Design (if applicable)
[Hypothesis, control, variant, traffic split, sample size, duration, decision criteria]

## Tracking Plan
[Events, properties, funnel definition]

## Post-Launch Analysis (to fill after launch)
[Results vs targets, decision, learnings]
```

## Quality Checklist

Before shipping metrics framework:

**Clarity**
- [ ] Primary metric is specific (number, direction, by when)
- [ ] Guardrail metrics defined with clear thresholds
- [ ] OEC defined if metrics could conflict

**Rigor**
- [ ] Sample size calculated before starting experiment
- [ ] Randomization unit chosen to prevent contamination
- [ ] Duration estimated at current traffic levels

**Actionability**
- [ ] Decision criteria written before data is collected (to prevent p-hacking)
- [ ] Owner named for each metric
- [ ] Ship / iterate / kill thresholds defined in advance

**Tracking**
- [ ] All required events listed in tracking plan
- [ ] Event naming follows [action]_[object]_[context] convention
- [ ] Experiment variant property included in all relevant events

## Common Antipatterns

### Antipattern 1: Metric Theater
**Symptom**: "We'll track engagement, satisfaction, retention, and revenue" — tracking everything, deciding nothing
**Fix**: Name the ONE primary metric that determines success. Secondary metrics are context, not decision drivers.

### Antipattern 2: Post-hoc Metric Selection
**Symptom**: Running an experiment, then choosing metrics that show positive results
**Fix**: Lock metrics and decision criteria before data collection. Write them down with a timestamp.

### Antipattern 3: Statistical Significance Without Practical Significance
**Symptom**: "We got p=0.03! Shipping it!" — even though the effect size is tiny
**Fix**: Define MDE (Minimum Detectable Effect) before the experiment. If the detected effect is smaller than MDE, it's not practically significant regardless of p-value.

### Antipattern 4: Ignoring Guardrails
**Symptom**: Primary metric improved, but support tickets spiked — ship anyway
**Fix**: Guardrails are non-negotiable. If violated, stop. Define them first so you can't rationalize around them later.

### Antipattern 5: Dashboard Without Decisions
**Symptom**: Beautiful Amplitude/Mixpanel dashboard, no product decisions ever made from it
**Fix**: For every metric on the dashboard, write the decision it informs and the threshold that would trigger action. If you can't, remove it from the dashboard.

## Reference Resources

- `references/metrics-template.md` — Metrics framework template (copy-paste ready)
- `references/tracking-plan-template.md` — Analytics tracking plan with event taxonomy
