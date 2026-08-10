---
name: analytics-tracking
description: >
  Implementation and taxonomy skill for analytics tracking — event naming, properties, tracking
  plans, GA4/GTM/Amplitude setup, and debugging. Use this for the "how do we actually wire this
  up" layer, not the "what should we measure and why" layer (that's `product-analytics` — use
  this skill alongside it, after the metrics/tracking-plan decisions are made). Use this — without
  waiting to be asked — whenever the user mentions "set up tracking," "GA4," "Google Analytics,"
  "Amplitude," "event tracking," "UTM parameters," "tag manager," "GTM," "tracking plan,"
  "event taxonomy," "are my events firing," "why isn't this event showing up," "naming convention
  for events," or "instrument this feature." Produces a concrete tracking plan (event names,
  properties, triggers) plus implementation and debugging steps for the tools actually in use.
---

# Analytics Tracking

This skill covers the implementation layer of product analytics: naming events and properties consistently, building a tracking plan a team can actually maintain, wiring it into GA4/GTM/Amplitude/Segment/PostHog, and debugging it when events don't show up. Reference tool: Amplitude — this skill follows Amplitude's taxonomy conventions by default, with notes on how GA4/Segment ecosystems commonly differ.

For deciding *what* to measure and *why* — metric trees, guardrails, experiment design, ship/iterate/kill decisions — use `product-analytics` first. This skill picks up once those decisions exist and turns them into events, properties, and working instrumentation.

## Core Philosophy

**A taxonomy nobody can maintain is worse than no taxonomy.**

The single biggest failure mode in analytics implementation isn't missing events — it's inconsistent ones. Two teams shipping `Song Played` and `song_played` as the same intended event produces two separate, unreconcilable event streams. A tracking plan that isn't written down gets reinvented, differently, by whoever instruments the next feature.

Great analytics tracking:
- Locks a naming convention once, in writing, before the second event gets shipped
- Tracks only what maps to a business question someone will actually ask
- Keeps properties consistent across events (`item_type` and `payment_type`, never a shared generic `type`)
- Treats validation as part of shipping the feature, not a follow-up task that never happens

**The fatal flaw of bad tracking implementation**: a dashboard that's technically full of data and practically unusable because nobody trusts the event names enough to build on them.

## When to use this skill

- **Setting up a new tracking plan** — first analytics implementation for a product or a new feature area
- **Auditing existing tracking** — event names have drifted, properties are inconsistent, nobody's sure what's actually firing
- **Choosing/wiring a tool** — GA4, GTM, Amplitude, Segment, PostHog setup or migration
- **Debugging** — an event isn't firing, is firing with wrong properties, or is firing twice
- **Instrumenting a specific feature** — translating a tracking-plan spec from `product-analytics` into real event calls

## Key Principles

1. **Decide the convention before the second event** — capitalization, word order, and actor perspective all need to be locked early; retrofitting a naming convention across a live taxonomy is expensive.
2. **Object stays constant, verb varies (or vice versa) — never both** — pick object-action or actor-perspective and hold it everywhere, so the same noun (`Order`, `order`) never appears two different ways.
3. **Properties belong on the event, context belongs in the name only when it changes the meaning** — `Order Completed` with a `payment_method` property, not three separate `Order Completed (Credit Card)`-style events, unless the events genuinely need to be analyzed as unrelated funnels.
4. **No more than ~20 properties per event** — past that, the event is probably two events, or the properties aren't actually all needed.
5. **Resist tracking everything** — every event should trace back to a question in the tracking plan; untraceable events are noise that will bury the events that matter.

## Workflow

### Step 1: Lock the Naming Convention

Before instrumenting anything, decide and document:

```
Convention: [Object-Action | Action-Object] in [Title Case | snake_case]
Actor perspective: [Always the user's perspective — e.g. "Message Sent" means the user sent it, not that we did]
Example: [One worked example, e.g. "Order Completed" or "order_completed"]
```

Two conventions are common and both are fine — the failure mode is mixing them, not picking either:

| Convention | Example | Common in |
|---|---|---|
| Title Case, Noun + Past-Tense Verb | `Order Completed`, `Song Played` | Amplitude's own default |
| snake_case, object_action | `order_completed`, `signup_completed` | GA4, Segment, PostHog ecosystems |

If the project already has events shipped, match the existing convention — don't introduce a second one. If this is a new project, snake_case is the safer default when GA4 or a data warehouse is in the stack (GA4 event names have character/format constraints that favor it); Title Case is fine when Amplitude is the primary tool and there's no GA4 dependency.

