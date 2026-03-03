---
name: prompt-engineering-patterns
description: A library of reusable, production-tested prompt engineering patterns for building AI-powered features. Use when designing system prompts for apps, building AI pipelines, selecting the right prompting technique for a use case, or reviewing prompts for common failure modes. Complements the prompt-engineering skill (which covers the optimization framework); this skill covers the pattern library itself.
---

# Prompt Engineering Patterns

A curated library of patterns for building reliable AI features in production apps. Each pattern includes when to use it, the template, and what failure mode it solves.

## Pattern Index

| Pattern | Best For | Avoid When |
|---|---|---|
| Role + Constraint | Any system prompt baseline | Over-general tasks |
| Chain-of-Thought | Math, logic, reasoning | Content generation |
| Chain-of-Table | Structured data, analytics | Free-form text |
| Few-Shot | Style/format consistency | Reasoning models (o1, R1) |
| Multi-Shot Conversation | Support flows, sales bots | Single-turn tasks |
| Nested / Specialist | Complex multi-step pipelines | Simple single-step tasks |
| Structured Output | JSON/typed responses | Narrative content |
| Reflexion | Self-correction loops | Low-latency requirements |
| Tool-Use Routing | Agents with multiple tools | Fixed, predictable flows |

---

## Pattern 1: Role + Constraint (Foundation)

**Solves:** Vague, generic, unpredictable outputs.
**Use for:** Every system prompt — this is the baseline, always apply it.

```xml
<system_role>
You are [SPECIFIC ROLE], not a general AI assistant.
You [CORE FUNCTION] for [TARGET USER TYPE].
</system_role>

<hard_constraints>
NEVER:
- [FAILURE MODE 1 — specific behavior to block]
- [FAILURE MODE 2 — specific behavior to block]
- Use meta-phrases ("I can help you", "let me assist", "Great question!")

ALWAYS:
- [SUCCESS BEHAVIOR 1 — specific positive behavior]
- [SUCCESS BEHAVIOR 2 — specific positive behavior]
- Acknowledge uncertainty explicitly ("I'm not sure, but...")
</hard_constraints>
```

**Rule:** "Never do X" is more reliable than "Always be Y." Lead with constraints.

---

## Pattern 2: Chain-of-Thought (CoT)

**Solves:** Wrong answers on logic, math, or multi-step reasoning.
**Use for:** Calculations, deductions, formal reasoning chains.
**Do NOT use for:** Content generation, classification, style tasks — adds noise without benefit.

```
[Task description]

Think step by step:
1. First, identify...
2. Then, calculate...
3. Finally, conclude...

Show your reasoning before giving the final answer.
```

**Production note:** CoT only reliably improves on 100B+ parameter models. On smaller models, overhead can hurt.

---

## Pattern 3: Chain-of-Table

**Solves:** Poor performance on structured or tabular data.
**Use for:** Analytics dashboards, financial data, CSV processing, metrics.
**Performance:** ~8-9% improvement on table tasks vs plain prompting.

```
Given this data table:
[TABLE]

Process step by step:
Step 1 — Filter: Remove rows where [condition]
Step 2 — Group: Aggregate by [column]
Step 3 — Calculate: Compute [metric]
Step 4 — Format: Output as [structure]

Show each intermediate table, not just the final result.
```

---

## Pattern 4: Few-Shot Examples

**Solves:** Format inconsistency, style drift, wrong output structure.
**Use for:** When you need a specific output format or writing style.
**Do NOT use for:** Reasoning models (o1, DeepSeek R1) — examples interfere with their chain-of-thought.

```
Here are examples of the expected output format:

Example 1 — Happy path:
Input: [typical input]
Output: [desired output]

Example 2 — Edge case:
Input: [edge case input]
Output: [correct edge case handling]

Example 3 — Rejection:
Input: [input that should be refused/redirected]
Output: [correct refusal pattern]

Now process:
Input: [actual input]
Output:
```

**Warning:** Few-shot has the highest variability of any technique. 3 wrong examples hurt more than 0 examples. Always test systematically.

---

## Pattern 5: Multi-Shot Conversation

**Solves:** Bots that respond well in isolation but break conversational flow.
**Use for:** Customer support agents, sales bots, onboarding flows.

```
Here is an example of a complete conversation flow:

[User]: [opening message]
[Assistant]: [ideal first response]
[User]: [follow-up]
[Assistant]: [ideal follow-up response]
[User]: [objection or edge case]
[Assistant]: [ideal handling of the objection]

Follow this conversation arc when responding.
```

**Key insight:** Show full flows, not isolated turns. The model learns the arc, not just the message.

---

## Pattern 6: Nested / Specialist Prompts

**Solves:** One prompt trying to do classification + generation + routing + task creation simultaneously.
**Use for:** Complex workflows, multi-step AI features, enterprise pipelines.

