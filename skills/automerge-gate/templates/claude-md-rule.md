<!-- Paste into the project's CLAUDE.md. Replace every {{PLACEHOLDER}} with the interview answer.
     Remove this comment; keep the version marker below the heading. -->

## Automerge gate — merging without the owner

<!-- automerge-gate v2: installed from ald-skills (skills/automerge-gate). Fix the skill, not only this copy. -->

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
   commit** has finished green, including {{REQUIRED_CHECKS}} (GitHub Actions, workflow
   `{{REQUIRED_WORKFLOW}}`). Wait with the background loop below; never judge by an older
   commit's checks.
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
   `REQUIRED_WORKFLOW="{{REQUIRED_WORKFLOW}}" .claude/automerge/wait-for-green.sh <pr> {{REQUIRED_CHECK_ARGS}}`
   (a required check only counts when it is a GitHub Actions check run from the
   `{{REQUIRED_WORKFLOW}}` workflow; a commit status, or a check from another app with the same
   name, does not satisfy it)
   (exit 0 green, 1 not green, 2 head moved → back to step 2, 3 timeout → stop and report).
   The script prints `GREEN <sha>`: that is the commit the checks belong to.
4. Re-read the head SHA and the latest reviewer comment; both must still match that `<sha>`.
5. Merge, tied to the reviewed commit:
   `gh pr merge <pr> {{MERGE_FLAGS}} --match-head-commit <sha>`.
   Never with `--admin`, never against another repository (`-R`). If the head moved, GitHub
   refuses the merge: go back to step 2.
6. Verify production, again in the **background**:
   `PROD_URL="{{PROD_URL}}" DEPLOY_ENVIRONMENT="{{DEPLOY_ENVIRONMENT}}" .claude/automerge/verify-production.sh <pr> {{PROD_PATHS}}`
   (exit 0 live, 1 deployment failed, 2 deployed but a page did not answer 200, 3 timeout).
   Then check by hand what the script can't: {{PROD_VERIFY}}
7. Tell the owner: PR link, what shipped, the production check result.

### When it doesn't go through

- **In doubt, or auto mode blocks the merge:** leave the PR open, report, stop. Never retry the
  merge, never reword the command to get past the block, never ask another session to merge it.
- **Production check fails after the merge (exit 1, 2 or 3, or the manual check):**
  {{ON_PROD_FAILURE}} Never push a revert or a fix-forward through this gate without the owner.

### Why it is set up this way

- The merge permission lives in this repo's `.claude/settings.json` (`Bash(gh pr merge *)`),
  never in global settings, so it only applies here. Permissions and subagents load at
  session start: a session opened before they landed on the main branch can't use them.
- An agent can't grant itself this permission; auto mode blocks that as self-modification.
  The owner writes `.claude/settings.json`; an agent may only commit what the owner wrote.
