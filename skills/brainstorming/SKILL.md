---
name: brainstorming
description: Explores user intent, requirements, and design before implementation. Use this skill when the user asks to build a feature, change architecture, or start a complex task to ensure clarity before coding.
---

# Brainstorming Ideas Into Designs

## When to use this skill
- User has a new idea or feature request.
- User wants to change architecture or tech stack.
- Requirements are vague or high-level.

## Workflow

1.  **Context Loading**
    - Read relevant files, docs, and recent commits to understand the current state.
    - *Do not* start asking questions until you have read the existing context.

2.  **Socratic Discovery**
    - Ask **one question at a time** to refine the spec.
    - Prefer multiple-choice questions (e.g., "Do you prefer A or B?") over open-ended ones.
    - Focus on understanding purpose, constraints, and success criteria.

3.  **Optioneering**
    - Propose 2-3 different technical approaches with trade-offs.
    - Present options conversationally with your recommendation and reasoning.
    - Lead with your recommended option and explain why.

4.  **Design Verification**
    - Present the design in small chunks (200-300 words).
    - Checks after each section whether it looks right so far.
    - Cover: architecture, components, data flow, error handling, testing.
    - **Goal:** Get approval for each chunk before moving to the next.

5.  **Output**
    - Save the validated design to `docs/designs/YYYY-MM-DD-<topic>.md`.
    - Once finished, suggest moving to the `planning` skill.

## Resources
- [`resources/guide.md`](resources/guide.md) - Detailed techniques for efficient brainstorming.
