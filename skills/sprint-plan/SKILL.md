---
name: sprint-plan
description: "Plans a sprint with capacity estimation, story selection, dependency mapping, and risk identification. Use when preparing for sprint planning, estimating team capacity, or balancing scope against velocity. Triggers on: sprint planning, sprint plan, capacity planning, sprint scope, story points, sprint goal, backlog grooming, sprint prep, what do we build this sprint."
---

# Sprint Plan

## Core Philosophy

Sprint planning is a commitment, not a wish list. The goal is not to stuff the sprint with as many stories as possible — it's to make a realistic promise the team can keep. An under-committed sprint that ships is better than an over-committed sprint that leaves things half-done.

The sprint goal is the contract. Every story in the sprint should directly serve it.

## When to Use

- Before the start of a new sprint
- When backlog needs to be sequenced and stories need capacity estimates
- When a sprint is at risk and scope needs to be cut

## Workflow

### 1. Set the Sprint Goal

One sentence. What does success look like at the end of this sprint — from a user or business perspective, not an engineering perspective?

- Bad: "Complete stories 45-52"
- Good: "Users can complete onboarding without contacting support"

The sprint goal is the tiebreaker when scope decisions arise mid-sprint.

### 2. Estimate Team Capacity

- List each team member and their availability (working days minus PTO, holidays, on-call)
- Reference velocity from the last 3 sprints (average story points completed)
- Apply a 15-20% buffer for unexpected work, bugs, and interruptions
- Result: Available capacity in story points for this sprint

### 3. Select Stories from the Prioritized Backlog

- Pull from the top of the prioritized backlog (highest priority first)
- Each story must meet the Definition of Ready: clear acceptance criteria, estimated, no open blockers
- Flag stories that need refinement — don't commit to them until they're ready
- Stop adding stories when capacity is reached

### 4. Map Dependencies

- Identify which stories depend on other stories or external teams
- Sequence dependent stories appropriately (don't start Story B before Story A is done)
- Flag external dependencies by name: who owns them, what's the expected date?
- Identify the critical path — the sequence of stories that determines the minimum sprint duration

### 5. Identify Risks

- High uncertainty stories (large unknowns in implementation)
- External dependencies that could slip
- Knowledge concentration (only one person can do it)
- For each risk: suggest a mitigation or a decision point

### 6. Write the Sprint Summary

## Output Format

```
## Sprint Plan — Sprint [N] — [Start Date] to [End Date]

**Sprint Goal**: [One sentence — user or business outcome]

**Team Capacity**
- Available: [X] story points
- Committed: [Y] story points
- Buffer: [Z] story points

**Stories Committed**
| Story | Points | Owner | Dependencies |
|---|---|---|---|
| [Title] | [pts] | [name] | [none / Story X / Team Y] |

**Dependencies**
- [External dependency] — Owner: [name] — Expected: [date]

**Risks**
| Risk | Mitigation |
|---|---|
| [High uncertainty in Story X] | [Spike in Day 1-2 to reduce unknowns] |

**Critical Path**
[Story A] → [Story B] → [Story C]
```

## Antipatterns

- **Optimistic capacity**: Not accounting for meetings, reviews, on-call, or context-switching. Real capacity is typically 60-70% of theoretical hours.
- **No sprint goal**: A sprint with only a story list has no North Star for mid-sprint decisions. When something breaks, what gets cut?
- **Committing unready stories**: Starting a sprint with stories that don't have clear acceptance criteria. They'll block mid-sprint.
- **Ignoring dependencies**: Discovering that Story B can't start because Team X hasn't delivered their API — on Day 3 of the sprint.
- **Velocity as a target**: Velocity is a planning tool, not a performance metric. Pressuring teams to hit a velocity number inflates estimates over time.