### Step 2: Build the Tracking Plan

Structure every event the same way, so the plan is scannable and diffable:

```
| Event Name | Trigger | Properties | Priority |
|---|---|---|---|
| [event_name] | [Exact user action that fires it] | [Required properties] | Required / Nice-to-have |
```

**For each event, ask (Amplitude's taxonomy playbook, adapted):**
- What business question does this answer? If there isn't one, don't track it.
- Is this one event with a distinguishing property, or does it actually need to be separate events? (Prefer one event + property — `Order Completed` with `payment_method: apple_pay|credit_card`, not `Apple Pay Order Completed` as its own event — unless the paths are genuinely distinct funnels worth analyzing separately.)
- Are the properties this event needs also present on every other event in the same funnel? A property required to hold a funnel step "constant" (e.g. `product_id` linking `Product Viewed` → `Product Added`) has to appear on *every* event in that chain, or funnel analysis silently breaks.

**Standard property categories to reuse across events** (don't reinvent per event):

```
User: user_id, user_type, plan_tier, signup_date
Page/Screen: page_title, page_location, referrer
Campaign: utm_source, utm_medium, utm_campaign, utm_content, utm_term
Product/Object: object_id, object_type, category, price
```

For a starting event list by product type (general site, ecommerce, B2B/SaaS, media, healthcare, gaming), see `references/event-library.md`.

### Step 3: Implement

Pick the path that matches the stack — don't reach for GTM if there's no need for a tag-management layer, and don't hand-roll SDK calls if GTM is already the standard in the org.

**Direct SDK call (Amplitude example):**
```js
amplitude.track('Order Completed', {
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

**Google Tag Manager (data layer pattern):**
```js
dataLayer.push({
  event: 'order_completed',
  payment_method: 'credit_card',
  order_value: 49.99,
});
```

**If the codebase already has an analytics wrapper or prior instrumentation**, read it first and match its patterns rather than introducing a new call style — a second tracking pattern in the same codebase recreates the inconsistent-taxonomy problem this skill exists to prevent.

**Repo-level convention file** (optional, recommended once a project has more than a couple of contributors instrumenting events): keep naming rules, required properties, and tool choice in a checked-in file — e.g. `.agents/analytics-conventions.md` or Amplitude's own `.amplitude/instrumentation-agent-context.md` if using Amplitude's MCP tooling — so every future instrumentation pass (human or agent) starts from the same rules instead of re-deriving them.

```markdown
# Analytics conventions

## Naming
- Event names: Title Case, object-action ("Order Completed")
- Properties: snake_case

## Required properties
- user_id, session_id, platform on every event

## Tool
- Amplitude, project ID in .env as AMPLITUDE_API_KEY
```

### Step 4: Set Up UTM Strategy (if paid/campaign traffic matters)

```
| Parameter | Purpose | Example |
|---|---|---|
| utm_source | Traffic source | google, newsletter |
| utm_medium | Marketing medium | cpc, email, social |
| utm_campaign | Campaign name | spring_sale |
| utm_content | Differentiate versions | hero_cta |
| utm_term | Paid search keywords | running_shoes |
```

Lowercase everything, pick underscores or hyphens and stay consistent, and be specific but concise (`blog_footer_cta`, not `cta1`). Document every UTM combination in use somewhere a teammate can find it — undocumented UTMs are exactly as bad as undocumented event names.

### Step 5: Validate

Before calling an event "shipped," run the validation checklist:

```
□ Event fires on the correct trigger — not early, not late, not on every render
□ Property values populate correctly (not undefined, not the wrong type)
□ No duplicate firing (check for double-mounted listeners, multiple containers)
□ Fires correctly across the platforms it needs to (desktop/mobile, all supported browsers)
□ No PII in event properties (check names, emails, free-text fields especially)
□ Conversion events are marked as conversions in the tool, if applicable
```

**Debugging tools by platform:**

| Tool | Use for |
|---|---|
| GA4 DebugView | Real-time event monitoring during implementation |
| GTM Preview Mode | Test triggers and variables before publishing |
| Amplitude's live event stream / Chrome extension | Inspect events as they fire, verify properties |
| Browser devtools network tab | Confirm the tracking call actually leaves the browser |

**Common issues:**

| Symptom | Check first |
|---|---|
| Event not firing at all | Trigger configuration, script/tag actually loaded on the page |
| Wrong or missing property values | Variable/data-layer path, timing (property read before the value is set) |
| Duplicate events | Multiple analytics containers/SDKs initialized, or a trigger firing on every re-render |
| Funnel not connecting steps | A property meant to "hold constant" across the funnel is missing on one of the events |

### Step 6: Privacy and Compliance

```
□ Cookie/tracking consent required in EU/UK/California — gate tracking on consent where applicable
□ No PII in event or user properties (names, emails, free text) — use IDs and hashed/pseudonymous values instead
□ Data retention settings match policy
□ Users can request deletion — confirm the tool supports it before it's needed
```

Wire consent state into the SDK/tag manager (most tools support a "consent mode" or equivalent that queues or blocks tracking until consent is granted) rather than bolting privacy on after the taxonomy is built.

### Step 7: Output

Save the tracking plan:
```
docs/analytics/YYYY-MM-DD-[feature-or-product]-tracking-plan.md
```

## Output Format

```markdown
# Tracking Plan: [Feature / Product]

**Tools:** [GA4 / Amplitude / Segment / PostHog / GTM — whichever apply]
**Naming convention:** [Object-Action, Title Case | snake_case — one line, matches Step 1]
**Last updated:** [Date]

## Events

| Event Name | Trigger | Properties | Priority |
|---|---|---|---|
| [event_name] | [When it fires] | [Required properties] | Required / Nice-to-have |

## Standard Properties

| Property | Applies to | Notes |
|---|---|---|
| [property_name] | [Which events] | [Type, source, constraints] |

## Funnel Definitions (if applicable)

Step 1: [Event] → Step 2: [Event] → Step 3: [Event]
Held-constant property: [What links the steps — must be present on every event in the chain]

## Validation Status

| Event | Firing correctly | Properties correct | No duplicates | PII check |
|---|---|---|---|---|
| [event_name] | ✓/✗ | ✓/✗ | ✓/✗ | ✓/✗ |
```

## Quality Checklist

Before considering tracking implementation done:

**Naming**
- [ ] One naming convention documented and followed across every event
- [ ] No event name duplicated with different casing or word order anywhere in the codebase

**Plan**
- [ ] Every event traces to a specific business question
- [ ] Properties needed for funnel analysis appear on every event in that funnel
- [ ] No more than ~20 properties on any single event

**Implementation**
- [ ] Matches existing instrumentation patterns already in the codebase, if any exist
- [ ] No duplicate firing (checked in DebugView / Preview Mode / live event stream)

**Privacy**
- [ ] No PII in any event or user property
- [ ] Tracking respects consent state where consent requirements apply

## Common Antipatterns

### Antipattern 1: Two Conventions, One Codebase
**Symptom**: `Order Completed` and `order_completed` both exist, tracking the same thing, sent by different features.
**Fix**: Lock one convention in a checked-in doc before the second event ships. Migrate the outlier, don't add a third style to "fix" it.

### Antipattern 2: One Event, Many Clones
**Symptom**: `Apple Pay Order Completed`, `Credit Card Order Completed`, `PayPal Order Completed` instead of one `Order Completed` with a `payment_method` property.
**Fix**: Default to one event + a distinguishing property. Only split into separate events when the paths are genuinely distinct funnels worth analyzing independently — and even then, prefer property-based segmentation first.

### Antipattern 3: Tracking Everything
**Symptom**: Every click, hover, and render fires an event "in case it's useful later."
**Fix**: Every event must answer a business question already identified. If nobody can name the question, don't ship the event.

### Antipattern 4: Shipping Without Validation
**Symptom**: Events go live, nobody checks DebugView/Preview Mode, and three weeks later half of them turn out to be firing twice or with `undefined` properties.
**Fix**: Validation is part of "done," not a follow-up task. Run the Step 5 checklist before merging.

### Antipattern 5: PII in Properties
**Symptom**: An event property captures a raw email address, full name, or free-text field that includes personal data.
**Fix**: Use IDs and pseudonymous values in properties. If the analysis genuinely needs PII, it belongs in a separately governed system, not a general event property.

## Reference Resources

- `references/event-library.md` — starting event lists by product type (general site, ecommerce, B2B/SaaS, media, healthcare, gaming), adapted from Amplitude's official taxonomy guidance
- `references/tracking-plan-template.md` — copy-paste tracking plan template

## Related Skills

- `product-analytics` — use first, to decide *what* to measure and *why* (metric trees, experiment design, guardrails). This skill picks up once those decisions exist.
