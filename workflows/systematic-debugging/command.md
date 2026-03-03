# /debug

Activates the Systematic Debugging protocol on the current issue.

## Usage

```
/debug [optional: brief description of the bug]
```

## What this command does

1. Reads the `systematic-debugging` skill
2. Starts Phase 1 (Root Cause Investigation) — no code changes yet
3. Asks clarifying questions to gather evidence
4. Guides you through all 4 phases before writing a single fix

## When to use

- A test is failing and you don't know why
- A feature worked yesterday and doesn't today
- A user reported unexpected behavior
- You're about to "try something and see"

## Example

```
/debug API returns 404 on /api/user but only in production
```

Claude will NOT suggest code changes immediately. It will first ask:
- Can you reproduce this consistently?
- What do the logs show at the exact moment of the 404?
- Has this route ever worked in production?
- What changed in the last deploy?
