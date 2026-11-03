Installs the automerge gate in the current project, so agents can merge their own PR for one
approved plan step without the owner.

Usage: /automerge-gate

What it does:
1. Loads the automerge-gate skill
2. Interviews you with defaults read from the repo: approved plan, excluded paths, what
   "green" means, how to check production, where the session log lives
3. Adds an "Automerge gate" section to CLAUDE.md with the conditions and the procedure
4. Installs the `pr-gate-reviewer` subagent (Sonnet, read-only) in `.claude/agents/` and a
   background check-waiting script in `.claude/automerge/`
5. Shows you the `Bash(gh pr merge *)` permission for `.claude/settings.json`; you write it
6. Opens a PR with all of it. You merge that PR by hand; it grants a permission

When to use:
- A project with an approved plan, where routine steps keep waiting on you only to press merge

When not to use:
- No plan exists yet — write one first (`prd-writer`, `design-lab`)
- You want an agent to merge migrations, auth or dependency changes — the gate never allows it

After merging the install PR, start a fresh session: permissions load at session start.
