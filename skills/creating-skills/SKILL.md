---
name: creating-skills
description: Generates high-quality, predictable, and efficient skills for the Antigravity agent environment. Use when the user wants to create a new skill or automate a specific workflow with a skill.
---

# Antigravity Skill Creator

This skill enables the creation of high-quality, predictable, and efficient `.agent/skills/` directories based on user requirements.

## When to use this skill
- When requested to create a new skill for the project.
- When automating a specific task or domain that requires persistent instructions.

## Core Structural Requirements
Every skill must follow this folder hierarchy:
- `<skill-name>/`
    - `SKILL.md` (Required: Main logic and instructions)
    - `scripts/` (Optional: Helper scripts)
    - `examples/` (Optional: Reference implementations)
    - `resources/` (Optional: Templates or assets)

## YAML Frontmatter Standards
The `SKILL.md` must start with YAML frontmatter:
- **name**: Gerund form (e.g., `testing-code`, `managing-databases`). Max 64 chars. Lowercase, numbers, and hyphens only.
- **description**: Written in **third person**. Must include specific triggers/keywords. Max 1024 chars.

## Writing Principles
* **Conciseness**: Focus on unique logic; assume general developer knowledge.
* **Progressive Disclosure**: Link to secondary files for deep details.
* **Forward Slashes**: Always use `/` for paths.
* **Degrees of Freedom**: 
    - **Bullet Points**: For high-freedom heuristics.
    - **Code Blocks**: For medium-freedom templates.
    - **Specific Commands**: For low-freedom fragile operations.

## Workflow & Feedback Loops
1.  **Checklists**: Include a checklist to track task state.
2.  **Validation Loops**: Plan-Validate-Execute pattern.
3.  **Error Handling**: Instructions for scripts should be "black boxes" (e.g., run `--help`).

## Instructions for the Creator
When asked to create a skill, use the following template for the output:

### [Folder Name]
**Path:** `.agent/skills/[skill-name]/`

### [SKILL.md]
```markdown
---
name: [gerund-name]
description: [3rd-person description]
---

# [Skill Title]

## When to use this skill
- [Trigger 1]
- [Trigger 2]

## Workflow
[Checklist or step-by-step guide]

## Instructions
[Specific logic, code snippets, or rules]

## Resources
- [Link to scripts/ or resources/]
```
