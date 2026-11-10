#!/usr/bin/env bash
# automerge-gate v2: installed from ald-skills (skills/automerge-gate). Fix the skill, not only this copy.
#
# After a merge: wait for the production deployment of the merge commit, then check the live
# site. Run it in the background, like wait-for-green.sh.
#
#   PROD_URL=https://example.com .claude/automerge/verify-production.sh <pr-number> [path]...
#
# Works with any host that reports GitHub deployments for the commit (Vercel and Netlify do).
#   DEPLOY_ENVIRONMENT  GitHub environment name of production (default "Production", Vercel's)
#   PROD_URL            public production URL to check. Default: the deployment's own URL,
#                       which may sit behind the host's login
#   path...             each must answer HTTP 200 from PROD_URL (default "/")
#
# Exit codes: 0 live, 1 deployment failed, 2 deployed but a URL check failed,
#             3 timeout (no deployment found, or still building), 64 usage or PR not merged.

PR="$1"; shift
[ -n "$PR" ] || { echo "usage: $0 <pr-number> [path]..."; exit 64; }
INTERVAL="${INTERVAL:-20}"; MAX_POLLS="${MAX_POLLS:-45}"
ENVIRONMENT="${DEPLOY_ENVIRONMENT:-Production}"

SHA=$(gh pr view "$PR" --json mergeCommit --jq '.mergeCommit.oid // empty') || exit 1
[ -n "$SHA" ] || { echo "PR $PR is not merged"; exit 64; }
REPO=$(gh repo view --json nameWithOwner --jq .nameWithOwner) || exit 1
echo "Waiting for the $ENVIRONMENT deployment of $SHA"

URL=""
for i in $(seq 1 "$MAX_POLLS"); do
  ID=$(gh api -X GET "repos/$REPO/deployments" -f sha="$SHA" -f environment="$ENVIRONMENT" \
    --jq '.[0].id // empty') || exit 1
  if [ -n "$ID" ]; then
    STATUS=$(gh api "repos/$REPO/deployments/$ID/statuses" \
      --jq '.[0] | "\(.state)\t\(.environment_url // .target_url // "")"') || exit 1
    STATE=${STATUS%%$'\t'*}; URL=${STATUS#*$'\t'}
    case "$STATE" in
      success) break ;;
      # inactive: it went live and a newer deployment has already replaced it.
      inactive) echo "Deployment of $SHA was superseded by a newer one"; break ;;
      failure|error) echo "DEPLOY FAILED $SHA ($STATE) $URL"; exit 1 ;;
    esac
  fi
  [ "$i" -eq "$MAX_POLLS" ] && { echo "TIMEOUT: no successful $ENVIRONMENT deployment of $SHA"; exit 3; }
  sleep "$INTERVAL"
done

BASE="${PROD_URL:-$URL}"; BASE="${BASE%/}"
[ -n "$BASE" ] || { echo "DEPLOYED $SHA, but there is no URL to check: set PROD_URL"; exit 2; }
[ "$#" -gt 0 ] || set -- /

BAD=0
for path in "$@"; do
  CODE=$(curl -sS -o /dev/null -L --max-time 20 -w '%{http_code}' "$BASE$path") || CODE="error"
  echo "$BASE$path -> $CODE"
  [ "$CODE" = "200" ] || BAD=$((BAD + 1))
done

[ "$BAD" -eq 0 ] && { echo "LIVE $SHA"; exit 0; }
echo "DEPLOYED $SHA, BUT A URL CHECK FAILED"; exit 2
