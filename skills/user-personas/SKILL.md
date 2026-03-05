---
name: user-personas
description: "Creates research-backed user personas with JTBD, pain points, gains, and unexpected behavioral insights. Use when building personas from survey or interview data, or segmenting users to inform product decisions. Triggers on: user persona, user profile, customer segment, jobs-to-be-done, JTBD, persona creation, user segmentation, target user, who are our users."
---

# User Personas

## Core Philosophy

Personas are not marketing archetypes. They're decision tools. A good persona answers: *who are we optimizing for when we have to make a trade-off?* If your personas are interchangeable or describe everyone equally, they're useless.

Ground every insight in actual research data. A persona invented in a workshop is worse than no persona — it gives false confidence for wrong decisions.

## When to Use

- After user interviews or surveys — to synthesize findings into actionable profiles
- Before defining product scope — to force explicit prioritization of which user to serve
- When roadmap debates stall — to tie features back to specific user needs with evidence
- When user-discovery is complete and needs to feed into a PRD or strategy document

## Workflow

### 1. Gather and Read the Research Data

Before writing anything, read all available inputs: interview transcripts, survey responses, support tickets, behavioral analytics, NPS comments. If no data exists, run user-discovery first — don't create fictional personas.

### 2. Identify Patterns, Not Individuals

Look for recurring combinations of:
- **Goals**: What outcome are they ultimately trying to achieve?
- **Context**: When and in what environment do they use the product?
- **Blockers**: What consistently prevents them from achieving their goal?
- **Workarounds**: What do they do today in the absence of a better solution?
- **Trigger events**: What causes them to start looking for a solution?

### 3. Define 3 Personas (Not More)

More than 3 personas is usually a sign you're describing individuals, not segments. Each persona must be:
- **Distinct**: Different primary goal or context, not just different demographics
- **Grounded**: At least 3 data points from actual users to support each claim
- **Actionable**: If two features conflict, this persona tells you which to prioritize

For each persona:

| Field | Content |
|---|---|
| **Name + Role** | Memorable name, role/title, key characteristics |
| **Primary JTBD** | One sentence: "When [context], I want to [goal] so I can [outcome]" |
| **Top 3 pain points** | Specific obstacles — frequency and severity matter |
| **Top 3 desired gains** | Concrete outcomes they'd pay for or switch for |
| **One unexpected insight** | Something counterintuitive the data revealed about their behavior |
| **Product fit** | How the product addresses their needs — and where it falls short |

### 4. Validate Against Data

Cross-check each persona claim: can you point to 3+ users who exhibit this behavior? If not, downgrade to a hypothesis and flag it.

### 5. Define the Primary Persona

One persona must be explicitly primary — the one you optimize for when trade-offs arise. State why.

## Output Format

```
## User Personas — [Product Name]

### Primary Persona: [Name]
- Role: [Title / Context]
- JTBD: When [situation], I want to [goal] so I can [outcome].
- Pain points: [1] / [2] / [3]
- Desired gains: [1] / [2] / [3]
- Unexpected insight: [Counterintuitive behavioral finding]
- Product fit: [What works] / [What's missing]

### Persona 2: [Name]
[Same structure]

### Persona 3: [Name]
[Same structure]

### Prioritization Note
Primary persona: [Name]. Rationale: [Why this segment is the optimization target]
```

## Antipatterns

- **Demographic personas**: Defining personas by age, gender, or geography without a behavioral or motivational basis. Demographics don't predict decisions — jobs-to-be-done do.
- **Consensus personas**: Created in a workshop by voting on guesses. This is fiction with professional packaging.
- **Too many personas**: 6+ personas means you're describing everyone and optimizing for no one.
- **No primary designation**: If all personas are equal, trade-off decisions still get made by whoever argues loudest.
- **Static personas**: Revisit personas when new research arrives. A persona that's 18 months old may no longer reflect your actual user base.
