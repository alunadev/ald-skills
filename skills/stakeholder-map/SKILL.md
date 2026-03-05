---
name: stakeholder-map
description: "Builds a Power × Interest stakeholder map and generates a communication plan per quadrant. Use when managing a complex launch, aligning cross-functional teams, or preparing stakeholder engagement strategy. Triggers on: stakeholder management, stakeholder map, stakeholder alignment, communication plan, power interest grid, cross-functional alignment, executive alignment, managing up."
---

# Stakeholder Map

## Core Philosophy

Stakeholder management is not about making everyone happy — it's about preventing surprises. The most dangerous stakeholder is not the one who disagrees loudly; it's the one with high power who's been silent. By the time they speak up, it's too late to change course.

Map early. Communicate consistently. Find conflicts before launch, not during.

## When to Use

- Before a major product launch or roadmap reveal
- When a project spans multiple teams or functions
- When an important stakeholder has gone quiet
- Before presenting to executives — to anticipate pushback and prepare
- When organizational dynamics are unclear for a new project

## Workflow

### 1. List All Stakeholders

Include everyone who can affect or be affected by the outcome:
- Internal: Engineering leads, design, marketing, sales, legal, finance, data, executives
- External: Key customers, partners, regulators (if relevant)

Don't filter at this stage — over-listing is safer than missing someone.

### 2. Plot on the Power × Interest Grid

**Power**: Their ability to influence decisions, resources, or outcomes (High / Low)
**Interest**: How much the project directly affects them or how engaged they are (High / Low)

| | High Interest | Low Interest |
|---|---|---|
| **High Power** | **Manage Closely** — Involve in decisions, update frequently, seek input early | **Keep Satisfied** — Periodic updates, only escalate critical issues |
| **Low Power** | **Keep Informed** — Regular status updates, invite to demos, gather feedback | **Monitor** — Light-touch updates, available on request |

### 3. Define a Communication Strategy Per Quadrant

**Manage Closely (High Power / High Interest)**
- Frequency: Weekly or per major milestone
- Format: 1:1 or small group; decision-required meetings
- Goal: No surprises; their concerns are surfaced and resolved before they escalate
- Risk if neglected: Can block or kill the project

**Keep Satisfied (High Power / Low Interest)**
- Frequency: Bi-weekly or monthly
- Format: Short written update or exec summary; async preferred
- Goal: Awareness without overwhelming them
- Risk if neglected: Uninformed power = surprise veto

**Keep Informed (Low Power / High Interest)**
- Frequency: Weekly progress updates or sprint demos
- Format: Email update, Slack channel, or demo invite
- Goal: Keep them engaged; they often surface operational risks you'd miss
- Risk if neglected: Creates perception that you're hiding things

**Monitor (Low Power / Low Interest)**
- Frequency: Monthly or quarterly newsletter/update
- Format: Broadcast communication
- Goal: Available and informed; no action required
- Risk if neglected: Low — but they can shift to other quadrants if the project affects them more than expected

### 4. Identify Conflicts

Map stakeholders who have competing interests. These are your highest-risk relationships:
- Stakeholder A wants fast launch; Stakeholder B wants 3 months of QA
- Stakeholder A owns budget; Stakeholder B owns timeline

For each conflict: identify the decision that will resolve it, who needs to make that call, and when.

### 5. Build the Communication Plan

Translate the grid into a concrete schedule.

## Output Format

```
## Stakeholder Map — [Project Name]

### Power × Interest Grid

**Manage Closely**
- [Name] — [Role] — Why: [reason for high power + interest]
- ...

**Keep Satisfied**
- [Name] — [Role] — Why: [reason]

**Keep Informed**
- [Name] — [Role] — Why: [reason]

**Monitor**
- [Name] — [Role] — Why: [reason]

### Communication Plan

| Stakeholder | Quadrant | Frequency | Format | Key Message | Owner |
|---|---|---|---|---|---|

### Conflict Map
- [Stakeholder A] vs [Stakeholder B]: [Competing interest] → [Resolution path]
```

## Antipatterns

- **Mapping without acting**: A stakeholder map that lives in a document nobody reads. The value is in the weekly communication cadence it drives, not the map itself.
- **Flattering the org chart**: Assuming formal seniority = high power. The real power holders are often not the ones with the biggest titles.
- **Static maps**: Stakeholder power and interest shift as projects progress. Update the map after major milestones or organizational changes.
- **Ignoring the Monitor quadrant**: Low-power / low-interest stakeholders can shift quadrants when projects affect them. Keep a light but consistent pulse.
- **Over-communicating to everyone**: Sending the same detailed update to all quadrants wastes their time and yours. Tailor depth to the quadrant.
