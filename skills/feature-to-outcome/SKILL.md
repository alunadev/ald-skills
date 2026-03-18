---
name: feature-to-outcome
description: >
  Translates stakeholder feature requests into validated outcome statements before any work is
  committed. Use this skill — proactively and without waiting to be asked — whenever a stakeholder,
  exec, or customer arrives with a pre-packaged solution: "we need a dashboard", "add a Slack
  notification", "build an export feature", "create a report", "let's add a filter", "can we just
  add X". Also triggers for: "how do I push back on this request", "what outcome does this feature
  solve", "outcome vs output", "outcomes not features", "what are we really trying to achieve",
  "we're being a feature factory", "I need to reframe this as a problem", "the stakeholder is
  pushing a specific solution", "discovery before delivery", "assumption testing", "translate this
  request into an outcome", "ship outcomes not features". Runs the 'One Framework. Four Questions.'
  protocol (Liatti + Cagan + Torres): Behavior Change → Assumption Test → Cheapest Test → Success
  Metric. Produces an Outcome Brief with embedded AI prompts ready to paste into any LLM.
---

# Feature → Outcome

> *"Most product managers believe they're outcome-driven. Sprint after sprint, they ship features — not because they lack ambition, but because the system makes features the path of least resistance."*
> — Nicolas Liatti

---

## Core Philosophy

A feature is a hypothesis. An outcome is the target. Shipping a feature without a clear outcome is the same as running an experiment without a hypothesis — you'll generate data, but you won't learn anything useful.

The **build trap** (Melissa Perri) happens when teams optimize for output — features shipped, tickets closed, story points burned — instead of for the behavior change those outputs were supposed to produce. Features feel safe because they're shippable. Outcomes feel risky because they're measurable.

**Behavior change is the atomic unit of product work.** Every feature exists to make a user do something differently. If you can't name that behavior, you're not solving a problem — you're executing a solution someone handed you.

The good news: AI compresses the diagnosis dramatically. You don't need a discovery sprint to run this protocol. You can do it in 20 minutes, in the same conversation where the stakeholder pitched you the idea.

---

## The System Working Against You

Three structural forces push teams toward feature factories:

1. **Stakeholders speak in solutions.** "We need a dashboard" is easier to act on than "improve user retention by 12%." Solutions feel concrete. Outcomes feel vague — until you make them specific.

2. **Outcomes aren't shippable.** Your Jira board accepts tickets, not behavior changes. Nobody's sprint velocity goes up when a metric moves. The system rewards output.

3. **The feedback loop is too slow.** By the time you understand whether a feature moved the needle, the next quarter's roadmap is already locked. So you never build the muscle.

This skill attacks all three problems: it makes outcomes concrete and specific, it produces a shippable artifact (the Outcome Brief), and it closes the feedback loop before engineering even starts.

---

## When to Use

- A stakeholder walks in with a specific feature request
- A roadmap item is described as a feature, not a problem
- You're about to write a PRD for something nobody validated
- A customer request is being treated as a requirement
- Engineering is about to spec a sprint and nobody has named the outcome
- You feel like you're in "feature factory" mode and want to reset

---

## One Framework. Four Questions.

```
Feature Request
      ↓
Q1: What behavior change does this produce?
      ↓
Q2: What assumption must be true for this to work?
      ↓
Q3: What's the cheapest way to test that assumption?
      ↓
Q4: What metric confirms the behavior changed?
      ↓
Outcome Brief
```

Run these four questions in order. Each one builds on the previous answer. You can use AI to accelerate each step — the prompts are embedded below.

---

## Workflow

### Step 0 — Capture the Feature as Stated

Before diagnosing, write down the feature request **verbatim**, exactly as the stakeholder said it. Don't interpret, improve, or translate it yet.

> "We need a dashboard."
> "Add email notifications when a report is ready."
> "Can we build an export to CSV feature?"

This verbatim capture matters because you'll include it in the Outcome Brief, so stakeholders can see you heard them — before you redirect the conversation.

---

### Step 1 (Q1) — What Behavior Change Might This Produce?

A feature is a solution. A dashboard isn't a goal — it's a tool. Before you accept the tool, name the behavior it's supposed to enable.

The key question: **What would users do differently if this feature existed?**

