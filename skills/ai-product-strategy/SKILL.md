---
name: ai-product-strategy
description: >
  Expert strategy advisor for products built on LLMs or agents — not general product strategy
  (see `product-strategy` for that). Use this — proactively and without waiting to be asked —
  whenever choosing where to apply AI in a product, deciding between RAG and fine-tuning,
  designing how much autonomy an AI feature should have, evaluating whether an AI feature is
  actually defensible, or deciding whether to add AI to a feature at all. Also triggers for:
  "should this be an agent or a simple LLM call", "how much autonomy should this feature have",
  "RAG vs fine-tuning", "is this AI feature defensible", "our AI feature keeps hallucinating and
  users don't trust it", "should we build this with AI or just ship it deterministic", "AI product
  wedge", "what happens to this feature when the models get better", "human-in-the-loop design for
  AI features". Produces a decision-focused brief: the wedge, the architecture choice, the autonomy
  level, and the defensibility bet — each with an explicit trade-off.
---

# AI Product Strategy

This skill produces decision-focused strategy for products where an LLM or agent does real work — not chatbots bolted onto a feature list. It exists because AI products fail on decisions general product strategy doesn't force you to make: how wrong the model is allowed to be, how much autonomy to hand it, and what happens to your product when the underlying model gets better next quarter.

For strategy questions that aren't AI-specific — North Star, roadmap bets, OKRs — use `product-strategy` instead. Use this skill only when the AI/LLM component is the thing actually being decided.

## Core Philosophy

**The model will get better. Your moat has to survive that.**

Most AI feature scaffolding — the prompt chains, the retry logic, the manual fixes for today's model's specific weaknesses — gets absorbed by the next model generation within a year or two. This is sometimes called the Bitter Lesson: general methods that scale with more compute and better models eventually beat hand-engineered workarounds. A great AI product strategy in 2026:

- Picks a wedge — a high-friction task — where AI gives disproportionate leverage, not a generic "add AI" feature
- Treats output correctness as probabilistic from day one, not as a bug to eliminate before launch
- Builds defensibility from data and workflow depth, not from prompt engineering that a better model makes obsolete
- Scales autonomy deliberately, starting where a wrong answer costs little and control is easy to keep

**The fatal flaw of bad AI product strategy**: shipping a feature whose entire value proposition disappears the day a foundation lab ships a slightly better model.

## When to use this skill

- Before building any feature where an LLM decides something or generates something a user acts on
- When choosing between RAG and fine-tuning (or deciding you need neither)
- When an AI feature is live but users don't trust it, or it's making too many visible mistakes
- When deciding how much a feature should act on its own vs. ask for confirmation
- When a stakeholder wants to "add AI" to something and you need to test whether that's real value or theater
- When evaluating whether an AI feature has any defensibility beyond "we called the API first"

## Key Principles

1. **Wedge over feature list** — one high-friction task solved disproportionately well beats ten shallow AI touches.
2. **Design for wrong answers** — the interface must stay useful when the model is confidently incorrect, because it will be.
3. **Autonomy is earned, not assumed** — start where mistakes are cheap and reversible, expand only as accuracy is observed, not hoped for.
4. **Durable advantage is data and workflow, not prompts** — a system prompt is not a moat; accumulated proprietary data and deep workflow integration are.
5. **Build for the capability curve** — ask what this feature looks like when the model is meaningfully better, not just whether it works today.

## Workflow

### Step 1: Define the Wedge

Before any architecture decision, name the specific high-friction task AI will own.

Ask the user:
> "What's the task your users currently do by hand that's tedious, error-prone, or expensive in time — and where being wrong occasionally is a cost they'd accept for being fast most of the time?"

**Format:**
```
Wedge: [The specific chore or decision AI will take over]
Who feels the friction today: [User segment]
Current cost: [Time, error rate, or money spent doing this manually]
Why AI specifically: [What makes this a probabilistic-reasoning or generation problem, not a deterministic one]
Disproportionate payoff test: [Would a 70%-correct AI version still beat doing nothing, or the manual status quo?]
```

If the answer to the disproportionate payoff test is no, stop — this isn't a wedge, it's a feature that needs to be right, and probably shouldn't be AI-first.

### Step 2: Choose the Architecture

Decide between RAG, fine-tuning, both, or neither — based on what the wedge actually needs, not on what's trendy.

**Decision test:**
```
Does the task need live, current, or user-specific data to answer correctly?
  → Yes: RAG (retrieval-augmented generation) — ground responses in retrieved context
  → No: skip to the next question

Does the task need a specific, consistent behavior, tone, or output structure
that's hard to specify reliably in a prompt?
  → Yes: fine-tuning (or a strong system prompt + structured output first — cheaper, try this before fine-tuning)
  → No: a well-prompted base model call may be enough — don't over-engineer
```

Most products need RAG for correctness and a well-designed prompt for behavior; few need fine-tuning at all in the first version. Fine-tuning is expensive to maintain (it re-couples you to a specific model version) — treat it as a step you earn after prompt-based approaches provably fail, not a default.

See `references/decision-frameworks.md` for the full RAG-vs-fine-tuning matrix with concrete examples.

### Step 3: Design for Non-Determinism

The interface must assume the model will sometimes be wrong, incomplete, or overconfident — this isn't an edge case to patch later, it's the default operating condition.

**Non-determinism checklist:**
```
□ What does the user see when the model is confidently wrong? (Not: what happens if it errors — errors are the easy case.)
□ Is there a fast, low-friction way to correct or override the output?
□ Does the UI communicate confidence, or does it present every answer with the same authority?
□ What's the blast radius of a wrong answer — cosmetic, wasted time, or costly/irreversible?
□ Is there a fallback to the pre-AI manual path when the AI path clearly fails?
```

