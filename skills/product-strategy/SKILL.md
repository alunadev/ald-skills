---
name: product-strategy
description: Expert product strategy advisor for Senior PMs. Use when defining a product vision, setting OKRs, building a roadmap, prioritizing between competing bets, entering a new product area, or when stakeholders disagree on direction. Produces a structured strategy document grounded in user outcomes, not feature lists.
---

# Product Strategy

This skill produces decision-focused product strategy. It structures ambiguous direction into concrete bets, forces trade-offs, and grounds decisions in user outcomes — not feature lists or roadmap theater.

## Core Philosophy

**Strategy is choosing what NOT to do.**

A great strategy in 2025:
- Names one North Star that the whole team can test decisions against
- Makes explicit bets with explicit trade-offs (including the "do nothing" option)
- Is grounded in user Jobs-to-be-Done, not stakeholder opinions
- Is short enough to be read in 5 minutes, specific enough to reject a feature proposal

**The fatal flaw of bad strategies**: They list everything as a priority. "Improve retention, grow acquisition, expand to enterprise" is a vision board, not a strategy.

## When to use this skill

- Before setting quarterly OKRs (what are we actually betting on?)
- When the roadmap has too many competing priorities
- When entering a new product area or user segment
- When stakeholders disagree on direction and you need a decision framework
- When writing a strategy doc for exec review or team alignment
- When you have user research but no clear strategic narrative

## Key Principles

1. **One North Star** — One metric that captures value creation for users. Everything else is an input metric.
2. **Outcomes over outputs** — Bets are framed as user outcomes, not features shipped.
3. **Explicit non-priorities** — What you won't do is as important as what you will.
4. **Three bets, not one** — Always compare at least three paths including "do nothing."
5. **Time-boxed** — Strategy is valid for a specific time horizon (quarter, half, year). State it.

## Workflow

### Step 1: Context Loading
Before proposing anything, read:
- Existing strategy docs or roadmap artifacts (ask user to share if not in repo)
- Recent metrics or growth data (ask for key numbers)
- User research or discovery findings (link to `docs/discovery/` if exists)

Ask the user:
> "What's the time horizon for this strategy? (quarter / half / year) And what's the core question this strategy needs to answer?"

### Step 2: North Star Definition

Define ONE North Star Metric:
- It measures **value delivered to users** (not revenue, not engagement for its own sake)
- It's a **lagging indicator** — something that moves slowly but meaningfully
- Everyone on the team can influence it

**Format:**
```
North Star: [Metric name]
Definition: [Exact measurement — what counts, what doesn't]
Current: [Current value]
Target: [Target for this time horizon]
Why this: [One sentence — why this metric represents real user value]
```

Then define 3-5 **Input Metrics** (leading indicators that drive the North Star):
```
Input Metrics:
1. [Metric] → How it drives North Star: [one line]
2. [Metric] → How it drives North Star: [one line]
3. [Metric] → How it drives North Star: [one line]
```

### Step 3: Opportunity Mapping

Map the **Opportunity Tree** (Teresa Torres framework):

```
Desired Outcome (North Star)
├── Opportunity 1: [Job-to-be-Done users struggle with]
│   ├── Solution A
│   └── Solution B
├── Opportunity 2: [Another unmet need]
│   ├── Solution C
│   └── Solution D
└── Opportunity 3: [Another unmet need]
    └── Solution E
```

Prioritize opportunities using two axes:
- **Importance**: How critical is this job to the user? (1-5)
- **Satisfaction**: How well does the current solution serve this job? (1-5)

**Priority score = Importance + (Importance - Satisfaction)**
→ High importance + low satisfaction = highest priority

### Step 3b: Competitive Context (Optional)

Use these frameworks when entering a competitive market or when stakeholders need strategic grounding before selecting bets. Pick the one that fits — you don't need all three.

**SWOT — Internal + External Situation Assessment**
Use when: entering a new area, responding to competitive pressure, or when bets need exec-level justification.

| | Helpful | Harmful |
|---|---|---|
| **Internal** | Strengths: what we do better today | Weaknesses: honest gaps (resources, capability, coverage) |
| **External** | Opportunities: market/user trends to exploit | Threats: competitive moves, regulation, shifts that undermine bets |

→ Bets should leverage Strengths + Opportunities. Flag bets that depend on eliminating a Weakness.

**Porter's 5 Forces — Competitive Intensity Assessment**
Use when: evaluating a new market or product area before committing.

| Force | Assessment (Low / Med / High) | Strategic implication |
|---|---|---|
| Threat of new entrants | | |
| Buyer bargaining power | | |
| Supplier bargaining power | | |
| Threat of substitutes | | |
| Competitive rivalry | | |

→ High rivalry + low switching cost = bet must differentiate sharply. Low buyer power = retention investment pays more than acquisition.

**Ansoff Matrix — Growth Strategy**
Use when: a bet involves market or product expansion beyond the core.

| | Existing Products | New Products |
|---|---|---|
| **Existing Markets** | Market Penetration *(lowest risk)* | Product Development |
| **New Markets** | Market Development | Diversification *(highest risk)* |

→ Name which quadrant each bet falls in. Bets in "New Markets + New Products" require 10x the evidence before committing.

---

### Step 4: Bet Selection

