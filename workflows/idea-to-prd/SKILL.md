---
name: idea-to-prd
description: Multi-step workflow that takes a raw idea from validation through design to a complete PRD. Chains idea-validator → brainstorming → prd-writer with explicit gates between steps. Use when starting a new feature or side project from scratch. Triggers on: /idea, "validate this idea", "should I build this", "new feature idea", "take this idea to PRD". Prevents building without validating and prevents specifying without designing.
---

# Idea to PRD Workflow

Converts a raw idea into a production-ready PRD by running three skills in sequence. Each step produces a document that the next step reads before proceeding. Do not skip steps — skipping validation leads to building the wrong thing; skipping design leads to an incoherent PRD.

## Skill Chain

```
idea-validator
    ↓ [Gate 1: Quick Verdict ≠ "Skip it"]
brainstorming
    ↓ [Gate 2: design doc exists in docs/designs/]
prd-writer
    ↓ [Gate 3: PRD sections complete]
→ Hand off to planning or full-stack-build
```

---

## Step 1 — Validate the Idea

Load skill: `idea-validator`

Run a rapid validation of the idea before investing any design or engineering time.

**Input:** One sentence describing the idea, the target user, and the core problem it solves.

**Questions idea-validator answers:**
- Is there demand evidence or only assumed demand?
- Is market saturation already high?
- Can a solo builder ship an MVP in 2-4 weeks?
- Is there a clear monetization path?

**Output:** Quick Verdict — one of:
- **Build it** — validated, proceed to Step 2
- **Maybe** — proceed to Step 2 with caveats documented
- **Skip it** — stop here; document reason in `docs/ideas/YYYY-MM-DD-[idea]-skip.md`

**Gate 1:** If Quick Verdict is "Skip it", stop the workflow. Record the verdict and reason. Revisit in 30 days or with new evidence. Do not proceed to Step 2 out of attachment to the idea.

---

## Step 2 — Design the Solution

Load skill: `brainstorming`

With the idea validated, design the solution before specifying it.

**Input:** The idea + Quick Verdict + any caveats from Step 1.

**Questions brainstorming answers:**
- What exactly does the MVP do? (scope boundary)
- What are the 2-3 viable approaches?
- What are the trade-offs between approaches?
- What's the data model and key flows?
- What are the error cases and edge cases?

**Brainstorming protocol:**
1. Load context (similar features in the codebase if applicable)
2. Ask 1 Socratic question at a time
3. Propose 2-3 approaches with explicit trade-offs
4. Verify each design section before moving on
5. Save the approved design to `docs/designs/YYYY-MM-DD-[topic].md`

**Gate 2:** `docs/designs/YYYY-MM-DD-[topic].md` must exist and be reviewed before opening the PRD. The design doc is the source of truth for the PRD — the PRD translates design decisions into stakeholder language.

---

## Step 3 — Write the PRD

Load skill: `prd-writer`

With a validated idea and an approved design, write the PRD.

**Input:** The design doc from Step 2 + target stage (planning/kickoff/solution review).

**PRD sections that must be complete before the gate:**
- Problem Statement + target user
- Success Metrics (at least 1 primary metric with target value)
- Solution Overview (aligned with design doc)
- Scope: In / Out of scope for this iteration
- Rollout plan (percentage or feature flag)

**Output:** `docs/prd/YYYY-MM-DD-[feature].md`

**Gate 3:** PRD with all sections above complete. Incomplete PRDs (missing metrics or scope) lead to scope creep and unclear success criteria. Do not hand off to engineering until metrics are defined.

---

## Handoff

After Gate 3:
- **Next workflow:** `full-stack-build` (if building now) or `planning` (for more detailed task breakdown)
- **Archive:** Link the design doc and PRD in the PRD's "References" section

---

## Output Artifacts

```
docs/ideas/YYYY-MM-DD-[idea]-skip.md   (only if Gate 1 = Skip it)
docs/designs/YYYY-MM-DD-[topic].md     (Step 2 output)
docs/prd/YYYY-MM-DD-[feature].md       (Step 3 output)
```

## Gates Summary

| Gate | Condition to pass |
|------|-------------------|
| After Step 1 | Quick Verdict = "Build it" or "Maybe" |
| After Step 2 | Design doc saved and reviewed |
| After Step 3 | PRD has problem, metrics, solution, scope, rollout |

## Common Antipatterns

- **Skipping validation because you're excited** — Excitement is not market demand. Run Step 1 even if you're sure.
- **Writing the PRD before designing** — PRDs that skip design discovery are wish lists, not specs. Design first.
- **"Maybe" verdicts that never get revisited** — A "Maybe" with no follow-up becomes a "Build it" by default. Document the conditions under which "Maybe" becomes "Build it".

## See Also

- `idea-validator` — For standalone idea validation outside this workflow
- `brainstorming` — For design exploration outside this workflow
- `prd-writer` — For PRD writing outside this workflow (e.g., updating an existing PRD)
- `full-stack-build` — The workflow that follows this one (build phase)
