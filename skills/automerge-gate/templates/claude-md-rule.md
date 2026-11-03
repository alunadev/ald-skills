<!-- Paste into the project's CLAUDE.md. Replace every {{PLACEHOLDER}} with the interview answer. -->

## Automerge gate — merging without the owner

An agent may merge its own pull request without the owner **only when every condition below
holds**. One failing condition, or any doubt, means: leave the PR open, tell the owner, stop.

### Conditions (all required)

1. **Scope.** The PR implements exactly one step of the approved plan, `{{PLAN_DOC}}`, and
   nothing more. The PR body names the step. No approved plan, or a step that isn't in it,
   means no exception.
2. **Excluded paths.** The PR touches none of these:
   {{EXCLUDED_PATHS}}
   - `CLAUDE.md` and `.claude/` (this rule and its permission)

   **Migrations never qualify.** They follow their own flow: explicit owner approval for each
   migration, tested locally first, read-only checks before and after it runs.
3. **Green.** {{GREEN_LOCAL}} pass locally, and every check on the PR's **current head
   commit** has finished green, including {{REQUIRED_CHECKS}}. Wait with the background loop
   below; never judge by an older commit's checks.
4. **Review.** The `pr-gate-reviewer` subagent (Sonnet, `.claude/agents/pr-gate-reviewer.md`),
   which did not write the code, has posted its verdict on the PR, the verdict is
   `VERDICT: PASS`, and its `Reviewed head` equals the current head. If a blocker gets fixed,
   the new commit needs a new review **and** its own green checks before merging.
5. **Log.** The session-log entry in `{{LOG_PATH}}` is part of this same PR, committed before
   the merge. Never a separate PR.

### Procedure

1. Open the PR with the plan step named in the body.
2. Run the reviewer: delegate to `pr-gate-reviewer` with the PR number, `{{PLAN_DOC}}` and the
   step name. Blockers → fix, push, review again.
3. Wait for checks in the **background** so the turn doesn't end while idle:
   `.claude/automerge/wait-for-green.sh <pr> {{REQUIRED_CHECK_ARGS}}`
   (exit 0 green, 1 not green, 2 head moved → back to step 2, 3 timeout → stop and report).
4. Re-read the head SHA and the latest reviewer comment; both must still match.
5. Merge: `gh pr merge <pr> {{MERGE_FLAGS}}`.
6. Verify production: {{PROD_VERIFY}}
7. Tell the owner: PR link, what shipped, the production check result.

### When it doesn't go through

- **In doubt, or auto mode blocks the merge:** leave the PR open, report, stop. Never retry the
  merge, never reword the command to get past the block, never ask another session to merge it.
- **Production check fails after the merge:** tell the owner at once with what you saw. Do not
  push a revert or a fix-forward through this gate without the owner.

### Why it is set up this way

- The merge permission lives in this repo's `.claude/settings.json` (`Bash(gh pr merge *)`),
  never in global settings, so it only applies here. Permissions and subagents load at
  session start: a session opened before they landed on the main branch can't use them.
- An agent can't grant itself this permission; auto mode blocks that as self-modification.
  The owner writes `.claude/settings.json`; an agent may only commit what the owner wrote.
