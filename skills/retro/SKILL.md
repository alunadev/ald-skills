---
name: retro
description: "Facilitates a sprint retrospective using Start/Stop/Continue, 4Ls, or Sailboat format, producing 2-3 prioritized action items with owners and deadlines. Use after a sprint or milestone to drive continuous improvement. Triggers on: retrospective, retro, sprint review, what went well, lessons learned, team improvement, action items, start stop continue, post-mortem, sprint reflection."
---

# Retrospective (Retro)

## Core Philosophy

A retro that produces no action items is a venting session with good intentions. The measure of a retro is not the quality of the conversation — it's whether anything changed in the next sprint.

Limit action items to 2-3. More than that means none of them will get done. Be specific and assign an owner. "We should improve communication" is not an action item. "Maria will set up a 15-minute daily sync starting Monday" is.

## When to Use

- End of every sprint (or bi-weekly if sprints overlap)
- After any significant milestone, launch, or incident
- When team morale or velocity is declining and the cause is unclear
- When the same problems keep recurring sprint after sprint

## Workflow

### 1. Choose a Format

Pick based on team maturity and what the sprint needs:

**Start / Stop / Continue** *(default — versatile, familiar)*
- **Start**: What should we begin doing?
- **Stop**: What should we stop doing?
- **Continue**: What's working well that we should keep?

**4Ls** *(for deeper reflection after a major milestone)*
- **Liked**: What did the team enjoy?
- **Learned**: What new knowledge did we gain?
- **Lacked**: What was missing?
- **Longed For**: What do we wish we had?

**Sailboat** *(when team is stuck or unmotivated)*
- **Wind (propels us)**: What's driving us forward?
- **Anchor (holds us back)**: What's slowing us down?
- **Rocks (risks ahead)**: What dangers are coming?
- **Island (goal)**: Where are we trying to get to?

### 2. Review Sprint Performance

Before soliciting feedback, anchor the conversation in data:
- Sprint goal: achieved / partially achieved / missed
- Committed vs. completed story points
- Blockers that arose and how they were resolved
- Notable events (incidents, unplanned work, scope changes)

### 3. Collect and Group Feedback

If running async or with sticky notes: group similar items into themes. Identify the top 3-5 most mentioned topics. Note sentiment — frustration vs. energy vs. confusion.

If running synchronously: timebox each section (5-7 min per category), then vote on the most important items to discuss.

### 4. Discuss Root Causes, Not Symptoms

For the top themes, ask "why" twice:
- "We were blocked on the API" → Why? → "We didn't confirm external availability" → Why? → "We didn't include it in sprint planning"

The action item should address the root cause, not the symptom.

### 5. Define 2-3 Action Items

Each must be:
- **Specific**: "Add external dependencies to sprint planning checklist" not "communicate better"
- **Owned**: One named person responsible for doing or driving it
- **Time-bound**: A deadline or the next sprint date
- **Measurable**: You should be able to confirm next retro whether it was done

### 6. Check Previous Retro Actions

Pull last retro's action items. Status each: Done / In Progress / Not Started. If "Not Started" for the second time, either assign a new owner or explicitly drop it.

## Output Format

```
## Retrospective — Sprint [N] — [Date]

### Sprint Performance
- Goal: [Achieved / Partially / Missed] — [one sentence on why]
- Committed: [X pts] | Completed: [Y pts]

### Key Themes
1. [Theme] — [Summary of feedback, root cause]
2. [Theme] — [Summary]
3. [Theme] — [Summary]

### Action Items
| # | Action | Owner | By |
|---|---|---|---|
| 1 | [Specific action] | [Name] | [Date / Next sprint] |
| 2 | [Specific action] | [Name] | [Date] |

### Previous Retro Actions — Status Check
- [Previous action] → [Done / In Progress / Dropped — reason]
```

## Antipatterns

- **No action items**: The retro felt good but nothing changed. If there's genuinely nothing to improve, you're not looking hard enough.
- **Too many action items**: 8 action items = 0 action items. Prioritize ruthlessly.
- **Vague actions**: "Improve communication" or "be more proactive" cannot be completed or measured. Force specificity.
- **No owner**: Shared ownership is no ownership. Every action item needs one person's name.
- **Skipping the previous actions check**: This is how retros become theater. If you never review whether last retro's actions were done, teams stop believing the exercise matters.
- **Blame framing**: A retro focused on who failed rather than why systems failed. Keep the language systemic, not personal.