A feature that only works when the model is right isn't a product yet — it's a demo.

### Step 4: Scale Autonomy Deliberately

Define which of four levels the feature operates at today, and what evidence would justify moving to the next one.

**The autonomy ladder:**
```
L0 — Suggest only: AI proposes, human does the work of accepting/rejecting/editing every time.
L1 — Act with confirmation: AI drafts the action, human approves before it executes.
L2 — Act with easy undo: AI executes automatically, human can trivially reverse within a window.
L3 — Full autonomy: AI executes and is trusted without per-action review; humans audit in aggregate.
```

**Format:**
```
Current level: [L0-L3]
Why this level: [What makes a wrong action at this level cheap/reversible enough]
Evidence needed to advance: [Specific accuracy rate, user trust signal, or volume of clean runs]
What would force a downgrade: [What failure pattern would mean pulling back autonomy]
```

Start at L0 or L1 for anything with real cost attached to a mistake. Jumping straight to L3 because the demo looked good is the most common way AI features lose user trust permanently.

### Step 5: Assess Defensibility

Name where the actual moat is — if there isn't one yet, say so honestly rather than inventing one.

**Defensibility stack, roughly in order of durability:**
```
1. Proprietary data flywheel: usage generates data that makes the product better, and competitors can't access that data.
2. Workflow depth / switching cost: the product is embedded deep enough in a process that ripping it out is expensive.
3. Verticalization: domain-specific expertise and integrations a horizontal foundation-model wrapper won't build.
4. Interface / UX craft: a meaningfully better experience around the same underlying model capability.
5. Being first with a thin wrapper on a foundation model API: this is not a moat — assume it's gone within a model generation.
```

**Format:**
```
Where the moat actually is: [Pick from the stack above — be honest if the answer is "nowhere yet"]
What would erode it: [A specific foundation model capability jump, or a competitor doing X]
What we're building to strengthen it: [Concrete investment, not aspiration]
```

### Step 6: Output

Save the strategy brief:
```
docs/strategy/YYYY-MM-DD-[feature]-ai-strategy.md
```

## Output Format

```markdown
# [Feature] — AI Product Strategy

**Owner:** [Name]
**Status:** Draft / Reviewed / Approved
**Last Updated:** [Date]

## The Wedge
[Task, who feels the friction, current cost, why AI, disproportionate payoff test]

## Architecture
[RAG / fine-tuning / neither — with rationale from the decision test]

## Non-Determinism Design
[How the interface handles wrong/uncertain output — checklist results]

## Autonomy Level
[Current level, why, evidence needed to advance, what forces a downgrade]

## Defensibility
[Where the moat is on the stack, what erodes it, what we're building to strengthen it]

## Build-for-the-Curve Check
[What does this feature look like in 12-18 months if the model gets meaningfully better —
does the value survive, or does it evaporate?]

## Open Questions
[What we still need evidence for, with owners]
```

## Quality Checklist

Before considering the strategy complete:

**Wedge**
- [ ] The task is specific, not "add AI to the product"
- [ ] The disproportionate-payoff test has an honest answer, not an assumed yes

**Architecture**
- [ ] RAG vs. fine-tuning vs. neither is justified by the actual data/behavior need, not by trend
- [ ] Fine-tuning (if chosen) was picked after simpler prompt-based approaches were shown insufficient

**Non-Determinism**
- [ ] The UI has a defined behavior for confidently-wrong output, not just for errors
- [ ] There's a correction or override path a user can actually find and use

**Autonomy**
- [ ] The current level matches the real cost of a mistake, not the most impressive demo
- [ ] There's a named evidence bar for moving up a level, and a named trigger for moving down

**Defensibility**
- [ ] The moat claim is one of the durable kinds (data, workflow, vertical depth) — not "we shipped first"
- [ ] The 12-18 month check has been done honestly, including the possibility the answer is uncomfortable

## Common Antipatterns

### Antipattern 1: Scaffolding for Today's Model
**Symptom**: Elaborate prompt chains and manual patches built around a specific model's current weaknesses.
**Fix**: Ask if the model will likely absorb this capability in 12-18 months. If yes, the effort belongs in the product's data or workflow layer, not in fighting the model.

### Antipattern 2: AI for Its Own Sake
**Symptom**: An AI feature exists because AI is expected, not because a validated user problem needs probabilistic reasoning or generation.
**Fix**: Run the wedge test. No real friction, no disproportionate payoff → it shouldn't be an AI feature.

### Antipattern 3: Assuming Away the Wrongness
**Symptom**: The product was designed and tested as if the model is always right, so it breaks visibly and often when it isn't.
**Fix**: Design the non-determinism checklist first, not as a bug-fix pass after launch.

### Antipattern 4: Autonomy Creep Without Evidence
**Symptom**: A feature jumps from suggestion to full autonomous action because the demo went well, not because accuracy was measured in production.
**Fix**: Name the evidence bar for each autonomy level before shipping the current one, and hold to it.

### Antipattern 5: Prompt Engineering as a Moat
**Symptom**: The team's competitive advantage claim rests entirely on "we have a really good system prompt."
**Fix**: A well-tuned prompt is table stakes, not defensibility. Point to data, workflow depth, or vertical expertise instead — or admit there isn't a moat yet.

## Reference Resources

- `references/decision-frameworks.md` — RAG vs. fine-tuning matrix with examples, full autonomy-ladder detail, defensibility-stack worked examples
