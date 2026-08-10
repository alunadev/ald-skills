# Event Library by Product Type

Starting-point event lists, adapted from Amplitude's official industry taxonomy guidance
(amplitude.com/docs — "What events will you need"). These are starting points, not
comprehensive lists — track only what maps to a real question from `product-analytics`'s
metric tree, and drop anything here that doesn't.

## General (any web/app product)

Required regardless of vertical:

| Event | Properties |
|---|---|
| `Page Viewed` / `page_viewed` | `url`, `referrer`, `channel` |
| Your primary conversion event | product-specific |

Answers: how many page views, sessions, session length, retention by week, where users come from.

## B2B / SaaS

Most likely to apply to Adrian's own product work (ald-os, hone, career-hype-adjacent tools).

| Event | Properties |
|---|---|
| `Account Signed Up` | `signup_method`, `referral_source` |
| `Account Logged In` | `login_method` |
| `Trial Started` | `plan_tier` |
| `Trial Cancelled` | `reason` (if captured) |
| `[Key Activation Event]` | product-specific — the action that predicts retention |
| `Subscription Upgraded` / `Subscription Downgraded` | `from_plan`, `to_plan` |

User/group properties: `role` (eng, design, etc.), `paying` (true/false), group type `Business` if tracking accounts as well as individual users.

Answers: daily active businesses/users, trial-to-paid conversion, time-to-activation, feature adoption by role, usage frequency of the key event.

## Ecommerce

| Event | Properties |
|---|---|
| `Product Viewed` | `product_id`, `category`, `price` |
| `Product Added` | `product_id`, `quantity` |
| `Order Reviewed` | `cart_value`, `item_count` |
| `Order Completed` | `order_value`, `payment_method`, `item_count` |

Answers: view-to-purchase conversion, most popular items, average order value, revenue by period, LTV.

## Media / Content / Streaming

| Event | Properties |
|---|---|
| `Content Viewed` | `content_id`, `genre` or `category` |
| `Search Performed` | `query`, `results_count` |
| `Trial Started` / `Subscription Purchased` | `plan_tier` |

Answers: content consumption per user, trial-to-paid conversion, search-to-view conversion, session length.

## Healthcare (if ever relevant)

| Event | Properties |
|---|---|
| `Appointment Scheduled` | `provider_type`, `region` |
| `Appointment Rated` | `rating` (1-5) |

## Gaming (if ever relevant)

| Event | Properties |
|---|---|
| `Level Started` / `Level Completed` / `Level Failed` | `level` (integer) |
| `Purchase Completed` | `revenue`, `item_type` |

---

Full official guides (richer, per-industry business questions and dashboards): Amplitude publishes
detailed playbooks for e-commerce, fintech, B2B, media, and healthcare — search "Amplitude
industry taxonomy guides" for the current links, since these are periodically updated and the
direct URLs aren't stable enough to hardcode here.
