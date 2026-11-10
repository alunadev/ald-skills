---
name: automerge-gate
description: Installs or updates a "merge without the owner" gate in a project — a CLAUDE.md rule, a repo-scoped gh pr merge permission, a read-only Sonnet reviewer subagent, scripts that wait for green checks and verify the production deploy, and a minimal CI workflow when the repo has none — so agents can merge their own PR for one approved plan step when it is green, reviewed and outside excluded paths. Use when the owner wants agents to merge routine plan steps without them, or to bring an existing install up to the current version. Hands over as a PR the owner merges by hand.
disable-model-invocation: true
---

# Automerge gate

**Current version: v2** (history in `CHANGELOG.md`).

Lets an agent merge its own pull request without the owner, under conditions narrow enough
that the owner can trust it: one approved plan step, no sensitive paths, green on the current
commit, an independent review with no blockers, and a log entry in the same PR. After the
merge, the same agent checks that production is live. Everything else stays manual.

This skill **installs** the gate in the current project, or **updates** an existing install
(`/automerge-gate update`, section 6). It never merges anything, and never merges its own
install or update: that PR grants a permission, so the owner merges it by hand.

## What gets installed

| File | From | Purpose |
|---|---|---|
| `CLAUDE.md` (new section) | `templates/claude-md-rule.md` | The conditions and the procedure every session follows |
| `.claude/agents/pr-gate-reviewer.md` | `templates/pr-gate-reviewer.md` | Read-only reviewer on Sonnet; posts its verdict on the PR |
| `.claude/automerge/wait-for-green.sh` | `templates/wait-for-green.sh` | Waits for the current head's checks in the background |
| `.claude/automerge/verify-production.sh` | `templates/verify-production.sh` | After the merge, waits for the production deploy and checks the live URL |
| `.github/workflows/ci.yml` | `templates/ci.yml` | **Only if the repo has no CI**: lint, typecheck, test, build on every PR |
| `.github/dependabot.yml` | `templates/dependabot.yml` | With `ci.yml`: keeps its pinned action SHAs current |
| `.claude/settings.json` | **written by the owner** | `"allow": ["Bash(gh pr merge *)"]` |

Every installed file carries the marker `automerge-gate v<N>`, so anyone can see which version
a project runs and what it is missing.

## 1. Interview

Read first, then ask: `CLAUDE.md`, `package.json` (or the stack's equivalent), `.github/workflows/`,
the deploy config, the last merged PR's checks (`gh pr list --state merged --limit 1`, then
`gh pr checks <n>`) and the deployments GitHub knows about
(`gh api repos/{owner}/{repo}/deployments --jq '.[].environment' | sort -u`). Use what you find
as each question's default. Ask in one round, short, default shown, and accept "default" as an
answer.

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
   and the required checks: the GitHub Actions job names that must be present and green on the
   PR, plus the `name:` of the workflow they belong to (default: the jobs of the repo's CI
   workflow, and `CI` as the workflow name). A required check only counts as a check run from
   that workflow, so checks from other apps (a preview deploy, for instance) cannot be listed
   as required; they still have to finish green like every other check on the commit.
   **No CI workflow in the repo?** Offer `templates/ci.yml`: workflow `CI`, required check `ci`.
   Without CI there is no trusted check, so nothing would ever qualify.