This sounds obvious. It isn't. "A dashboard" could mean three completely different problems depending on which user is asking and what they currently do without it. One feature request often hides 5-7 distinct behavior changes, with very different implications for what to actually build.

**AI prompt to run:**

```
A stakeholder just asked for [FEATURE REQUEST].

List 7 possible behavior changes this feature might enable or produce in users,
ranked from most to least specific. For each one, describe:
- Who does the behavior (which user segment)
- What they currently do instead
- How this feature would change that
```

**What to do with the output:** Pick the 1-2 behavior changes that are most plausible given what you know about your users. If you're not sure, that's your discovery signal — you need to talk to users before you build anything.

---

### Step 2 (Q2) — Why Might Our Solution Fail?

You've picked the target behavior. Now challenge the solution before engineering touches it.

Every feature rests on at least one assumption that must be true for it to work. If that assumption is false, the feature fails — even if it ships perfectly. Finding that assumption now takes 30 seconds. Finding it after launch costs a quarter.

**AI prompt to run:**

```
We want users to [BEHAVIOR FROM Q1].
We believe [FEATURE REQUEST] will produce that behavior change.

Name the single riskiest assumption that must be true for this solution to work.
Phrase it as: "This only works if [assumption]."
If this assumption were false, what would we build instead?
```

**What to do with the output:** If the assumption sounds shaky — if you can't confidently say "yes, we know this is true" — stop. Either validate it before speccing the feature, or redesign around a safer assumption.

This is the 30-second version of a senior design review. It doesn't replace talking to users, but it kills obvious bad bets before anyone writes a line of code.

---

### Step 3 (Q3) — What's the Cheapest Way to Test It Before Building?

You've named the riskiest assumption. Now de-risk it — before you spec a sprint.

The goal is not to eliminate uncertainty. It's to prove one thing in two weeks, without engineering, so the team bets on evidence instead of belief.

**AI prompt to run:**

```
We want to know if users will [BEHAVIOR FROM Q1] before we build [FEATURE REQUEST].
Our riskiest assumption is: [ASSUMPTION FROM Q2].

Design the cheapest experiment I can run in 2 weeks to test this assumption.
Give me 3-5 options, ordered from cheapest to most expensive.
For each option: what we'd learn, how we'd run it, and what a positive result looks like.
```

**What to do with the output:** Pick the cheapest option that would give you enough confidence to commit. "Enough confidence" means: if the experiment succeeds, you'd spec the feature. If it fails, you'd pivot.

---

### Step 4 (Q4) — What Metric Confirms the Behavior Changed?

Pick a metric that's easy to measure and actually useful. Binary outcomes ("did we ship it?") are too late — they tell you what happened after six weeks of work, not whether the bet is working.

You need **three time horizons**:
- **Week 1** — a leading indicator that signals early adoption (behavioral, not feature adoption)
- **Month 1** — a mid-term metric that confirms the behavior is changing
- **Day 90** — a lagging indicator tied to the business outcome

**AI prompt to run:**

```
Target behavior: users will [BEHAVIOR FROM Q1].

Generate a 3-horizon metric plan:
1. Week 1 — One leading indicator I can measure in the first week.
   Focus on behavioral signals (e.g., sessions, actions taken), not feature adoption (e.g., "feature used").
2. Month 1 — One metric measurable at 30 days that confirms the behavior is changing.
3. Day 90 — One lagging indicator tied to the business impact we care about.

For each metric: what it measures, how to track it, and what threshold would signal success.
```

**What to do with the output:** Assign an owner to each metric before the sprint starts. If nobody owns measuring it, it won't get measured.

---

### The Outcome Brief

Once you've run all four questions, synthesize everything into an Outcome Brief. Share it with the stakeholder *before* anyone writes a spec.

**AI prompt to generate the brief:**

```
Create a one-page Outcome Brief based on this information:

Feature as stated: [VERBATIM REQUEST]
Target behavior change: [FROM Q1]
Riskiest assumption: [FROM Q2]
Validation plan: [FROM Q3]
Success metrics: [FROM Q4]

Format it as a structured document. Keep it under one page.
It should be clear enough that an engineering lead and a CFO can both read it
and agree on what we're trying to achieve and how we'll know if it worked.
```

**Template (copy-paste ready):**

