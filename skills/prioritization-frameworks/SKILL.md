---
name: prioritization-frameworks
description: "Applies the right prioritization framework for the context — Opportunity Score, RICE, ICE, MoSCoW, or Kano — with formulas, scoring guidance, and when-to-use rationale. Use when ranking features or problems, comparing approaches, or preparing a prioritized backlog. Triggers on: prioritization, RICE, ICE, MoSCoW, Kano, backlog prioritization, feature ranking, opportunity score, prioritize features, what to build next."
---

# Prioritization Frameworks

## Core Philosophy

Never let customers prioritize solutions. Your job is to prioritize **problems** (opportunities), then find the best solution for the highest-priority problem. When you ask customers which feature to build, they'll always say "all of them."

The right framework depends on the context. No single framework is universally best — pick the one that matches your uncertainty level, team size, and the type of decision you're making.

## When to Use

- When the backlog is too large and trade-offs need to be explicit
- When stakeholders disagree on what to build next
- When running a discovery sprint and need to rank opportunities
- When comparing RICE vs ICE vs Opportunity Score for your context

## Framework Selection Guide

| Framework | Best For | Key Trade-off |
|---|---|---|
| **Opportunity Score** | Ranking customer problems | Most rigorous, requires survey data |
| **RICE** | Features at scale, larger teams | More granularity than ICE |
| **ICE** | Quick idea triage, early stage | Fast but more subjective |
| **MoSCoW** | Scoping releases and negotiations | Qualitative, stakeholder-facing |
| **Kano Model** | Understanding feature expectations | Analysis only, not a scoring system |
| **Impact vs Effort** | Quick 2×2 for personal task management | Not rigorous for strategic decisions |

## Frameworks in Detail

### Opportunity Score *(Recommended for problem prioritization)*

Created by Dan Olsen. The most rigorous method for ranking customer problems.

Survey customers on each need:
- **Importance**: How important is this to you? (1–10)
- **Satisfaction**: How satisfied are you with current solutions? (1–10)

Normalize to 0–1 scale, then:
- **Opportunity Score** = Importance × (1 − Satisfaction)
- High Importance + Low Satisfaction = highest priority

Plot on an Importance vs. Satisfaction chart. Upper-left quadrant = sweet spot. Prioritizes problems, not features.

### RICE *(Recommended for feature prioritization at scale)*

**Score** = (Reach × Impact × Confidence) / Effort

- **Reach**: Number of customers affected per time period
- **Impact**: Value per customer (use Opportunity Score or 0.25 / 0.5 / 1 / 2 / 3)
- **Confidence**: How confident are you? (0–100%)
- **Effort**: Person-months to implement

Higher score = prioritize first. Accounts for reach as a distinct factor from impact.

### ICE *(Recommended for quick triage)*

**Score** = Impact × Confidence × Ease

- **Impact**: Expected outcome improvement (1–10)
- **Confidence**: How confident are you this will work? (1–10)
- **Ease**: How easy to implement? (1–10)

Best for fast prioritization of a large idea list. More subjective than RICE.

### MoSCoW *(Recommended for scoping and stakeholder alignment)*

Classify each item:
- **Must have**: Launch-blocking — the product doesn't work without it
- **Should have**: High value, not launch-blocking
- **Could have**: Nice to have, include if time allows
- **Won't have (now)**: Explicitly out of scope this cycle

Caution: "Must have" inflation is common — teams call everything critical. Challenge each Must relentlessly.

### Kano Model *(For understanding, not scoring)*

Classify features by customer expectation:
- **Must-be**: Expected baseline — absence causes dissatisfaction, presence is neutral
- **Performance**: More = better (speed, storage, price)
- **Attractive**: Unexpected delighters — presence drives satisfaction, absence is fine
- **Indifferent**: Doesn't affect satisfaction either way
- **Reverse**: Presence annoys some users

Use Kano to understand *why* a feature matters, not to rank it.

## Workflow

1. **Choose framework** based on what you're prioritizing (problems → Opportunity Score; features → RICE or ICE; scoping → MoSCoW)
2. **Gather inputs**: Reach from analytics, Impact from user research, Confidence from evidence quality, Effort from engineering estimate
3. **Score items** using the formula
4. **Rank and review**: Top-scored items should feel right. If they don't, examine your inputs for bias
5. **Socialize**: Present the ranked list with the formula and inputs visible — don't just show the scores

## Output Format

```
## Prioritized Backlog — [Product / Sprint / Quarter]

Framework used: [RICE / ICE / Opportunity Score / MoSCoW]

| Item | Reach | Impact | Confidence | Effort | Score | Priority |
|---|---|---|---|---|---|---|

### Top 3 to build next
1. [Item] — Score: X — Rationale: [why this wins]
2. ...
3. ...

### Explicitly deprioritized
[Item] — Why not now: [reason]
```

## Antipatterns

- **HiPPO prioritization**: Highest Paid Person's Opinion overrides the scores. Use frameworks to make the basis of decisions transparent and challengeable.
- **Gaming scores**: Inflating Confidence or Impact for pet projects. Show your inputs, not just final scores.
- **Prioritizing solutions, not problems**: "Build feature X" is a solution. Prioritize the underlying problem first.
- **MoSCoW inflation**: Every feature becomes "Must have." If everything is critical, nothing is.
- **Single-framework dogma**: No framework is right for all contexts. Match the framework to the decision type.
