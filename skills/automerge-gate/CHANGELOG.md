# automerge-gate changelog

What each version brings to a project. `/automerge-gate update` reads this from the
installed version to the current one.

## v2 (2026-11-10)

- **Checks tied to one commit.** `wait-for-green.sh` reads the head and its checks in one call
  and re-checks the head before printing `GREEN`.
- **Required checks must come from the trusted workflow.** Only a `CheckRun` whose
  `workflowName` equals `REQUIRED_WORKFLOW` (default `CI`) counts. New rule placeholder:
  `{{REQUIRED_WORKFLOW}}`.
- **Merge tied to the reviewed commit.** `gh pr merge <pr> {{MERGE_FLAGS}} --match-head-commit
  <sha>`, never `--admin` or `-R`.
- **Production verified by a script.** New `verify-production.sh`: waits for the GitHub
  deployment of the merge commit, then checks the public URL. New rule placeholders:
  `{{PROD_URL}}`, `{{DEPLOY_ENVIRONMENT}}`, `{{PROD_PATHS}}`, `{{ON_PROD_FAILURE}}`.
- **Minimal CI when the repo has none.** `ci.yml` (SHA-pinned actions, read-only token) and
  `dependabot.yml` to keep the pins current.
- **Version markers** in every installed file, and the update mode.

## v1 (2026-11-03)

First version: `CLAUDE.md` rule, `pr-gate-reviewer`, `wait-for-green.sh`, repo-scoped merge
permission. Installs from this version carry no version marker.
