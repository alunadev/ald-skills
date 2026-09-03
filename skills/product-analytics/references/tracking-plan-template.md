# Analytics Tracking Plan Template

> Use this before any feature ships. Instrument first, analyze second.

---

# Tracking Plan: [Feature / Initiative Name]

**Author:** [Name]
**Date:** [YYYY-MM-DD]
**Engineering contact:** [Name — who will implement the events]
**Analytics tool:** [Amplitude / Mixpanel / PostHog / Segment / other]

---

## Event Naming Convention

Amplitude standard. Lowercase `snake_case` in code; Title Case in the Amplitude UI only.

Format: `[object]_[action]` — object first, action second. Add `_[context]` only when the context
changes the meaning of the event; otherwise context is a **property**.

| Segment | Values |
|---|---|
| Object | `order`, `product`, `onboarding_step`, `feature`, `page`, `form`, `modal` |
| Action | `viewed`, `clicked`, `submitted`, `completed`, `started`, `activated`, `dismissed`, `cancelled`, `failed` |
| Context (rare) | Only when it splits a genuinely different funnel |

**Examples:**
- `page_viewed` — with a `page_name: dashboard` property
- `upgrade_clicked` — with `source: pricing_page`
- `onboarding_step_completed` — with `step_number: 2`
- `feature_activated` — with `feature_id: export`, `is_first_time: true`
- `api_request_failed` — with `error_type: timeout`

**Not this:** `page_view_dashboard`, `button_click_upgrade_pricing_page` — action-first, and
context baked into the name where a property belongs. That shape multiplies event names instead of
letting you slice one event.

---

## Standard Properties (include on every event)

| Property | Type | Description | Example |
|---|---|---|---|
| `timestamp` | datetime | UTC timestamp of event | `2026-03-01T14:22:31Z` |
| `user_id` | string | Stable user identifier | `usr_abc123` |
| `session_id` | string | Session identifier | `ses_xyz789` |
| `platform` | string | `web` / `ios` / `android` | `web` |
| `user_segment` | string | `free` / `pro` / `enterprise` | `pro` |
| `signup_date` | date | For cohort analysis | `2026-01-15` |

**For A/B experiments, also include:**
| Property | Type | Description |
|---|---|---|
| `experiment_id` | string | Experiment identifier |
| `variant` | string | `control` / `variant_a` / `variant_b` |
| `assignment_date` | date | When user was assigned to variant |

---

## Feature Events

### [Feature Name] Events

| # | Event Name | Trigger | Priority | Properties |
|---|---|---|---|---|
| 1 | [event_name] | [When exactly it fires] | Required / Nice | [Property list] |
| 2 | [event_name] | [When it fires] | Required / Nice | [Property list] |
| 3 | [event_name] | [When it fires] | Required / Nice | [Property list] |

**Event details:**

```
Event: [event_name]
Trigger: [Exact user action or system state that fires this]
Fires once or multiple times: [Once per session / per action / per day]
Priority: Required (must ship with feature) / Nice (track later)

Properties:
- [property_name]: [type] — [description] — example: [value]
- [property_name]: [type] — [description] — example: [value]

Do NOT fire when:
- [Edge case where this event should be suppressed]
```

---

## Funnel Events

List events in order to define a conversion funnel:

```
Funnel: [Funnel name — e.g., "Onboarding completion"]

Step 1: page_view_onboarding_start
         ↓ (conversion goal: 100% reach this)
Step 2: button_click_next_onboarding_step_1
         ↓
Step 3: form_submit_onboarding_step_2
         ↓
Step 4: feature_activate_core_action_first_time  ← Success state

Conversion = reaching Step 4 within 24 hours of Step 1
Drop-off analysis: Where do users exit? Steps with highest drop-off = biggest opportunity.
```

---

## Page / Screen Views

| Page | Event Name | Properties |
|---|---|---|
| [Page name] | `page_view_[page_name]` | `referrer`, `utm_source`, `previous_page` |
| [Page name] | `page_view_[page_name]` | [Properties] |

---

## Error Events

Track errors as first-class events — they reveal reliability and UX issues.

| Error | Event Name | Properties |
|---|---|---|
| API failure | `api_request_failed` | `endpoint`, `error_code`, `error_message`, `retry_count` |
| Form validation | `form_validation_failed` | `form_name`, `field_name`, `error_type` |
| Empty state | `empty_state_viewed` | `context`, `reason`, `has_onboarding_completed` |

Note how the object moved into a property (`endpoint`, `form_name`, `context`) rather than into
the event name — one event you can slice, instead of one event name per endpoint.

---

## QA Checklist

Before marking tracking as complete:

**Implementation:**
- [ ] All "Required" events are firing in staging
- [ ] Event names match this spec exactly (case-sensitive)
- [ ] Standard properties present on every event
- [ ] No PII in any event property (names, emails, payment info)
- [ ] Events fire once (no double-counting from re-renders)

**A/B Test (if applicable):**
- [ ] `variant` property present on all relevant events
- [ ] Both control and variant groups instrumented identically
- [ ] Assignment fires at correct point (before exposure, not after)

**Analytics tool:**
- [ ] Events visible in real-time stream / debugger
- [ ] Funnel configured in [tool name]
- [ ] Dashboard created for monitoring

---

## Data Validation

After events ship, validate within 48 hours:

```sql
-- Check event volume (Amplitude / Mixpanel SQL or equivalent)
SELECT
  event_name,
  COUNT(*) as event_count,
  COUNT(DISTINCT user_id) as unique_users,
  MIN(timestamp) as first_seen
FROM events
WHERE event_name IN ('[event_1]', '[event_2]', '[event_3]')
  AND timestamp >= CURRENT_DATE - INTERVAL '2 days'
GROUP BY 1
ORDER BY 2 DESC;
```

**Expected volumes (estimate before shipping):**
| Event | Expected daily volume | Acceptable range |
|---|---|---|
| [event_1] | [N] | [N × 0.8] to [N × 1.5] |
| [event_2] | [N] | [N × 0.8] to [N × 1.5] |

If actual volume is outside acceptable range → investigate before proceeding with analysis.

---

## Privacy & Compliance

**PII handling:**
- NEVER track: full name, email, phone, payment card, SSN, address
- MAY track: user_id, anonymized identifiers, behavioral signals
- Ask your legal/privacy team if unsure

**Data retention:**
- Events: [X months / as per your tool's settings]
- PII-adjacent data: [X days, then anonymized]
- Experiment data: [Keep for at least N months post-experiment for audit]
