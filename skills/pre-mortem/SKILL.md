---
name: pre-mortem
description: "Runs a structured pre-mortem on a PRD or launch plan, categorizing risks as Tigers, Paper Tigers, and Elephants, with launch-blocking action plans. Use before any significant product launch or execution milestone. Triggers on: pre-mortem, risk analysis, launch readiness, what could go wrong, launch risks, risk mitigation, launch blockers, stress-test plan."
---

# Pre-Mortem

## Core Philosophy

A pre-mortem assumes failure and works backward. Instead of asking "what could go wrong?", you ask "it's 3 months post-launch and it failed — what happened?"

This framing bypasses optimism bias and social pressure. People who would never say "I think this will fail" in a planning meeting will freely describe how it failed after the fact. The pre-mortem is a structured permission structure to surface what everyone suspects but nobody says.

## When to Use

- Before any significant product launch or feature release
- After a PRD is written but before engineering begins — while it's still cheap to change
- Before a major business decision (pricing change, market entry, partnership)
- When a plan feels too clean and assumptions haven't been challenged

## Workflow

### 1. Read the PRD or Launch Plan

Understand the product, the assumptions, the timeline, the success criteria, and the key dependencies. If a PRD doesn't exist, create a one-page summary of the plan first.

### 2. Assume Failure

Set the frame: "It is 14 weeks from now. The launch happened. It failed. Revenue is below target, adoption is low, or a critical defect was found in production. What went wrong?"

Generate a list of failure modes. Do not filter at this stage — capture everything.

### 3. Categorize Risks

**Tigers** — Real problems you personally see that could derail the project
- Based on evidence, past experience, or clear logic
- Require action before launch
- These should keep you awake at night

**Paper Tigers** — Concerns others might raise, but you don't believe are genuine risks
- Valid on the surface, but unlikely or overblown
- Worth documenting to resolve stakeholder anxiety
- Not worth significant resource investment

**Elephants** — Topics the team isn't discussing enough
- Unspoken concerns, uncomfortable assumptions, decisions no one has made
- You're not sure if they're real risks — that uncertainty is itself a signal
- Require investigation, not just acknowledgment

### 4. Classify Tigers by Urgency

**Launch-Blocking**: Must be resolved before launch
- Core feature broken or incomplete
- Regulatory or legal blocker
- Key dependency not confirmed

**Fast-Follow**: Must be resolved within 30 days of launch
- Performance issues under load
- Secondary features missing for a key segment
- Monitoring gaps

**Track**: Monitor post-launch; act if it becomes a real problem
- Edge cases, nice-to-have capabilities
- Low-frequency scenarios

### 5. Build Action Plans for Launch-Blocking Tigers

For each:
- **Risk**: Clear description of the failure mode
- **Mitigation**: Specific action to prevent or reduce impact
- **Owner**: Who is responsible for the mitigation
- **Due date**: When this must be resolved

### 6. Align the Team

Share the pre-mortem output in a working session. The goal is not consensus — it's to ensure everyone agrees on which risks are real and who owns them.

## Output Format

```
## Pre-Mortem — [Product Name] — [Date]

### Tigers (Real Risks)
| Risk | Urgency | Mitigation | Owner | Due |
|---|---|---|---|---|
| [Description] | Launch-Blocking / Fast-Follow / Track | [Action] | [Name] | [Date] |

### Paper Tigers (Overblown Concerns)
- [Risk]: [Why it's not a genuine blocker]

### Elephants (Unspoken Worries)
- [Topic]: [What needs to be investigated or decided]

### Launch Readiness Signal
Based on Tigers: [Ready to launch / Blocked by X / Conditional on Y]
```

## Antipatterns

- **Blame framing**: Pre-mortems are about systemic risks, not individual fault. Keep the discussion focused on failure modes, not people.
- **Filtering too early**: Suppressing risks that feel embarrassing or politically sensitive. The worst failures usually come from the things nobody wanted to say.
- **All Paper Tigers**: If everything gets downgraded to overblown, you've run a cheerleading session, not a risk analysis.
- **No owner on mitigations**: A risk with no owner is a risk that will materialize. Every launch-blocking Tiger needs a named person responsible for the mitigation.
- **One-time exercise**: Revisit the pre-mortem 2-3 weeks before launch to verify mitigations are on track, not just documented.
