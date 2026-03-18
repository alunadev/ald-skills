---
name: planning
description: >
  Creates atomic, TDD-focused implementation plans for features with approved designs. Use this
  skill — always AFTER brainstorming or when a design is already clear — when the user needs a
  step-by-step execution roadmap before coding starts. Triggers on: "write me a plan", "break
  this into tasks", "implementation steps for", "what order should I build", "atomic tasks",
  "TDD plan", "sprint breakdown", "create a plan for", "plan this feature", "step by step", "how
  do I implement", "what's the order of operations", "break this down for me". Also use when a
  user provides a spec and wants a concrete action plan with exact file paths and test commands.
  Produces an ordered task list where each task maps to one commit, with TDD steps
  (Red→Green→Refactor) and exact verification commands per task.
---

# Implementation Planning

## Why This Matters

A good implementation plan is not a roadmap — it's a commit-by-commit recipe. Each task should be small enough that you can hold the entire change in your head, write the test first, implement the minimum code to pass it, and commit with confidence.

The TDD discipline (Red→Green→Refactor) isn't ceremony — it's the mechanism that makes each task verifiable. If you can't write a failing test for a task, the task isn't atomic enough.

## When to Use

- A design has been finalized (often via the `brainstorming` skill)
- The user provides a clear spec and wants a concrete execution plan
- A complex feature needs breaking down into manageable, independently-committable pieces

## Workflow

### 1. Plan Initialization

Create `docs/plans/YYYY-MM-DD-<topic>-plan.md` with this header:

```markdown
# [Feature Name] Implementation Plan

**Goal:** [One sentence — what does "done" look like?]
**Architecture:** [2-3 sentences on the approach chosen]
**Tech Stack:** [Key technologies and libraries]
**Dependencies:** [What must exist before this plan starts?]

---
```

### 2. Task Breakdown — The Bite-Sized Rule

Break the feature into **atomic tasks**: each task maps to one commit, takes 5-15 minutes to implement, and is independently testable.

**Granularity test:** "Write failing test for X" is one task. "Implement X" is another. "Refactor X for clarity" is a third. If a task takes more than one commit, split it.

**Sequencing:** Order tasks so each one builds on something that already works. The first task should produce something verifiable in under 10 minutes.

### 3. Mandatory Task Details

Every task in the plan must include:

```markdown
### Task N: [Descriptive Name]

**Files:**
- Create: `exact/path/to/new-file.ts`
- Modify: `exact/path/to/existing.ts` (lines ~45-67)
- Test: `tests/exact/path/to/new-file.test.ts`

**Step 1 — Write the failing test (Red)**
[Exact test code to write]

Run: `npm test -- -t 'test name'`
Expected: FAIL ✗

**Step 2 — Minimal implementation (Green)**
[Minimum code to make the test pass]

Run: `npm test -- -t 'test name'`
Expected: PASS ✓

**Step 3 — Refactor (if needed)**
[What to clean up, if anything]

**Step 4 — Commit**
`git commit -m "feat: [what this task does]"`
```

### 4. Review Loop

Present the full plan to the user. Ask:
- "Does the task order make sense?"
- "Is anything missing or should anything be split further?"
- "Are the file paths correct for your project structure?"

Refine based on feedback. Once approved, the plan is the source of truth for implementation.

## What Good Looks Like

A completed plan leaves the user with:
- A numbered task list they can follow without making decisions
- Every test command spelled out — no "run the tests"
- An order that surfaces integration issues early, not at the end
- A first task that can be done in under 15 minutes (builds momentum)

## References

- `references/template.md` — The strict plan template with full task structure and header format
- `references/task-breakdown-guide.md` — Task breakdown patterns by feature type (CRUD, auth, API integration, AI feature, data pipeline)

Read `references/template.md` when generating a plan — it has the exact format to follow. Read `references/task-breakdown-guide.md` when unsure how to break down a specific feature type.
