---
name: delegate-to-hermes
description: Run bounded coding tasks through the Hermes CLI when Claude's usage window is exhausted or a cheaper model can handle a well-scoped subtask. Use for an explicitly isolated handoff, not as the default coding driver; Claude must review the diff and rerun checks before accepting any result.
---

# Delegate to Hermes

Hermes is a fallback worker, not the default driver. Use it when Claude's usage window is
exhausted or when a bounded subtask can run on a cheaper model. Claude owns the task, the
review, and the decision to accept the result.

## Before delegating

1. Pick a small task with a concrete output and checks. Do not offload an ambiguous design
   decision or a change Claude cannot review.
2. Write a **self-contained prompt file**. Hermes does not inherit the Claude conversation:
   include the repository and starting point, relevant context and file paths, the exact
   requested change, constraints, out-of-scope work, and checks to run. Do not put secrets in
   the prompt file. Check the current branch and working tree before starting.
3. Keep the work isolated. Run from the intended repository, with `-w` for a separate git
   worktree and branch. Do not edit or merge Claude's working branch from Hermes.

## Run the handoff

Use the Hermes CLI as a shell command. The configured provider is Vercel AI Gateway
(`ai-gateway`), with model `deepseek/deepseek-v4-pro-0813`. Override explicitly if needed;
verify the local configuration rather than assuming a stale setting still applies.

```bash
hermes chat -w --oneshot --provider ai-gateway --model deepseek/deepseek-v4-pro-0813 --query-file /path/to/delegation-prompt.txt
```

`--query-file` passes the file literally; `--oneshot` answers and exits.

**The prompt file must end with an explicit commit step** (e.g. `git add <files>` +
`git commit -m ...`). Verified on the installed version (2026-09-25): without a commit,
Hermes deletes the worktree AND its branch on exit and the work is unrecoverable. With a
commit, it warns "Worktree has unpushed commits, keeping" and preserves worktree + branch
for review. There is no CLI flag or config setting to disable that cleanup (checked
`hermes chat --help` and `~/.hermes/config.yaml`).

A successful command exit is not acceptance. If the run fails or stops partway, inspect
its state before retrying; do not treat a partial diff as finished work.

For a deliberate *interactive* continuation of an existing Claude session,
`hermes --resume @claude` opens a picker and imports a copy of that session. This is a
different path from the self-contained one-shot handoff; don't rely on imported context in
the one-shot prompt. `hermes fallback` configures an automatic provider chain; a configured
fallback can switch provider mid-session on a provider failure. It is not a command to
manually switch the current session, and it is not a substitute for reviewing the result.

## Review gate

- Inspect the full diff on the isolated branch (`git show hermes/<id>`), including any
  files outside the request.
- Claude reviews the change and reruns the relevant checks independently before accepting,
  cherry-picking, or merging anything. Report failures and uncertainty; never auto-accept.
- Keep approvals enabled. Never use `approvals.mode: off` or `--yolo`. Deny
  `git push --force` in Hermes approvals; do not bypass that guardrail in the prompt.
- Do not let Hermes push, merge, release, or change shared state as part of a bounded
  delegation unless that separate action has been expressly reviewed and authorized.

## Validation status

Tested on the installed version (2026-09-25, macOS):

1. DONE: trivial end-to-end delegation in a disposable repo. Confirmed: `-w` isolates the
   work (main branch untouched), and the brief MUST request a commit or the cleanup
   discards worktree + branch with no recovery. See "Run the handoff".
2. DONE: `hermes doctor` clean; provider `ai-gateway`, model `deepseek/deepseek-v4-pro-0813`.
3. DONE: `hermes -z` runs with NO approval net. Verified: a file-write request executed
   immediately with no prompt. Never use `-z` for delegations or commands with effects;
   read-only quick queries only. The delegation handoff form stays
   `chat -w --oneshot --query-file` with a commit in the brief.
4. DONE: `hermes --resume @claude` opens the session picker and the import works; the
   resumed session answered a "what were we doing" summary correctly. Per the docs the
   imported transcript still omits system prompts, raw tool output and injected context,
   so restate load-bearing details before continuing real work on an import.

If future tests contradict the commit-in-brief behavior, drop this orchestration pattern
rather than relying on the skill.

## Sources

- [Hermes CLI reference](https://hermes-agent.nousresearch.com/docs/reference/cli-commands)
- [Hermes session import](https://hermes-agent.nousresearch.com/docs/user-guide/sessions)
- [Hermes fallback providers](https://hermes-agent.nousresearch.com/docs/user-guide/features/fallback-providers)
- [Vercel AI Gateway and Hermes](https://vercel.com/docs/ai-gateway/coding-agents/hermes)
