#!/usr/bin/env bash
# automerge-gate v2: installed from ald-skills (skills/automerge-gate). Fix the skill, not only this copy.
#
# Wait until every check on a PR's CURRENT head commit has finished, then report.
# Run it in the background so the session's turn doesn't end while it waits.
#
#   .claude/automerge/wait-for-green.sh <pr-number> [required check name]...
#
# Required checks only count when they are GitHub Actions check runs from the
# workflow named in $REQUIRED_WORKFLOW (default "CI"): a commit status or a check
# from another app with the same name does not satisfy them.
#
# Exit codes: 0 green, 1 not green (failed or missing required check),
#             2 head moved while waiting (re-review, then wait again), 3 timeout.

PR="$1"; shift
[ -n "$PR" ] || { echo "usage: $0 <pr-number> [required check name]..."; exit 64; }
INTERVAL="${INTERVAL:-30}"; MAX_POLLS="${MAX_POLLS:-60}"
REQUIRED_WORKFLOW="${REQUIRED_WORKFLOW:-CI}"

# Head SHA and checks come from one call, so they always describe the same commit.
snapshot() { gh pr view "$PR" --json headRefOid,statusCheckRollup; }

SNAP=$(snapshot) || exit 1
SHA=$(jq -r .headRefOid <<<"$SNAP")
echo "Waiting for checks on $SHA"

for i in $(seq 1 "$MAX_POLLS"); do
  SNAP=$(snapshot) || exit 1
  NOW=$(jq -r .headRefOid <<<"$SNAP")
  [ "$NOW" = "$SHA" ] || { echo "HEAD MOVED $SHA -> $NOW"; exit 2; }
  TOTAL=$(jq '.statusCheckRollup | length' <<<"$SNAP")
  PENDING=$(jq '[.statusCheckRollup[] | select((.status // "COMPLETED") != "COMPLETED" or .state == "PENDING" or .state == "EXPECTED")] | length' <<<"$SNAP")
  [ "$TOTAL" -gt 0 ] && [ "$PENDING" -eq 0 ] && break
  [ "$i" -eq "$MAX_POLLS" ] && { echo "TIMEOUT waiting for checks on $SHA"; exit 3; }
  sleep "$INTERVAL"
done

jq -r '.statusCheckRollup[] | "\(.name // .context): \(.conclusion // .state)"' <<<"$SNAP"
BAD=$(jq '[.statusCheckRollup[] | (.conclusion // .state) | select(. != "SUCCESS" and . != "NEUTRAL" and . != "SKIPPED")] | length' <<<"$SNAP")
# Required checks must exist as Actions check runs of the trusted workflow and be SUCCESS.
for name in "$@"; do
  STATES=$(jq -r --arg n "$name" --arg w "$REQUIRED_WORKFLOW" \
    '.statusCheckRollup[] | select(.__typename == "CheckRun" and .name == $n and .workflowName == $w) | .conclusion' <<<"$SNAP")
  if [ -z "$STATES" ]; then
    echo "MISSING required check: $name (workflow $REQUIRED_WORKFLOW)"; BAD=$((BAD + 1))
  elif grep -qvx SUCCESS <<<"$STATES"; then
    echo "REQUIRED check not SUCCESS: $name ($(tr '\n' ' ' <<<"$STATES"))"; BAD=$((BAD + 1))
  fi
done

# Last look: the head must not have moved since the snapshot we judged.
FINAL=$(gh pr view "$PR" --json headRefOid --jq .headRefOid) || exit 1
[ "$FINAL" = "$SHA" ] || { echo "HEAD MOVED $SHA -> $FINAL"; exit 2; }

[ "$BAD" -eq 0 ] && { echo "GREEN $SHA"; exit 0; }
echo "NOT GREEN $SHA"; exit 1