Present **exactly 3 bets** with trade-offs:

```
## Bet A: [Name]
What: [One sentence on the bet]
Opportunity it addresses: [Link to Opportunity Tree]
Evidence: [User research, data, or analogies that support this]
Expected outcome: [Specific, measurable — ties to input metrics]
Resources required: [Rough team/time investment]
Risks: [What could go wrong]
Non-goals this creates: [What we explicitly defer]

## Bet B: [Name]
[Same format]

## Bet C: Do Nothing (status quo)
What: Continue current trajectory without new investment
Expected outcome: [Where will metrics trend without action?]
Risk of inaction: [What's the cost of waiting?]
```

**Then state the recommendation:**
```
## Recommended Bet: [A/B/C]
Rationale: [2-3 sentences. Reference evidence, trade-offs, and strategic fit]
Key assumption: [The one thing that must be true for this bet to pay off]
First signal of progress: [What will you see in 4-6 weeks if this is working?]
```

### Step 5: OKRs (Optional — if user needs them)

Translate the chosen bet into OKRs:

```
## Objective: [Ambitious, qualitative direction — one sentence]

Key Result 1: [Specific, measurable, time-bound — ties to North Star or input metric]
Key Result 2: [Another specific KR]
Key Result 3: [Another specific KR]

Initiatives (not KRs — these are the "how"):
- [Initiative 1] → Expected to move KR [X] by [Y]
- [Initiative 2] → Expected to move KR [X] by [Y]
```

**OKR quality rules:**
- Objectives should be inspirational enough that you're slightly uncomfortable committing
- Key Results have specific numbers and dates — not "increase retention" but "increase D30 retention from 42% to 48% by end of Q2"
- Initiatives are how you'll try to hit KRs — they can be updated; KRs should not

### Step 6: Output

Save the strategy doc:
```
docs/strategy/YYYY-MM-DD-[product-area]-strategy.md
```

Include a **one-page summary** at the top:
```
## TL;DR (for exec review)
North Star: [Metric] — current [X], target [Y] by [date]
Chosen bet: [Name in one sentence]
Key assumption: [One sentence]
First signal: [What we'll see in 4-6 weeks]
What we're NOT doing: [3 bullet points]
```

## Output Format

```markdown
# [Product Area] Strategy — [Time Horizon]

**Owner:** [Name]
**Status:** Draft / Reviewed / Approved
**Last Updated:** [Date]

## TL;DR
[One-page summary — North Star, chosen bet, key assumption, non-priorities]

## Context
[2-3 sentences on the current state and what prompted this strategy work]

## North Star
[Metric, definition, current, target, why]

## Input Metrics
[3-5 leading indicators with causal links to North Star]

## Opportunity Tree
[Mapped opportunities with priority scores]

## The Bets
[Bet A, Bet B, Bet C: Do Nothing — with trade-offs]

## Recommendation
[Chosen bet + rationale + key assumption + first signal]

## OKRs (if applicable)
[Objective + Key Results + Initiatives]

## What We're NOT Doing
[Explicit non-priorities for this time horizon]

## Open Questions
[What we still need to resolve, with owners]
```

## Quality Checklist

Before considering the strategy complete:

**Direction**
- [ ] North Star is a single metric that measures user value (not vanity)
- [ ] Input metrics have causal links to North Star, not correlation
- [ ] Time horizon is explicit

**Rigor**
- [ ] Three bets presented, including "do nothing"
- [ ] Each bet has expected outcome tied to specific metrics
- [ ] Opportunity Tree links bets to user Jobs-to-be-Done

**Decisions**
- [ ] One bet is recommended, not "it depends"
- [ ] Key assumption is named (what must be true for this to work)
- [ ] Non-priorities are explicit (at least 3 things we won't do)

**Actionability**
- [ ] Engineering knows what the first milestone looks like
- [ ] First signal of progress is defined (what we'll see in 4-6 weeks)
- [ ] OKRs (if included) have specific numbers and dates

## Common Antipatterns

### Antipattern 1: Everything is a Priority
**Symptom**: Roadmap has 12 initiatives all labeled "High Priority"
**Fix**: Force ranking. Only the top 3 get resources. Everything else is explicitly deferred.

### Antipattern 2: Feature-Led Strategy
**Symptom**: "Our strategy is to ship X, Y, and Z features this quarter"
**Fix**: Reframe as outcomes. "Our strategy is to improve job completion rate for [user segment] from X% to Y%." Features are means, not ends.

### Antipattern 3: Strategy Without Trade-offs
**Symptom**: The strategy doesn't explain what you're NOT doing
**Fix**: Add "What We're NOT Doing" section. If nothing is deferred, it's not a strategy.

### Antipattern 4: Vanity North Star
**Symptom**: North Star is DAU, MAU, or revenue — things that can go up while user value goes down
**Fix**: Ask "can this metric go up even if users are getting less value?" If yes, it's the wrong North Star.

### Antipattern 5: One-and-Done
**Symptom**: Strategy written at start of quarter, never revisited
**Fix**: Review strategy monthly. If the key assumption has been proven wrong, update the bet.

## Reference Resources

- `references/strategy-template.md` — Complete strategy doc template with examples
- `references/frameworks.md` — Opportunity Tree, OKRs, JTBD, Positioning frameworks in detail
