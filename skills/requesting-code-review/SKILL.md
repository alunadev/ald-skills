---
name: requesting-code-review
description: Dispatch superpowers:code-reviewer subagent to catch issues before they cascade. Core principle is review early, review often.
---

# Requesting Code Review

Dispatch `superpowers:code-reviewer` subagent to catch issues before they cascade.

**Core principle:** Review early, review often.

## When to Request Review

**Mandatory:**
- After each task in subagent-driven development
- After completing major feature
- Before merge to main

**Optional but valuable:**
- When stuck (fresh perspective)
- Before refactoring (baseline check)
- After fixing complex bug

## How to Request

### 1. Get git SHAs
```bash
BASE_SHA=$(git rev-parse HEAD~1)  # or origin/main
HEAD_SHA=$(git rev-parse HEAD)
```

### 2. Dispatch code-reviewer subagent
Use Task tool with `superpowers:code-reviewer` type, fill template at `code-reviewer.md`.

**Placeholders:**
- `{WHAT_WAS_IMPLEMENTED}`: What you just built
- `{PLAN_OR_REQUIREMENTS}`: What it should do
- `{BASE_SHA}`: Starting commit
- `{HEAD_SHA}`: Ending commit
- `{DESCRIPTION}`: Brief summary

### 3. Act on feedback
- **Fix Critical issues** immediately
- **Fix Important issues** before proceeding
- **Note Minor issues** for later
- **Push back** if reviewer is wrong (with reasoning)

## Example

```bash
# You: Let me request code review before proceeding.
BASE_SHA=$(git log --oneline | grep "Task 1" | head -1 | awk '{print $1}')
HEAD_SHA=$(git rev-parse HEAD)

# [Dispatch superpowers:code-reviewer subagent]
# ... fills template ...
```

## Red Flags

**Never:**
- Skip review because "it's simple"
- Ignore Critical issues
- Proceed with unfixed Important issues
- Argue with valid technical feedback

**If reviewer wrong:**
- Push back with technical reasoning
- Show code/tests that prove it works
- Request clarification
