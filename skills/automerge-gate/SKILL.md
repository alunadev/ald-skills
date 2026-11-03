---
name: automerge-gate
description: Installs a "merge without the owner" gate in a project — a CLAUDE.md rule, a repo-scoped gh pr merge permission, a background check-waiting script and a read-only Sonnet reviewer subagent — so agents can merge their own PR for one approved plan step when it is green, reviewed and outside excluded paths. Use when the owner wants agents to merge routine plan steps without them. Hands over as a PR the owner merges by hand.
disable-model-invocation: true
---

# Automerge gate

Lets an agent merge its own pull request without the owner, under conditions narrow enough
that the owner can trust it: one approved plan step, no sensitive paths, green on the current
commit, an independent review with no blockers, and a log entry in the same PR. Everything
else stays manual.

This skill **installs** the gate in the current project. It never merges anything, and never
merges its own install: that PR grants a permission, so the owner merges it by hand.

## What gets installed

| File | From | Purpose |
|---|---|---|
| `CLAUDE.md` (new section) | `templates/claude-md-rule.md` | The conditions and the procedure every session follows |
| `.claude/agents/pr-gate-reviewer.md` | `templates/pr-gate-reviewer.md` | Read-only reviewer on Sonnet; posts its verdict on the PR |
| `.claude/automerge/wait-for-green.sh` | `templates/wait-for-green.sh` | Waits for the current head's checks in the background |
| `.claude/settings.json` | **written by the owner** | `"allow": ["Bash(gh pr merge *)"]` |

## 1. Interview

Read first, then ask: `CLAUDE.md`, `package.json` (or the stack's equivalent), `.github/workflows/`,
the deploy config, and the last merged PR's checks (`gh pr list --state merged --limit 1`, then
`gh pr checks <n>`). Use what you find as each question's default. Ask in one round, short,
default shown, and accept "default" as an answer.

1. **Approved plan.** Which document counts as approved? Default: the plan or PRD the repo
   already uses (`DESIGN_PLAN.md`, `docs/product/PRD.md`, `PLAN.md`). No plan → the gate can be
   installed, but nothing qualifies until one exists. Say so.
2. **Excluded paths.** Default list, trimmed to what exists in this repo:
   - DB migrations (`supabase/migrations/`, `prisma/migrations/`, `db/migrate/`, `migrations/`)
   - auth (`**/auth/**`, auth config, session handling)
   - middleware (`middleware.*`, edge/route guards)
   - payments and billing
   - secrets and env (`.env*`, secret config)
   - dependencies (`package.json`, lockfiles, `requirements*.txt`, `go.mod`, …)
   - deploy and CI config (`vercel.json`, `netlify.toml`, `Dockerfile`, `.github/`, infra)
   - `CLAUDE.md` and `.claude/` (always, not negotiable)
3. **Green.** Local commands that must pass (default: the repo's `build` and `test` scripts)
   and the check names that must be present and green on the PR (default: every check seen on
   the last merged PR, e.g. the CI job and the preview deploy).
4. **Production check.** How to tell the deploy worked. Default: the production deployment for
   the merge commit reaches Ready, then the main URL returns 200 and the changed screen or
   endpoint behaves as the step describes.
5. **Session log.** Where the log entry goes. Default: whatever the repo already uses
   (`log.md`, `progress.txt`, `CHANGELOG.md`).

Also ask the merge style if the repo shows no clear one (default `--squash --delete-branch`).

## 2. Write the rule

Fill `templates/claude-md-rule.md` with the answers and append it to the project's `CLAUDE.md`
as its own section. Keep the conditions as written; only the placeholders change. Remove the
template's leading HTML comment. If `CLAUDE.md` is a symlink target for `AGENTS.md`, that's
fine: the rule should apply to every agent.

## 3. Install the reviewer and the wait script

- Copy `templates/pr-gate-reviewer.md` to `.claude/agents/pr-gate-reviewer.md` unchanged. It
  reads excluded paths and the plan from `CLAUDE.md`, so there is nothing to fill in.
- Copy `templates/wait-for-green.sh` to `.claude/automerge/wait-for-green.sh` and `chmod +x` it.

About the reviewer's tools: Claude Code's `tools` field allows or removes a whole tool; it
cannot limit Bash to `gh pr view`/`diff`/`comment`. The agent needs Bash for `gh`, so its
read-only-ness is enforced by its prompt plus `disallowedTools: Write, Edit, NotebookEdit`. Do
not try to add `Bash(gh pr merge *)` to a deny list to compensate: deny rules apply to the main
session too and would break the gate itself. Check the current subagent docs
(code.claude.com/docs/en/sub-agents) if this file format seems out of date.

## 4. The permission — the owner writes it

The merge needs this in the **project's** `.claude/settings.json`:

```json
{
  "permissions": {
    "allow": ["Bash(gh pr merge *)"]
  }
}
```

(`Bash(gh pr merge:*)` is the equivalent older spelling.) If the file exists, it goes into
the existing `permissions.allow` array; nothing else changes.

- **The owner creates or edits this file, not you.** Auto mode blocks an agent granting itself
  a permission as self-modification, and it is right to. Show the owner the exact JSON, wait
  until they have saved it, then you may stage and commit the file as they wrote it. Do not
  retry or reword around a block.
- **Never global.** Not `~/.claude/settings.json`, not `settings.local.json`. The rule is
  per-repo, reviewed and versioned with the code it governs.
- **It has to reach the main branch.** Worktree and fresh sessions read `.claude/` from the
  branch they start on. Until the install PR is merged, no session can merge anything.

## 5. Hand over as a PR

Commit everything on a branch (`chore/automerge-gate`), push, and open a PR. The body says:

- what the gate allows, the excluded paths and the green definition, in plain words;
- that it grants a merge permission, so **the owner merges it by hand**;
- how to test it (below).

Then stop. Never merge this PR, never ask another session to.

## After it lands — tell the owner

- **Start a fresh session to use it.** Permissions and subagents load at session start; a
  session opened before the merge can't merge and won't see the reviewer.
- **First real run:** pick a small plan step that touches no excluded path, let the session go
  through the whole procedure, and watch it once: reviewer comment posted, checks waited for in
  the background, merge, production check, report with the PR link.
- **Negative test:** a step that touches an excluded path must stop at an open PR.

## Lessons from running this

- **Wait in the background.** Run `wait-for-green.sh` as a background command. A foreground
  `sleep` loop, or none, ends the turn while checks are still pending and the merge never
  happens.
- **Checks belong to a commit.** A fix pushed after review makes the earlier green and the
  earlier review stale. Re-review, wait for the new commit's checks, then merge.
- **A blocked merge is an answer.** If auto mode refuses the merge, the right move is to stop
  with the PR open, not to find another route.
