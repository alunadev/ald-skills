---
name: user-discovery
description: Expert user research and discovery advisor. Use before writing a PRD, when validating product assumptions, when metrics signal a problem but not the "why", when exploring a new user segment or job-to-be-done, or when preparing for stakeholder interviews. Produces structured discovery synthesis that feeds directly into product strategy and PRD writing.
---

# User Discovery

This skill structures the messy process of user research into actionable product decisions. It covers interview design, live capture, and synthesis — from raw notes to Opportunity Statements that feed into PRDs and strategy docs.

## Core Philosophy

**Listen for problems, not solutions. Listen for frequency and intensity.**

Users will tell you what to build. They almost always describe solutions ("I wish you had a button for X"). Your job is to hear the problem underneath ("so you can stop doing X manually").

A great discovery process:
- Asks about the past, not the future ("Tell me about the last time..." not "Would you use...")
- Treats every user request as evidence, not instruction
- Separates signal (recurring pain, frequency, emotional intensity) from noise (one-time preference)
- Produces Opportunity Statements, not feature lists

**The fatal flaw of bad discovery**: Interviewing users, then building what they asked for.

## When to use this skill

- Before writing a PRD (don't write specs for unvalidated problems)
- When a metric signals a problem but not the root cause
- When entering a new product area or user segment
- When validating strategic bets before committing resources
- When stakeholders disagree on what users actually want
- For recurring weekly discovery to maintain a continuous pipeline of insights

## Key Principles

1. **Past over future** — "Tell me about the last time X happened" beats "Would you use Y?" every time.
2. **Problems over solutions** — If a user proposes a solution, ask "what would that let you do?" to get back to the job.
3. **Frequency + intensity** — An insight is only strategic if multiple users have it with emotional intensity. Single occurrences are just data points.
4. **Synthesize before specifying** — Don't jump from raw notes to a PRD. Synthesis creates the bridge.
5. **Continuous, not project-based** — Discovery shouldn't be a one-time sprint. Weekly interviews > quarterly research projects.

## Workflow

### Step 1: Research Brief

Before recruiting or scheduling, define:

```
## Research Brief

Goal: [One sentence — what decision will this research inform?]
Key questions:
  1. [Question we need to answer]
  2. [Question we need to answer]
  3. [Question we need to answer]
Time horizon: [When do we need findings?]
Method: [Interview / survey / diary study / usability test]
Sample size: [5-8 interviews for qualitative; 100+ for survey]
```

**Recruitment criteria (screener):**
```
Must have:
- [Criterion 1 — e.g., "Uses the product at least weekly"]
- [Criterion 2 — e.g., "Has experienced [specific pain] in the last 30 days"]

Nice to have:
- [Criterion 3]

Exclude:
- [Who to avoid — e.g., "Internal users", "Beta testers already aligned"]
```

### Step 2: Interview Protocol

Use this 45-minute structure. Adapt — don't script.

**Section 1: Context (5 min)**
- "What's your role, and how does [product area] fit into your day?"
- "Walk me through a typical [relevant workflow] — what does that look like?"

**Section 2: The Triggering Moment (10 min)**
- "Tell me about the last time you [did the thing we're researching]."
- "What prompted it? What were you trying to accomplish?"
- "Walk me through what happened, step by step."

**Section 3: Pain Identification (15 min)**
- "What was the hardest part of that?"
- "What did you do when [friction point occurred]?"
- "How did you feel when [pain happened]?"
- "How often does this happen?"
- [If solution proposed]: "What would that let you do that you can't do now?"

**Section 4: Current Alternatives (10 min)**
- "What do you do today to [solve this]? Show me if possible."
- "What do you like about what you're using now?"
- "What's missing or frustrating about it?"
- "What would make you switch?"

**Section 5: Wrap-up (5 min)**
- "Is there anything about [topic] that I haven't asked about that you think is important?"
- "If you could wave a magic wand and change one thing about how you [do this job], what would it be?"
- "Who else on your team has strong opinions about this? Can I talk to them?"

**Rules for the interview:**
- One question at a time — never combine two questions
- 3-second silence rule — wait after every answer before speaking
- "Tell me more" is your most powerful follow-up
- Never validate their pain with "That's a great point" — stay neutral
- Record (with permission) or bring a dedicated note-taker

### Step 3: Live Notes Template

Capture during the interview (or from recording immediately after):

```markdown
## Interview: [First Name, Role, Company Size] — [Date]

### Context
- Role: [What they do]
- Usage: [How they use product — frequency, context]
- Key workflows: [2-3 things they do regularly]

### Quotes (exact words — critical)
> "[Exact quote that captures a pain, job, or expectation]"
> "[Another quote]"
> "[Another quote]"

### Moments of Friction (observe, not interpret)
- [Specific moment where they struggled or hesitated]
- [Another friction moment]

### Jobs-to-be-Done (extract from context)
- JTBD: "When [situation], I want to [motivation], so I can [outcome]"

### Pain Points (frequency + intensity)
| Pain | Frequency (daily/weekly/monthly) | Intensity (1-5) |
|---|---|---|
| [Pain 1] | [Freq] | [Int] |
| [Pain 2] | [Freq] | [Int] |

### Current Workarounds
- [What they do today to solve the pain — often a key insight]

### Opportunities (initial, unvalidated)
- [Possible opportunity this interview suggests]
```

### Step 4: Synthesis

After 5-8 interviews, synthesize across participants:

**Step 4a: Affinity Clustering**
List all raw insights (one per sticky note or bullet). Group into themes. Name each theme.

**Step 4b: Frequency + Intensity Matrix**
```
High Intensity
│
│  [Rare but emotional]    [Frequent AND emotional] ← prioritize here
│
│
│  [Rare and mild]         [Frequent but mild]
│
└─────────────────────────────────────── High Frequency
```

**Step 4c: Opportunity Statements**
Convert clusters into Opportunity Statements (Teresa Torres format):

```
Opportunity: [Name]
Users affected: [N of N interviewed]
Evidence: [Quotes + frequency + intensity data]
Current workaround: [What they do today]
Opportunity statement: "Users struggle to [specific job] when [specific context]. This leads to [specific impact]."
Priority: High / Medium / Low [based on frequency + intensity matrix]
```

**Step 4d: Signal vs. Noise Filter**
Before promoting to Opportunity, ask:
- Did ≥3 different users mention this independently? (frequency signal)
- Did at least 1 user show emotional intensity (frustration, embarrassment, urgency)? (intensity signal)
- Does it connect to a JTBD? (strategic relevance)

If no to all three → it's noise. Document but don't act.

### Step 5: Output

Save the synthesis doc:
```
docs/discovery/YYYY-MM-DD-[topic]-discovery-synthesis.md
```

This doc becomes the direct input to `prd-writer` (Opportunity Framing section) and `product-strategy` (Opportunity Tree).

---

### Phase 2: Assumption Mapping + Opportunity-Solution Tree (Optional)

Use before committing a major bet to ensure the underlying assumptions are visible and testable — not hidden inside the solution.

#### Step 5b: Assumption Mapping

Surface and classify every assumption behind the proposed opportunity.

**Assumption types:**
- **Desirability**: Do users want this? *(validated by discovery)*
- **Viability**: Is this commercially sustainable?
- **Feasibility**: Can the team actually build it?
- **Usability**: Will users understand and complete the flow?

```
| Assumption | Type | Confidence | Evidence | Risk if wrong |
|---|---|---|---|---|
| [Users want X] | Desirability | High | 6/8 interviews | Low — well validated |
| [Users will pay $Y/mo] | Viability | Low | 0 data points | High — test before building |
| [Team can ship in Q2] | Feasibility | Medium | Eng estimate | Medium |
| [Users understand the UI] | Usability | Low | No usability test yet | High |
```

→ Flag every assumption with **Confidence < Medium** for validation before writing specs.

#### Step 5c: Opportunity-Solution Tree (OST)

Structure the path from discovery to experiments formally (Teresa Torres framework):

```
Desired Outcome (North Star metric)
├── Opportunity 1: [Validated pain — from synthesis]
│   ├── Solution A: [Specific hypothesis — not "improve X", but "add Y so users can Z"]
│   │   └── Experiment: [Smallest test to validate A — survey, prototype, shadow]
│   └── Solution B: [Alternative approach]
│       └── Experiment: [Test for B]
├── Opportunity 2: [Validated pain]
│   └── Solution C: [Hypothesis]
│       └── Experiment: [Test for C]
└── Opportunity 3: [Validated pain]
    └── Solution D: [Hypothesis]
        └── Experiment: [Test for D]
```

**OST rules:**
- Address one opportunity at a time — don't run solutions for multiple branches simultaneously
- Solutions are hypotheses, not commitments — they live and die by their experiments
- Every solution branch has a linked experiment (the smallest test that could disprove it)
- Only graduate a solution to a PRD after its experiment validates demand

---

## Output Format

```markdown
# Discovery Synthesis: [Topic]

**Researcher:** [Name]
**Date:** [YYYY-MM-DD]
**Interviews:** [N conducted] / [N target]
**Key question:** [The decision this research was meant to inform]

## TL;DR
[3-4 bullets — top findings, in plain language]

## Top Opportunities (prioritized)

### Opportunity 1: [Name]
Users affected: [N / N interviewed]
Frequency: [How often this pain occurs]
Intensity: [1-5, with evidence]
Evidence quotes:
> "[Quote 1]"
> "[Quote 2]"
Current workaround: [What they do today]
Opportunity statement: [Structured statement]

### Opportunity 2: [Name]
[Same format]

### Opportunity 3: [Name]
[Same format]

## Jobs-to-be-Done Identified

| JTBD | Users | Priority |
|---|---|---|
| [JTBD 1 — structured format] | [N/N] | High/Med/Low |
| [JTBD 2] | [N/N] | High/Med/Low |

## Key Quotes (by theme)

### [Theme 1]
> "[Quote]" — [Role, company size]
> "[Quote]" — [Role, company size]

### [Theme 2]
> "[Quote]"

## What We Heard But Won't Act On *(signal vs. noise)*

| Item | Why not acting | What would change this |
|---|---|---|
| [Request or pain] | [Too rare / too low intensity / outside strategy] | [Threshold that would elevate it] |

## Recommended Next Steps

1. [Action 1 — e.g., "Write PRD for Opportunity 1 (highest priority)"]
2. [Action 2 — e.g., "Run 3 more interviews on Opportunity 2 before deciding"]
3. [Action 3]

## Raw Interview Notes
[Links to individual interview notes or append below]
```

## Quality Checklist

Before considering discovery complete:

**Research Design**
- [ ] Research brief has a specific decision it will inform
- [ ] Screener criteria ensure right participants
- [ ] Sample size ≥5 for qualitative findings

**Interview Quality**
- [ ] Questions ask about past behavior, not hypothetical future
- [ ] Exact quotes captured (not paraphrases)
- [ ] Frequency and intensity scored for each pain

**Synthesis**
- [ ] Insights clustered into themes independently, before synthesis session
- [ ] Each Opportunity Statement has ≥3 confirming interviews
- [ ] Signal vs. Noise filter applied — low-signal items documented separately
- [ ] JTBDs extracted in structured format

**Actionability**
- [ ] Opportunities are problems, not solutions
- [ ] Output connects to product-strategy (Opportunity Tree) or prd-writer (Opportunity Framing)
- [ ] Clear recommended next steps with owners

## Common Antipatterns

### Antipattern 1: Asking About the Future
**Symptom**: "Would you use a feature that...?" "How likely are you to...?"
**Why it fails**: Users are terrible at predicting their own behavior. They tell you what they think sounds good.
**Fix**: "Tell me about the last time you had to do X. Walk me through what happened."

### Antipattern 2: Building What Users Asked For
**Symptom**: User interview → feature list → PRD
**Why it fails**: Users request solutions to symptoms, not root causes.
**Fix**: When a user proposes a solution, ask "What would that let you do that you can't do now?" Keep asking until you hit a job.

### Antipattern 3: One-Time Research Projects
**Symptom**: Big research sprint every 6 months, nothing in between
**Why it fails**: Product context changes fast. Research goes stale. Teams stop trusting the data.
**Fix**: 1 interview per week, every week. Teresa Torres calls this "Continuous Discovery."

### Antipattern 4: Researcher Bias in Synthesis
**Symptom**: Synthesis session confirms what the team already believed
**Fix**: Write down individual insights BEFORE the group synthesis session. Force independent interpretation.

### Antipattern 5: Confusing Intensity With Frequency
**Symptom**: One user ranted passionately, so you build for that use case
**Fix**: Both frequency AND intensity matter. One passionate outlier ≠ validated opportunity. Require ≥3 independent mentions.

## Reference Resources

- `references/interview-guide.md` — Full interview guide with follow-up questions by scenario
- `references/synthesis-template.md` — Step-by-step synthesis worksheet for group sessions
