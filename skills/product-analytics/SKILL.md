---
name: product-analytics
description: >
  Everything analytics for a product: what to measure, how to name and define events, how to
  instrument a flow, how to design an experiment, and how to debug tracking that isn't firing.
  Amplitude is the reference standard. Use when defining success metrics for a PRD, building a
  tracking plan, tagging onboarding or a new feature, designing an A/B test, analyzing
  post-launch impact, or when an event isn't showing up where it should.
---

# Product Analytics

One skill for the whole analytics loop — from "what should we measure?" through "why isn't this
event firing?". It replaces the earlier split between metric definition and tracking
implementation, because in practice those are the same conversation held twice.

## The naming standard — locked

**Amplitude is the reference.** Every project follows this unless it already has shipped events
in another convention, in which case match what exists rather than introducing a second style.

| Where | Form | Example |
|---|---|---|
| In code, SDK calls, the data layer, the warehouse | lowercase `snake_case` | `order_completed` |
| In the Amplitude UI, dashboards, docs written for people | Title Case | `Order Completed` |

**Object first, action second.** The object stays constant while the verb varies — never both.

```
[object]_[action]           order_completed, product_viewed, checkout_started
[object]_[action]_[context] onboarding_step_completed   ← only when context changes the meaning
```

Context belongs in a **property**, not the name, unless the two paths are genuinely different
funnels you would analyze separately. `order_completed` with `payment_method: apple_pay` — not
`apple_pay_order_completed`.

Actor perspective is always the user's: `message_sent` means the user sent it, not that the
system did.

## Which part do you need?

| You're asking | Go to |
|---|---|
| What should we measure for this product or feature? | Part 1 — What to measure |
| How do I define and name the events? | Part 2 — Event taxonomy |
| How do I tag onboarding? How do I tag this new feature? | Part 3 — Instrumenting a flow |
| Did it work? Should we ship, iterate, or kill? | Part 4 — Experiments and post-launch |
| Why isn't my event firing / firing twice / missing properties? | Part 5 — Validate and debug |

## Core philosophy

**Metrics without decisions are vanity. A taxonomy nobody can maintain is worse than none.**

"We'll track engagement" is not a success criterion. "D30 retention ≥55%, measured 30 days
post-launch, with a kill switch if D7 drops below 40%" is one.

And the biggest failure in implementation isn't missing events — it's inconsistent ones. Two
teams shipping `Song Played` and `song_played` for the same intended event produce two separate,
unreconcilable streams.

The two fatal flaws, stated plainly: a beautiful dashboard nobody makes decisions from, and a
dashboard technically full of data that nobody trusts enough to build on.

## Key principles

1. **Decision first** — every metric answers a decision. "Should we ship?" "Which variant wins?"
2. **North Star alignment** — every metric has a causal link to the North Star. The rest is noise.
3. **Guardrails are non-negotiable** — define what cannot degrade. Ship nothing that violates one.
4. **Specificity wins** — "D30 retention ≥55%" not "improve retention."
5. **Fewer metrics, used well** — 3 great metrics beat 15 nobody reads.
6. **Decide the convention before the second event** — retrofitting a naming convention across a
   live taxonomy is expensive. The standard above settles it; document it in the project.
7. **Properties on the event, context in the name only when it changes meaning** — see the
   standard above.
8. **No more than ~20 properties per event** — past that it's probably two events.
9. **Resist tracking everything** — every event traces to a business question someone will ask.
   Untraceable events bury the ones that matter.

---

# Part 1 — What to measure

### Step 1: Goal clarification

Before defining any metric:

```
Decision to make: [What choice will these metrics help us make?]
Time horizon: [When will we have enough data to decide?]
Stakes: [Cost of a false positive? Of a false negative?]
```

Ask the user:
> "When you have this data, what decision will you make? And what threshold would change your mind?"

### Step 2: Metric tree

