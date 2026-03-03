# Discovery Synthesis Template

Use this during a synthesis session (solo or with team) to move from raw interview notes to Opportunity Statements.

---

## Step 1: Dump All Insights (15 min)

List every insight from all interviews. One insight per line. Don't judge or filter yet.

Format: `[Participant ID] — [insight in their words or close paraphrase]`

```
P1 — "I spend 2 hours every Monday pulling data from 3 different places"
P2 — "I just gave up trying to get the historical data — I use estimates now"
P3 — "My manager asks me for this report every week and I hate making it"
P1 — "If I could see everything in one place I'd actually use it"
P4 — "We have the data but nobody knows where to find it"
P2 — "I've built a spreadsheet to do what the tool should do"
...
```

---

## Step 2: Cluster Into Themes (20 min)

Group related insights. Name each cluster with a problem statement.

**Cluster format:**
```
## Theme: [Name — a problem, not a feature]

Participants: [P1, P2, P3...]
Frequency: [N / N total interviews]
Insights:
- [Insight 1]
- [Insight 2]
- [Insight 3]

Most revealing quote:
> "[The quote that best captures this theme]"
```

**Example:**
```
## Theme: Data scattered across tools makes reporting painful

Participants: P1, P2, P4
Frequency: 3 / 5 interviews
Insights:
- P1 spends 2h/week manually aggregating data from 3 sources
- P2 gave up on accurate data and now uses estimates
- P4 says "we have the data but nobody knows where to find it"

Most revealing quote:
> "I've built a spreadsheet to do what the tool should do" — P2
```

---

## Step 3: Frequency + Intensity Matrix

Plot each theme on the 2x2:

```
HIGH INTENSITY (frustration, urgency, embarrassment)
│
│   [Rare but emotionally charged]    [Frequent AND intense] ← prioritize
│
│
│   [Rare and mild]                   [Frequent but mild]
│
└────────────────────────────────────────── HIGH FREQUENCY
```

Assign each theme:
| Theme | Frequency Score (1-5) | Intensity Score (1-5) | Priority |
|---|---|---|---|
| [Theme 1] | [X] | [Y] | High/Med/Low |
| [Theme 2] | [X] | [Y] | High/Med/Low |

---

## Step 4: Signal vs. Noise Filter

For each theme, answer:

| Question | Yes / No |
|---|---|
| ≥3 different users mentioned this independently? | |
| ≥1 user showed emotional intensity (frustration, urgency)? | |
| Does it connect to a JTBD your product could address? | |

**If 0-1 "Yes" answers → Noise.** Document it in the "What We Heard But Won't Act On" section. Don't delete it — it may become relevant later.

**If 2-3 "Yes" answers → Signal.** Convert to Opportunity Statement.

---

## Step 5: Write Opportunity Statements

For each validated theme, write an Opportunity Statement:

```
## Opportunity: [Descriptive name]

Users affected: [N / N total]
Frequency: [How often this pain occurs for affected users]
Intensity: [1-5, with evidence]

Evidence:
> "[Quote 1]" — [Role]
> "[Quote 2]" — [Role]

Current workaround: [What users do today to cope with this]

JTBD: "When [situation], I want to [motivation], so I can [expected outcome]"

Opportunity statement:
"Users struggle to [specific job] when [specific context].
This leads to [specific negative impact].
They currently cope by [workaround], which costs [time/effort/accuracy]."

Priority: High / Medium / Low
Rationale: [One sentence on why this priority]
```

---

## Full Synthesis Output Template

```markdown
# Discovery Synthesis: [Topic / Research Question]

**Date:** [YYYY-MM-DD]
**Researcher:** [Name]
**Interviews completed:** [N]
**Key question:** [What decision does this research inform?]

---

## TL;DR
- [Finding 1 — plain language]
- [Finding 2]
- [Finding 3]
- **Recommended next step:** [What should the team do with this?]

---

## Top Opportunities

### 1. [Opportunity Name] — PRIORITY: HIGH
[Full opportunity statement format from Step 5]

### 2. [Opportunity Name] — PRIORITY: MEDIUM
[Full opportunity statement format]

### 3. [Opportunity Name] — PRIORITY: LOW
[Full opportunity statement format]

---

## Jobs-to-be-Done Identified

| JTBD | Users | Priority |
|---|---|---|
| "When [situation], I want to [motivation], so I can [outcome]" | [N/N] | High |
| [JTBD 2] | [N/N] | Medium |

---

## Key Quotes by Theme

### [Theme 1 Name]
> "[Quote]" — [Role]
> "[Quote]" — [Role]

### [Theme 2 Name]
> "[Quote]" — [Role]

---

## What We Heard But Won't Act On

| Item | Why not acting | What would change this |
|---|---|---|
| [Feature request or pain] | [Not frequent enough / low intensity / out of scope] | [Threshold to revisit] |

---

## Recommended Next Steps

1. [Action 1 — specific and owned]
2. [Action 2]
3. [Action 3]

---

## Participant Index

| ID | Role | Company Size | Segment | Date |
|---|---|---|---|---|
| P1 | [Role] | [Size] | [Segment] | [Date] |
| P2 | [Role] | [Size] | [Segment] | [Date] |
```
