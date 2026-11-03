#!/usr/bin/env bash
# Wait until every check on a PR's CURRENT head commit has finished, then report.
# Run it in the background so the session's turn doesn't end while it waits.
#
#   .claude/automerge/wait-for-green.sh <pr-number> [required check name]...
#
# Exit codes: 0 green, 1 not green (failed or missing required check),
#             2 head moved while waiting (re-review, then wait again), 3 timeout.

PR="$1"; shift
[ -n "$PR" ] || { echo "usage: $0 <pr-number> [required check name]..."; exit 64; }
INTERVAL="${INTERVAL:-30}"; MAX_POLLS="${MAX_POLLS:-60}"

rollup() { gh pr view "$PR" --json statusCheckRollup --jq "$1"; }

SHA=$(gh pr view "$PR" --json headRefOid --jq .headRefOid) || exit 1
echo "Waiting for checks on $SHA"

for i in $(seq 1 "$MAX_POLLS"); do
  NOW=$(gh pr view "$PR" --json headRefOid --jq .headRefOid)
  [ "$NOW" = "$SHA" ] || { echo "HEAD MOVED $SHA -> $NOW"; exit 2; }
  TOTAL=$(rollup '.statusCheckRollup | length')
  PENDING=$(rollup '[.statusCheckRollup[] | select((.status // "COMPLETED") != "COMPLETED" or .state == "PENDING" or .state == "EXPECTED")] | length')
  [ "$TOTAL" -gt 0 ] && [ "$PENDING" -eq 0 ] && break
  [ "$i" -eq "$MAX_POLLS" ] && { echo "TIMEOUT waiting for checks on $SHA"; exit 3; }
  sleep "$INTERVAL"
done

rollup '.statusCheckRollup[] | "\(.name // .context): \(.conclusion // .state)"'
BAD=$(rollup '[.statusCheckRollup[] | (.conclusion // .state) | select(. != "SUCCESS" and . != "NEUTRAL" and . != "SKIPPED")] | length')
# Required checks must exist and be SUCCESS: SKIPPED or NEUTRAL only pass for optional ones.
RESULTS=$(rollup '.statusCheckRollup[] | "\(.name // .context)\t\(.conclusion // .state)"')
for name in "$@"; do
  STATES=$(awk -F'\t' -v n="$name" '$1 == n { print $2 }' <<<"$RESULTS")
  if [ -z "$STATES" ]; then
    echo "MISSING required check: $name"; BAD=$((BAD + 1))
  elif grep -qvx SUCCESS <<<"$STATES"; then
    echo "REQUIRED check not SUCCESS: $name ($(tr '\n' ' ' <<<"$STATES"))"; BAD=$((BAD + 1))
  fi
done

[ "$BAD" -eq 0 ] && { echo "GREEN $SHA"; exit 0; }
echo "NOT GREEN $SHA"; exit 1
