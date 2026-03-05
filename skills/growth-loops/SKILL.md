---
name: growth-loops
description: "Identifies and designs growth loops (flywheels) for sustainable traction — evaluating 5 loop types: Viral, Usage, Collaboration, User-Generated, and Referral. Use when designing growth mechanisms or reducing reliance on paid acquisition. Triggers on: growth loop, flywheel, viral loop, referral program, product-led growth, PLG, user acquisition, growth strategy, retention loop, compounding growth."
---

# Growth Loops

## Core Philosophy

Paid acquisition is a leaky bucket. Growth loops are a flywheel. The difference: in a paid model, growth stops when spending stops. In a loop model, each user or action generates the next one — the system compounds.

The goal is not to have the most impressive loop — it's to identify the one loop that is most natural to your product and build it first. One well-executed loop beats three half-built ones.

## When to Use

- When designing the product growth model for a new product
- When paid acquisition costs are too high relative to LTV
- When defining how a new feature drives retention or acquisition
- When analyzing why a competitor is growing faster than their ad spend explains

## The 5 Loop Types

### 1. Viral Loop
Users create content or output in-product, share it externally, and new users arrive.

- **Mechanism**: User creates → shares on external platform → new users discover and sign up
- **Examples**: Figma design links, Loom video shares, Canva published posts
- **Strength**: Exponential if content is naturally shareable
- **Required**: Shareable output that makes sense to share (not just a dashboard screenshot)

### 2. Usage Loop
Using the product more generates more value, which increases engagement and referrals.

- **Mechanism**: More usage → more personalized/valuable output → more engagement → more sharing
- **Examples**: Spotify's Wrapped, Duolingo streaks, GitHub contribution graphs
- **Strength**: Directly tied to product value — growth is proof of engagement
- **Required**: Product creates visible or shareable proof of value over time

### 3. Collaboration Loop
Users invite colleagues to work together, expanding the user base within organizations.

- **Mechanism**: User creates → invites colleagues to collaborate → colleagues experience product value
- **Examples**: Google Docs, Figma, Notion team spaces, Slack channels
- **Strength**: Deep organizational penetration + strong retention (hard to leave if your team is there)
- **Required**: Core value increases with more collaborators

### 4. User-Generated Content Loop
Users discover content from other users, create their own, and share it — driving discovery and creation.

- **Mechanism**: User discovers others' content → creates own content → shares → others discover
- **Examples**: TikTok, Pinterest, YouTube, Notion templates gallery
- **Strength**: Content flywheel — existing content attracts creators, creators attract viewers
- **Required**: Critical mass of quality content to sustain the loop

### 5. Referral Loop
Users refer others in exchange for rewards, recognition, or social currency.

- **Mechanism**: User refers → referred user joins → referrer earns reward → cycle continues
- **Examples**: Dropbox storage bonuses, Airbnb credits, PayPal signup bonuses
- **Strength**: Directly incentivized, measurable ROI
- **Required**: Strong enough incentive to motivate action without destroying unit economics

## Workflow

### 1. Define Your Product's Core Action

What is the one action users take that creates value? (Share a design, complete a task, invite a contact, post content.)

### 2. Evaluate Loop Fit

For each of the 5 loop types:
- **Is the core action shareable?** → Viral / Usage / UGC Loop
- **Does value increase with more users?** → Collaboration Loop
- **Is the incentive strong enough to motivate referral?** → Referral Loop

Score each loop 1-5 for fit. Pick the top 1-2 to build first.

### 3. Design Loop Mechanics for Your Top Loop

- **Trigger**: What prompts the sharing or invitation action?
- **Incentive**: What motivates the user to complete the action? (Intrinsic: pride, convenience. Extrinsic: reward, recognition.)
- **Friction**: What could prevent the action? Remove it.
- **Conversion**: What % of invites/shares convert to new active users?
- **Cycle time**: How long does one loop iteration take?

### 4. Estimate the Loop Coefficient

*Coefficient K = (Invites per user) × (Conversion rate)*
- K > 1: Exponential growth
- K = 0.5-1: Strong growth boost, not standalone
- K < 0.5: Loop is present but minor

### 5. Define the Build Plan

- What's the smallest change to the product that activates this loop?
- What does "loop is working" look like in metrics?
- What's the 90-day measurement plan?

## Output Format

```
## Growth Loop Design — [Product Name]

### Core Product Action
[The one thing users do that creates value]

### Loop Evaluation
| Loop Type | Fit (1-5) | Key Condition | Verdict |
|---|---|---|---|
| Viral | | | Build / Maybe / Skip |
| Usage | | | |
| Collaboration | | | |
| User-Generated | | | |
| Referral | | | |

### Primary Loop: [Loop Type]
- Trigger: [What prompts sharing/inviting]
- Incentive: [Why users take the action]
- Friction removed: [What we'll make easier]
- Estimated K coefficient: [X]

### Build Plan
- MVP change to activate loop: [Description]
- Success metric: [What we measure]
- 30-day goal: [Specific number]
```

## Antipatterns

- **Building all 5 loops**: Spreading effort across every loop type before any one is working. One loop at K=0.8 is more valuable than five loops at K=0.1 each.
- **Extrinsic incentives for intrinsic actions**: Paying users to share something they'd share anyway dilutes authenticity and increases cost without increasing conversion.
- **Ignoring cycle time**: A viral loop that takes 6 weeks per cycle is effectively not a loop. Minimize the time between trigger and new user activation.
- **Copying Dropbox blindly**: Referral loops only work if the reward is meaningful relative to the product's value. A low-value product with a low-value reward won't convert.
- **No measurement**: Building a loop without defining the K coefficient metric means you can't tell if it's working.