4. **Production.** Does a merge to the main branch deploy? If not, step 6 of the rule says
   "no deployment yet, nothing to verify" until one exists; still install the script. If it
   does:
   - **Environment name** GitHub records for production. Default: `Production` (Vercel's),
     confirmed with the deployments query above. If the host reports no GitHub deployments,
     the script can't see the deploy: say so and leave step 6 manual.
   - **Public production URL** (`PROD_URL`). Default: the one in `CLAUDE.md` or the deploy
     config. Use the public address: per-deployment URLs and previews are often behind the
     host's login and answer 401.
   - **Paths that must answer 200.** Default: `/` plus the main screens of the app.
   - **What to check by hand** after the script: default, the changed screen or endpoint
     behaves as the plan step describes.
   - **If production fails** (`ON_PROD_FAILURE`). Default: "Tell the owner at once with the
     script's output and what you saw." Only if the owner says so: "Roll back to the previous
     production deployment in the host (Vercel: Instant Rollback), then tell the owner." A
     rollback in the host changes no code; a revert or fix-forward never goes through the gate.
5. **Session log.** Where the log entry goes. Default: whatever the repo already uses
   (`logs/`, `log.md`, `progress.txt`, `CHANGELOG.md`); for a repo with none yet, `logs/`, one
   new file per entry.

Also ask the merge style if the repo shows no clear one (default `--squash --delete-branch`).

## 2. Write the rule

Fill `templates/claude-md-rule.md` with the answers and append it to the project's `CLAUDE.md`
as its own section. Keep the conditions as written; only the placeholders change. Remove the
template's leading HTML comment, keep the version marker under the heading. If `CLAUDE.md` is
a symlink target for `AGENTS.md`, that's fine: the rule should apply to every agent.

## 3. Install the reviewer, the scripts and, if needed, CI

- Copy `templates/pr-gate-reviewer.md` to `.claude/agents/pr-gate-reviewer.md` unchanged. It
  reads excluded paths and the plan from `CLAUDE.md`, so there is nothing to fill in.
- Copy `templates/wait-for-green.sh` and `templates/verify-production.sh` to
  `.claude/automerge/` and `chmod +x` both.
- Only if the repo has no CI: copy `templates/ci.yml` to `.github/workflows/ci.yml` and
  `templates/dependabot.yml` to `.github/dependabot.yml`. Adapt the run steps, Node version and
  package manager to the repo; keep the workflow name, the job id `ci`, `permissions:
  contents: read` and the SHA-pinned actions. If the repo already has CI, leave it alone and
  use its workflow and job names in the rule.

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

**Known risk: the permission is broad.** `Bash(gh pr merge *)` also matches `--admin`, `-R
<other repo>` and a merge with no `--match-head-commit`; only the `CLAUDE.md` rule forbids
those, nothing enforces it. Say this to the owner when you show the JSON. The tighter
alternative is a wrapper script (say `.claude/automerge/merge.sh <pr> <sha>`) that runs the one
allowed command with `--match-head-commit` and fixed flags, with the permission granted to that
script instead of to `gh pr merge`. Which one to use is the owner's decision; the template
keeps the broad permission. GitHub branch protection would enforce the required check on the
server, but on private repos it needs GitHub Pro; the gate does not depend on it.

## 5. Hand over as a PR

Commit everything on a branch (`chore/automerge-gate`), push, and open a PR. The body says:

- what the gate allows, the excluded paths and the green definition, in plain words;
- how production gets verified, and what happens if it fails;
- that it grants a merge permission, so **the owner merges it by hand**;
- how to test it (below).

If the PR adds `ci.yml`, its own `ci` check must pass before the owner merges it.

Then stop. Never merge this PR, never ask another session to.

## 6. Update an existing install

Improvements come from running the gate in real projects, so copies drift: a project gets a
fix and the skill doesn't, or the skill improves and older installs stay behind. Two rules:

- **A fix to the gate in a project is not done until it is in this skill.** Port it here in
  the same piece of work, bump the version, add a `CHANGELOG.md` entry and a line under
  "Lessons from running this".
- **Older installs are brought forward with `/automerge-gate update`.**

The update, in a project:

1. **Find the installed version.** `grep -rn "automerge-gate v" CLAUDE.md .claude .github`. No
   marker means a pre-v2 install or a hand-written rule (the gate described in prose in
   `CLAUDE.md`, maybe without the scripts or the reviewer): treat it as a fresh install that
   keeps the project's own answers.
2. **Read `CHANGELOG.md`** from the installed version to the current one; that list is what
   the PR will bring.
3. **Look for local improvements first.** Compare each installed generic file (scripts,
   reviewer, `ci.yml`) with the template of the version it claims. A difference that isn't a
   filled placeholder is a project improvement: show it to the owner, and if it is worth
   keeping, port it to the skill before going on.
4. **Re-fill, don't overwrite.** Take the project's answers from its current section
   (plan, excluded paths, checks, workflow, production URL, log path, merge flags) and fill
   the current template with them. Ask only for placeholders that are new since the installed
   version. Never drop an excluded path the project had.
5. **Replace the generic files** with the current templates. Do not add `ci.yml` if the repo
   already has CI.
6. **Hand over as a PR** (`chore/automerge-gate-v<N>`), with the changelog entries in the body
   and the diff of the `CLAUDE.md` section. It touches `CLAUDE.md` and `.claude/`, so the owner
   merges it by hand. If the permission itself needs to change, the owner writes it (section 4).

## After it lands — tell the owner

- **Start a fresh session to use it.** Permissions and subagents load at session start; a
  session opened before the merge can't merge and won't see the reviewer.
- **First real run:** pick a small plan step that touches no excluded path, let the session go
  through the whole procedure, and watch it once: reviewer comment posted, checks waited for in
  the background, merge, `verify-production.sh` output, report with the PR link.
- **Negative test:** a step that touches an excluded path must stop at an open PR.

## Lessons from running this

- **Wait in the background.** Run `wait-for-green.sh` as a background command. A foreground
  `sleep` loop, or none, ends the turn while checks are still pending and the merge never
  happens.
- **Checks belong to a commit.** A fix pushed after review makes the earlier green and the
  earlier review stale. Re-review, wait for the new commit's checks, then merge.
- **A blocked merge is an answer.** If auto mode refuses the merge, the right move is to stop
  with the PR open, not to find another route.
- **Read the commit and its checks in one call.** Separate calls can describe two different
  commits. The script takes `headRefOid` and `statusCheckRollup` from one `gh pr view`, judges
  that snapshot, and checks the head once more before printing `GREEN` (exit 2 if it moved).
- **A check name proves nothing.** Any commit status or app can publish a check called `ci`. A
  required check counts only as a `CheckRun` whose `workflowName` is the trusted workflow
  (`REQUIRED_WORKFLOW`, default `CI`).
- **Tie the merge to the reviewed commit.** `gh pr merge … --match-head-commit <sha>` makes
  GitHub refuse if a push landed after the review and the green. Never `--admin`, never `-R`.
- **Copies drift.** costura got the three fixes above before this template did, and
  penascales runs a hand-written gate older than the skill. Hence the version marker, the
  update mode and the porting rule (section 6).
- **Check the public URL.** On Vercel, previews and per-deployment URLs sit behind Vercel's
  login, so only the public production URL proves the site is live (seen in penascales).
