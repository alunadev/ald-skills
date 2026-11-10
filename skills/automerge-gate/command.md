Installs the automerge gate in the current project, so agents can merge their own PR for one
approved plan step without the owner, or updates an existing install to the current version.

Usage:
- `/automerge-gate` — install
- `/automerge-gate update` — bring an existing (or hand-written) install up to date

What the install does:
1. Loads the automerge-gate skill
2. Interviews you with defaults read from the repo: approved plan, excluded paths, what
   "green" means, how production gets verified and what happens if it fails, where the
   session log lives
3. Adds an "Automerge gate" section to CLAUDE.md with the conditions and the procedure
4. Installs the `pr-gate-reviewer` subagent (Sonnet, read-only) in `.claude/agents/`, and the
   check-waiting and production-check scripts in `.claude/automerge/`
5. If the repo has no CI, adds a minimal `ci.yml` workflow and `dependabot.yml`
6. Shows you the `Bash(gh pr merge *)` permission for `.claude/settings.json`; you write it
7. Opens a PR with all of it. You merge that PR by hand; it grants a permission

What the update does: reads the installed version, brings anything the project improved back
into the skill first, re-fills the current templates with the project's own answers, and
opens a PR with the changelog. You merge it by hand.

When to use:
- A project with an approved plan, where routine steps keep waiting on you only to press merge
- A project whose gate is older than the skill's current version

When not to use:
- No plan exists yet — write one first (`prd-writer`, `design-lab`)
- You want an agent to merge migrations, auth or dependency changes — the gate never allows it

After merging the install PR, start a fresh session: permissions load at session start.
