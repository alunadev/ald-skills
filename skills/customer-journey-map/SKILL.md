---
name: customer-journey-map
description: "Maps the end-to-end customer experience from awareness to advocacy — touchpoints, emotions, friction points, and improvement opportunities per stage. Use when identifying drop-off points, improving onboarding, or understanding the full user lifecycle. Triggers on: customer journey, user journey, journey map, touchpoints, onboarding experience, funnel analysis, churn points, aha moment, drop-off, user lifecycle."
---

# Customer Journey Map

## Core Philosophy

A journey map is not a flowchart of your product screens. It's a map of the customer's *experience* — including what happens before they open your product and after they close it. The most valuable insights are usually outside the product: why they went looking, what they expected, and what made them stay or leave.

Focus on emotions and decisions, not just actions. A stage where the user feels confused or anxious is an opportunity. A stage where they feel nothing is a red flag for disengagement.

## When to Use

- When onboarding metrics are poor and you need to find where value breaks down
- Before a major UX redesign — to anchor changes in the actual user experience
- When retention drops and you need to identify the churn trigger stage
- After user interviews — to synthesize findings into a shared understanding of the lifecycle
- When building for a new segment — to map their specific journey before designing

## Workflow

### 1. Anchor to a Specific Persona

Pick one persona from user-personas. A journey map for "all users" is too vague to act on. The journey differs meaningfully by segment.

### 2. Map the Journey Stages

Adapt to your product, but cover the full lifecycle:

| Stage | Core Question |
|---|---|
| **Awareness** | How do they first learn about the product? |
| **Consideration** | What alternatives do they evaluate? What makes them pick you? |
| **Acquisition** | How do they sign up or purchase? Where do they drop off? |
| **Onboarding** | When do they reach first value? What blocks them? |
| **Engagement** | What habits form? What features drive retention? |
| **Retention** | What keeps them coming back? What signals churn risk? |
| **Advocacy** | When and why do they recommend? What prevents referral? |

### 3. For Each Stage, Document

- **Touchpoints**: Where the user interacts (website, email, in-app, support, social)
- **User actions**: What they do
- **Thoughts**: What's on their mind ("Is this worth my time?" / "How do I...?")
- **Emotions**: How they feel — rate 1–5 or use High/Medium/Low/Negative
- **Pain points**: Friction, confusion, drop-off risks
- **Opportunities**: How to improve the experience at this stage

### 4. Identify Critical Moments

- **Aha moment**: When the user first experiences core value — find it and protect it
- **Moments of truth**: Decision points where they commit or abandon
- **Churn triggers**: Stages with the highest drop-off or negative emotion score

### 5. Prioritize Improvements

Not every friction point is worth fixing. Rank opportunities by:
1. Impact on conversion or retention
2. Frequency (how many users hit this?)
3. Effort to fix

Produce a top-3 prioritized intervention list.

## Output Format

```
## Customer Journey Map — [Product] / [Persona]

| Stage | Touchpoint | Action | Emotion | Pain Point | Opportunity |
|---|---|---|---|---|---|
| Awareness | ... | ... | ... | ... | ... |
| Consideration | ... | ... | ... | ... | ... |
| Acquisition | ... | ... | ... | ... | ... |
| Onboarding | ... | ... | ... | ... | ... |
| Engagement | ... | ... | ... | ... | ... |
| Retention | ... | ... | ... | ... | ... |
| Advocacy | ... | ... | ... | ... | ... |

### Critical Moments
- Aha moment: [Stage + description]
- Key decision point: [Stage + what tips the balance]
- Primary churn trigger: [Stage + root cause]

### Top 3 Prioritized Improvements
1. [Stage] — [Problem] → [Intervention] — Impact: High / Effort: Low
2. ...
3. ...
```

## Antipatterns

- **Product-centric maps**: Only mapping in-app screens and ignoring pre-product and post-product stages. The most important friction is often before the user ever opens the app.
- **No emotional layer**: A journey map that only lists actions is a flowchart. Emotions reveal where experience breaks down — include them.
- **Generic personas**: A journey map for "all users" dilutes insights. Segment by persona; the journey from a power user differs fundamentally from a first-time user.
- **No prioritization**: Identifying 20 pain points without prioritizing them is analysis theater. End with an action-ranked list.
- **One-time artifact**: Customer journeys evolve as products change. Revisit after major feature launches or when retention metrics shift.
