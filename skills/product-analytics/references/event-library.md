# Event Library by Product Type

Starting-point event lists, adapted from Amplitude's official industry taxonomy guidance
(amplitude.com/docs — "What events will you need"). These are starting points, not
comprehensive lists — track only what maps to a real question from the metric tree in
`SKILL.md` Part 1, and drop anything here that doesn't.

Names below follow the locked standard: lowercase `snake_case`, object first, action second.
Amplitude displays them Title Case in its own UI; that is a display concern, not the name.

## General (any web/app product)

Required regardless of vertical:

| Event | Properties |
|---|---|
| `page_viewed` | `url`, `referrer`, `channel` |
| Your primary conversion event | product-specific |

Answers: how many page views, sessions, session length, retention by week, where users come from.

## B2B / SaaS

Most likely to apply to Adrian's own product work (ald-os, hone, career-hype-adjacent tools).

| Event | Properties |
|---|---|
| `account_signed_up` | `signup_method`, `referral_source` |
| `account_logged_in` | `login_method` |
| `trial_started` | `plan_tier` |
| `trial_cancelled` | `reason` (if captured) |
| `[key_activation_event]` | product-specific — the action that predicts retention |
| `subscription_upgraded` / `subscription_downgraded` | `from_plan`, `to_plan` |

User/group properties: `role` (eng, design, etc.), `paying` (true/false), group type `Business` if tracking accounts as well as individual users.

Answers: daily active businesses/users, trial-to-paid conversion, time-to-activation, feature adoption by role, usage frequency of the key event.

## Ecommerce

| Event | Properties |
|---|---|
| `product_viewed` | `product_id`, `category`, `price` |
| `product_added` | `product_id`, `quantity` |
| `order_reviewed` | `cart_value`, `item_count` |
| `order_completed` | `order_value`, `payment_method`, `item_count` |

Answers: view-to-purchase conversion, most popular items, average order value, revenue by period, LTV.

## Media / Content / Streaming

| Event | Properties |
|---|---|
| `content_viewed` | `content_id`, `genre` or `category` |
| `search_performed` | `query`, `results_count` |
| `trial_started` / `subscription_purchased` | `plan_tier` |

Answers: content consumption per user, trial-to-paid conversion, search-to-view conversion, session length.

## Healthcare (if ever relevant)

| Event | Properties |
|---|---|
| `appointment_scheduled` | `provider_type`, `region` |
| `appointment_rated` | `rating` (1-5) |

## Gaming (if ever relevant)

| Event | Properties |
|---|---|
| `level_started` / `level_completed` / `level_failed` | `level` (integer) |
| `purchase_completed` | `revenue`, `item_type` |

---

Full official guides (richer, per-industry business questions and dashboards): Amplitude publishes
detailed playbooks for e-commerce, fintech, B2B, media, and healthcare — search "Amplitude
industry taxonomy guides" for the current links, since these are periodically updated and the
direct URLs aren't stable enough to hardcode here.