Split into an orchestrator + specialists:

```
[ORCHESTRATOR PROMPT]
You coordinate a pipeline. For each input, route to the right specialist:
- Sentiment task → classifier
- Response generation → responder
- Action creation → task-manager

Output only: { "route": "[specialist]", "input": "[cleaned input]" }
```

```
[SPECIALIST: CLASSIFIER]
You classify sentiment only.
Output only: { "sentiment": "positive|negative|neutral", "confidence": 0.0-1.0 }
```

**Rule:** Each prompt does ONE thing exceptionally well. Split early, not late.

---

## Pattern 7: Structured Output

**Solves:** Unpredictable response formats; hard-to-parse AI outputs.
**Use for:** Any feature that consumes AI output programmatically (APIs, dashboards, pipelines).

```xml
<output_format>
Respond ONLY with valid JSON. No preamble, no explanation, no markdown fences.

Schema:
{
  "field1": "string — description",
  "field2": "number — description",
  "field3": ["array of strings"],
  "confidence": "high | medium | low"
}

If you cannot determine a value, use null. Never omit required fields.
</output_format>
```

**Production note:** Always validate the JSON server-side. Assume occasional deviations and build a fallback parser.

---

## Pattern 8: Reflexion (Self-Correction)

**Solves:** First-pass outputs that are close but incomplete or slightly off.
**Use for:** High-stakes outputs — PRDs, technical specs, legal summaries, critical emails.
**Avoid for:** Real-time, low-latency features. Adds 1 extra LLM pass.

```
[Task prompt here]

After generating your initial response:
1. Review it against:
   - [Criterion 1]
   - [Criterion 2]
   - [Criterion 3]
2. Identify any weaknesses or missing elements.
3. If issues found, produce a revised final version.

Output:
<draft>[initial attempt]</draft>
<critique>[identified weaknesses]</critique>
<final>[revised, final output only]</final>
```

---

## Pattern 9: Tool-Use Routing

**Solves:** Agents that use tools randomly or fail to use them at the right moment.
**Use for:** Agentic systems with multiple MCP servers or tools.

```xml
<tool_selection_rules>
Use tools in this priority order:

1. [TOOL A] — When: [specific trigger]
   - Example: user asks about real-time data or current events
   - Do NOT use when: answer is in context already

2. [TOOL B] — When: [specific trigger]
   - Example: user asks to create/modify a file
   - Do NOT use when: user is only asking for explanation

3. NO TOOL — When you can answer from context or memory.
   Never search for what you already know.

Before invoking any tool, state: "I'll use [tool] because [reason]."
</tool_selection_rules>
```

---

## Anti-Pattern Reference

| Anti-Pattern | Symptom | Fix |
|---|---|---|
| Kitchen Sink | One prompt doing sentiment + routing + generation + task tracking | Split into specialist prompts |
| Demo Magic | Works on clean test inputs, fails on 40% of real users | Build eval suite with 60% edge cases |
| Set and Forget | Prompt written once, never reviewed | Monthly prompt reviews |
| Metric Theater | "Improve engagement" as success criteria | "P50 session time ≥+15% vs control" |
| Vibe Instructions | "Be helpful and friendly" | "Never use meta-phrases. Mirror user's formality." |
| CoT Overuse | Chain-of-thought on a classification task | CoT only for math/formal reasoning |

---

## Evaluation Checklist

For every production prompt:

```
EVAL SUITE:
□ 20% happy path — standard, clean, expected inputs
□ 60% edge cases — malformed, ambiguous, long, multi-language
□ 20% adversarial — override attempts, prompt injection, jailbreaks

SUCCESS THRESHOLDS (define before shipping):
□ Accuracy: ≥ [X]% on labeled eval set
□ Format compliance: ≥ [X]% valid output structure
□ Safety: 0 adversarial bypasses per 100 tests
□ Latency P95: < [X]ms

REVIEW CADENCE:
□ Weekly — check metrics
□ Monthly — analyze failures, add new edge cases
□ Quarterly — reassess approach against new model capabilities
```

---

## Quick Reference: Pattern Selection

```
Is the task math or formal reasoning?    → Chain-of-Thought
Is the input structured or tabular?      → Chain-of-Table
Need a specific output format or style?  → Few-Shot + Structured Output
Multi-turn conversation flow?            → Multi-Shot Conversation
3+ distinct subtasks in one prompt?      → Nested / Specialist
Agentic with multiple tools?             → Tool-Use Routing
High-stakes output requiring review?     → Reflexion
Every single system prompt?              → Role + Constraint (always)
```

## Resources
- [`references/examples.md`](references/examples.md) — 30+ labeled input/output examples by pattern
- [`references/eval-templates.md`](references/eval-templates.md) — Copy-paste evaluation suite templates