```markdown
## Outcome Brief: [Feature Name]

**Feature as stated:** [verbatim stakeholder request]

**Q1 — Target Behavior Change:**
[The specific behavior we want users to exhibit. 1-2 sentences. Who does it, what they do differently.]

**Q2 — Riskiest Assumption:**
This only works if: [assumption].
If false → [what we'd do instead].

**Q3 — Validation Plan (2 weeks, no engineering):**
[Cheapest experiment. What we'll learn. What a positive result looks like.]

**Q4 — Success Metrics:**
- Week 1 (leading indicator): [behavioral signal + threshold]
- Month 1 (mid metric): [behavior change measure + threshold]
- Day 90 (lagging indicator): [business impact + threshold]

**Outcome Statement:**
We believe [feature/solution] will produce [behavior change], measurable by [Week 1 metric].
We'll know within [timeframe] whether this assumption is true.

**Open questions before committing:**
- [ ] Have we talked to users who have this problem?
- [ ] Is this the cheapest way to produce the target behavior?
- [ ] Who owns measuring each metric?
- [ ] What do we do if the Week 1 indicator doesn't move?
```

---

## Adversarial Stress-Test

Once you have the Outcome Brief, run the skeptical CFO test. This surfaces the challenges stakeholders will raise — before the review meeting.

**AI prompt:**

```
Here is our Outcome Brief: [PASTE BRIEF]

You are a skeptical CFO who has seen dozens of product bets fail because
the team fell in love with the solution and stopped questioning the problem.
What are the 3 strongest objections you'd raise to this brief?
What would you need to see before you'd approve this investment?
```

Use the objections to strengthen the brief or identify gaps in your validation plan before you present.

---

## Pushback Patterns

When a stakeholder insists on the feature after seeing the Outcome Brief, try one of these:

**Pattern 1 — Outcome Agreement First**
> "I want to build this with you. Before we start, can we agree on one thing: what metric would tell us in 30 days that this worked? If we agree on that, I'll start the spec tomorrow."

**Pattern 2 — The Cheapest Test**
> "I'm not saying no to the feature. I'm saying let's spend 2 weeks proving the assumption before we spend 8 weeks building. If the test confirms users want this, we go fast."

**Pattern 3 — The Behavior Audit**
> "Walk me through what a user does today without this feature. Then walk me through what they do with it. If those two pictures are very different, I'm in. Let's make that picture concrete."

---

## Antipatterns

**Fake Outcomes**
Rebranding features as outcomes without changing the thinking. "Increase dashboard usage" is not an outcome — it's a feature adoption metric. The real outcome is what users do *because* they're using the dashboard.

**Metric Theater**
Picking metrics that are easy to measure but don't reflect behavior. "Feature was used X times" doesn't tell you whether the behavior changed. Track what users *do*, not what they *clicked*.

**Solution Laundering**
Running the four questions but building the original feature anyway, because the stakeholder had already told engineering. The brief is only useful if it can actually change the decision. If the decision is already made, be honest about it rather than running a fake process.

**Outcome Too Broad**
"Improve retention" is not an outcome — it's a metric. An outcome is a specific behavior: "Users who receive the weekly digest email open the product within 24 hours at a rate ≥ 40%." If you can't describe the behavior precisely, the outcome isn't ready to commit to.

---

## Quick Reference Card

Copy these four prompts. Fill in the brackets. Run them in order.

```
Q1: "A stakeholder just asked for [X]. List 7 possible behavior changes this feature
might produce, ranked from most to least specific."

Q2: "We want users to [BEHAVIOR]. We believe [SOLUTION] will produce that behavior.
Name the single riskiest assumption. If it's false, what do we do instead?"

Q3: "We want to know if users will [BEHAVIOR] before we build [SOLUTION].
Design 3-5 experiments, ordered cheapest to most expensive, to test in 2 weeks."

Q4: "Target behavior: users will [BEHAVIOR]. Generate: (1) Week 1 leading indicator,
(2) Month 1 mid metric, (3) Day 90 lagging indicator. Focus on behavioral signals."

BRIEF: "Create a one-page Outcome Brief. Feature as stated: [X]. Behavior: [Q1].
Assumption: [Q2]. Validation: [Q3]. Metrics: [Q4]."
```
