---
name: planning
description: Creates comprehensive, detailed implementation plans for approved designs. Use this skill after brainstorming or when requirements are already clear and you need a step-by-step execution roadmap.
---

# Implementation Planning

## When to use this skill
- A design has been finalized and approved (often via the `brainstorming` skill).
- The user provides a clear spec and wants a concrete action plan.
- You need to break down a complex task into manageable, atomic steps.

## Workflow

1.  **Plan Initialization**
    - Create a new file `docs/plans/YYYY-MM-DD-<topic>-plan.md`.
    - Use the standard header to define the goal, architecture, and tech stack.

2.  **Task Breakdown (The "Bite-Sized" Rule)**
    - Break the feature into **atomic tasks** (2-5 minutes execution time each).
    - Each task must correspond to a **single commit**.
    - **Granularity:** "Write failing test" is one step. "Implement code" is another.

3.  **Mandatory Task Details**
    For *every* task in the plan, you must include:
    - **Exact File Paths:** `src/components/Button.tsx` (not "the button component").
    - **Code Snippets:** Specific logic to implement.
    - **Verification:** The specific test command to run (e.g., `npm test -- -t 'Button'`).
    - **Philosophy:** Enforce TDD (Red -> Green -> Refactor).

4.  **Review Loop**
    - Present the plan to the user.
    - Refine based on feedback.
    - Once approved, the plan is ready for execution.

## Resources
- [`resources/template.md`](resources/template.md) - The strict template for implementation plans.