Build a causal tree from North Star down to measurable signals.

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
└── Feature adoption rate (% of active users using feature X)
```

### Step 2b: Cohort analysis (optional — retention and lifecycle)

Use when behavior changes over time across user groups, or when diagnosing declining retention.

**When to run it:**
- Retention is dropping — is it all cohorts or one?
- Measuring whether a change improved long-term retention
- Comparing behavior by acquisition channel, pricing tier, or onboarding variant

**Define the cohort:**
```
Cohort dimension: [Time: signup week/month | Behavior: completed X | Attribute: from source Y]
Metric: [What you're tracking per cohort over time]
Time periods: [D1 / D7 / D30 / D90 — based on the product's natural frequency]
```

**Retention table:**
```
| Cohort   | Size  | D1  | D7  | D30 | D90 |
|----------|-------|-----|-----|-----|-----|
| Jan 2026 | 1,200 | 68% | 45% | 32% | 21% |
| Feb 2026 |   980 | 71% | 48% | 35% |  —  |
| Mar 2026 | 1,450 | 74% | 51% |  —  |  —  |
```

**Reading it:**
- Columns trending up across cohorts → product improvements are working
- One cohort underperforms → investigate that acquisition batch or onboarding period
- All cohorts drop at the same period → structural drop-off; fix the product moment, not the cohort

**Diagnostic questions:**
1. Which cohort performs best? What was different about its acquisition or onboarding?
2. At which period is the biggest drop-off? What product experience does that correspond to?
3. Are recent cohorts trending better or worse? (Leading indicator of product health.)

**Output block:**
```
## Cohort Analysis: [Feature / Time Period]

Cohort dimension: [What defines each cohort]
Metric: [What we're tracking]

| Cohort | Size | [Period 1] | [Period 2] | [Period 3] | [Period 4] |
|---|---|---|---|---|---|

### Key Findings
1. [Finding — specific]

### Decision Implication
[What this tells us and what action it drives]
```

### Step 3: Success and guardrail metrics

```
## Success Metrics (what must improve)

| Metric | Current baseline | Target | By when | Owner |
|---|---|---|---|---|
| [Primary metric] | [X] | [Y — specific threshold] | [Date] | [Name] |

## Guardrail Metrics (what cannot degrade)

| Metric | Current | Threshold | Action if violated |
|---|---|---|---|
| [Guardrail 1] | [X] | Must stay ≥ [Y] | Stop and investigate |
| [Guardrail 2] | [X] | Must stay ≤ [Y] | Rollback immediately |

## OEC (Overall Evaluation Criterion)
[If metrics conflict, which wins?]
"Primary metric takes precedence. If primary improves but [guardrail] is violated, we rollback."
```

---

# Part 2 — Event taxonomy

### Build the tracking plan

Structure every event identically, so the plan is scannable and diffable:

```
| Event Name | Trigger | Properties | Priority |
|---|---|---|---|
| [event_name] | [Exact user action that fires it] | [Required properties] | Required / Nice-to-have |
```

**For each event, ask:**
- What business question does this answer? If there isn't one, don't track it.
- One event with a distinguishing property, or genuinely separate events? Prefer one event plus a
  property unless the paths are distinct funnels worth analyzing independently.
- Are the properties this event needs present on **every other event in the same funnel**? A
  property that holds a funnel step constant (e.g. `product_id` linking `product_viewed` →
  `product_added`) must appear on every event in the chain, or funnel analysis silently breaks.

**Standard property categories** — reuse these, don't reinvent per event:

```
User:      user_id, user_type, plan_tier, signup_date
Page:      page_title, page_location, referrer
Campaign:  utm_source, utm_medium, utm_campaign, utm_content, utm_term
Object:    object_id, object_type, category, price
Experiment: variant   ← always include on events inside a running experiment
```

Property names are `snake_case` too. Keep them specific: `item_type` and `payment_type`, never a
shared generic `type`.

For starting event lists by product type (general site, ecommerce, B2B/SaaS, media, healthcare,
gaming), see `references/event-library.md`.

---

# Part 3 — Instrumenting a flow

### Worked example: tagging onboarding

Onboarding is a funnel, so the events must share a held-constant property or the funnel breaks.

```
| Event Name                  | Trigger                          | Properties                        |
|-----------------------------|----------------------------------|-----------------------------------|
| onboarding_started          | First onboarding screen renders  | onboarding_id, entry_point        |
| onboarding_step_completed   | User advances a step             | onboarding_id, step_number, step_name |
| onboarding_step_skipped     | User skips a skippable step      | onboarding_id, step_number, step_name |
| onboarding_completed        | Final step submitted             | onboarding_id, duration_seconds, steps_skipped |
| onboarding_abandoned        | Session ends mid-flow            | onboarding_id, last_step_number   |
```

`onboarding_id` is the held-constant property — it appears on **every** event above. Without it
you cannot tell whether the user who completed step 3 is the one who abandoned at step 4.

Note what is *not* here: five separate `onboarding_step_1_completed`, `..._step_2_completed`
events. Step number is a property. That single decision is the difference between a funnel you
can slice and a taxonomy you have to rewrite next quarter.

### Worked example: tagging a new feature

1. **Name the question first.** "Do users who use [feature] retain better?" — not "let's track
   the feature."
2. **Find the minimum event set that answers it.** Usually: discovered → activated → used again.
   ```
   feature_viewed      → the entry point rendered
   feature_activated   → first meaningful use
   feature_used        → subsequent uses, with a `use_count` property
   ```
3. **Add the held-constant property** linking them (`feature_id`, or the object the feature acts on).
4. **Add `variant`** if this ships behind an experiment.
5. **Check it against Part 1's metric tree** — if an event doesn't feed a metric in the tree,
   it doesn't ship.

### Implement

Pick the path that matches the stack. Don't reach for GTM if there's no tag-management need, and
don't hand-roll SDK calls if GTM is already the org standard.

**Amplitude (the reference):**
```js
amplitude.track('order_completed', {
  payment_method: 'credit_card',
  order_value: 49.99,
  item_count: 3,
});
```

**GA4 via gtag.js:**
```js
gtag('event', 'order_completed', {
  payment_method: 'credit_card',
  value: 49.99,
  items: 3,
});
```

**Google Tag Manager (data layer):**
```js
dataLayer.push({
  event: 'order_completed',
  payment_method: 'credit_card',
  order_value: 49.99,
});
```

**If the codebase already has an analytics wrapper or prior instrumentation**, read it first and
match its patterns rather than introducing a new call style — a second pattern in the same
codebase recreates the exact inconsistency this skill exists to prevent.

**Repo-level convention file** — recommended once more than a couple of people instrument events.
Keep the rules checked in, e.g. `.agents/analytics-conventions.md`, so every future pass (human or
agent) starts from the same rules:

```markdown
# Analytics conventions

## Naming
- Events: lowercase snake_case, object_action (`order_completed`)
- Displayed in Amplitude as Title Case (`Order Completed`)
- Properties: snake_case

## Required properties
[the held-constant properties per funnel]

## Tool
[Amplitude / GA4 / Segment / PostHog — and which is the source of truth]
```

### UTM strategy (if paid or campaign traffic matters)

```
| Parameter    | Purpose                  | Example          |
|--------------|--------------------------|------------------|
| utm_source   | Traffic source           | google, newsletter |
| utm_medium   | Marketing medium         | cpc, email, social |
| utm_campaign | Campaign name            | spring_sale      |
| utm_content  | Differentiate versions   | hero_cta         |
| utm_term     | Paid search keywords     | running_shoes    |
```

Lowercase everything, pick underscores or hyphens and stay consistent, be specific but concise
(`blog_footer_cta`, not `cta1`). Document every combination in use somewhere a teammate can find
it — undocumented UTMs are exactly as bad as undocumented event names.

---

# Part 4 — Experiments and post-launch

### Experiment design (A/B test)

**Hypothesis format:**
```
If we [change], then [metric] will [improve/decrease] by [amount],
because [causal mechanism].
```

**Experiment spec:**
```
## Experiment: [Name]

Hypothesis: [Full hypothesis statement]
Primary metric: [What determines winner/loser]
Guardrails: [Metrics that cannot degrade]

Control: [What users see today]
Variant(s): [What we're testing — be specific]

Traffic split: [50/50 / 80/20 — and why]
Randomization unit: [User / session / device]
Why this unit: [Prevents contamination because...]

## Sample Size Calculation
Baseline rate: [Current value]
Minimum Detectable Effect (MDE): [Smallest improvement worth detecting — e.g. +5%]
Statistical power: 80% (standard)
Significance level: 5% (p < 0.05)
Required sample: [N users per variant]
Estimated duration: [X days at current traffic]

## Decision Criteria
Ship if: Primary metric improves ≥ MDE, p < 0.05, no guardrail violations
Iterate if: Directionally positive but underpowered
Kill if: Primary doesn't improve, or a guardrail is violated
```

**Power calculation reference:**
```
Sample size (per variant) ≈ (16 × σ²) / δ²

σ = standard deviation of the metric
δ = minimum detectable effect (absolute, not relative)

For binary metrics (conversion rates):
n ≈ (2 × p̄(1-p̄)) / δ²  × 8    [80% power, 5% significance]

p̄ = average conversion rate, δ = MDE
```

Every event inside a running experiment carries the `variant` property. Without it the experiment
is unanalyzable after the fact.

### Post-launch analysis

```
□ Primary metric: [actual] vs target [Y] → [Hit / Miss / Underpowered]
□ Statistical significance: p = [value] → [Significant / Not]
□ Guardrails: [Status of each]
□ Segment breakdown: [Did results differ by segment, platform, cohort?]
□ Unexpected signals: [Metrics that moved that we didn't expect]
```

**Decision:**
```
## Ship / Iterate / Kill

Decision: [Ship / Iterate / Kill]
Rationale: [2-3 sentences, referencing the data]

If shipping:
- Rollout plan: [% → %, timeline, who monitors]
- Monitoring: [What to watch for the first 2 weeks post full-ship]

If iterating:
- Hypothesis update: [What we now believe]
- Next experiment: [What we'll test]

If killing:
- What we learned: [1-2 learnings to carry forward]
- What this says about the opportunity: [Pursue it differently?]
```

---

# Part 5 — Validate and debug

Validation is part of "done", not a follow-up task.

```
□ Event fires on the correct trigger — not early, not late, not on every render
□ Property values populate correctly (not undefined, not the wrong type)
□ No duplicate firing (double-mounted listeners, multiple containers)
□ Fires across the platforms it needs to (desktop/mobile, supported browsers)
□ No PII in event properties (names, emails, free-text fields especially)
□ Conversion events marked as conversions in the tool, if applicable
```

**Debugging tools:**

| Tool | Use for |
|---|---|
| Amplitude live event stream / Chrome extension | Inspect events as they fire, verify properties |
| GA4 DebugView | Real-time event monitoring during implementation |
| GTM Preview Mode | Test triggers and variables before publishing |
| Browser devtools network tab | Confirm the call actually leaves the browser |

**Common issues:**

| Symptom | Check first |
|---|---|
| Event not firing at all | Trigger configuration; script/tag actually loaded on the page |
| Wrong or missing property values | Data-layer path; timing (property read before the value is set) |
| Duplicate events | Multiple containers/SDKs initialized, or a trigger firing on every re-render |
| Funnel not connecting steps | The held-constant property is missing on one event in the chain |

### Privacy and compliance

```
□ Cookie/tracking consent required in EU/UK/California — gate tracking on consent
□ No PII in event or user properties — use IDs and pseudonymous values
□ Data retention settings match policy
□ Users can request deletion — confirm the tool supports it before it's needed
```

Wire consent state into the SDK or tag manager (most tools have a consent mode that queues or
blocks tracking until consent is granted) rather than bolting privacy on after the taxonomy exists.

---

## Output

```
docs/analytics/YYYY-MM-DD-[feature]-metrics.md          ← Part 1 / Part 4 output
docs/analytics/YYYY-MM-DD-[feature]-tracking-plan.md    ← Part 2 / Part 3 output
```

Both templates are in `references/`. Small features can use a single combined document; keep them
separate once the tracking plan spans more than one feature.

## Quality checklist

**Measurement**
- [ ] Primary metric is specific (number, direction, by when)
- [ ] Guardrails defined with thresholds and an action if violated
- [ ] OEC defined if metrics could conflict
- [ ] Decision criteria written *before* data collection (prevents p-hacking)
- [ ] Owner named for each metric

**Taxonomy**
- [ ] Every event name is lowercase `snake_case`, object first, action second
- [ ] No event duplicated with different casing or word order anywhere in the codebase
- [ ] Every event traces to a business question
- [ ] Held-constant properties present on every event in each funnel
- [ ] No more than ~20 properties on any event
- [ ] `variant` present on every event inside a running experiment

**Rigor**
- [ ] Sample size calculated before starting
- [ ] Randomization unit chosen to prevent contamination
- [ ] Duration estimated at current traffic

**Implementation**
- [ ] Matches existing instrumentation patterns in the codebase, if any
- [ ] No duplicate firing (checked in the live event stream / DebugView / Preview Mode)
- [ ] No PII in any property; consent respected where required

## Common antipatterns

**Metric theater** — "We'll track engagement, satisfaction, retention, and revenue." Tracking
everything, deciding nothing. → Name the ONE primary metric that determines success.

**Post-hoc metric selection** — running the experiment, then choosing metrics that look good. →
Lock metrics and decision criteria before data collection, with a timestamp.

**Significance without practical significance** — "p=0.03, ship it!" on a trivial effect. →
Define MDE first. Smaller than MDE isn't practically significant, whatever the p-value.

**Ignoring guardrails** — primary metric improved, support tickets spiked, ship anyway. →
Guardrails are non-negotiable. Define them first so you can't rationalize around them later.

**Dashboard without decisions** — a beautiful Amplitude dashboard nobody has ever decided from. →
For every metric on it, write the decision it informs and the threshold that triggers action. If
you can't, remove it.

**Two conventions, one codebase** — `Order Completed` and `order_completed` both live, sent by
different features. → The standard at the top of this file settles it. Migrate the outlier; never
add a third style to "fix" it.

**One event, many clones** — `apple_pay_order_completed`, `credit_card_order_completed`. → One
`order_completed` with a `payment_method` property.

**Tracking everything** — every click and hover, "in case it's useful later." → If nobody can name
the question it answers, don't ship the event.

**Shipping without validation** — events go live, nobody checks, three weeks later half fire twice
or carry `undefined`. → Run the Part 5 checklist before merging.

**PII in properties** — a property captures a raw email, full name, or free-text field. → IDs and
pseudonymous values. If analysis genuinely needs PII, it belongs in a separately governed system.

## Reference resources

- `references/metrics-template.md` — metrics framework template (copy-paste ready)
- `references/tracking-plan-template.md` — tracking plan template
- `references/event-library.md` — starting event lists by product type, adapted from Amplitude's
  official taxonomy guidance

## Related skills

- `prd-writer` — this skill's Part 1 output feeds the PRD's Success Measurement section
- `product-strategy` — where the North Star this skill measures against gets set
