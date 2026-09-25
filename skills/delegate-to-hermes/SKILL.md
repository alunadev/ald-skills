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

`--query-file` passes the file literally; `--oneshot` answers and exits. Keep the worktree,
branch, and resulting diff available for review. A successful command exit is not acceptance.
If the run fails or stops partway, inspect its state before retrying; do not treat a partial
diff as finished work.

For a deliberate *interactive* continuation of an existing Claude session,
`hermes --resume @claude` opens a picker and imports a copy of that session. This is a
different path from the self-contained one-shot handoff; don't rely on imported context in
the one-shot prompt. `hermes fallback` configures an automatic provider chain; a configured
fallback can switch provider mid-session on a provider failure. It is not a command to
manually switch the current session, and it is not a substitute for reviewing the result.

## Review gate

- Inspect the full diff on the isolated branch, including any files outside the request.
- Claude reviews the change and reruns the relevant checks independently before accepting,
  cherry-picking, or merging anything. Report failures and uncertainty; never auto-accept.
- Keep approvals enabled. Never use `approvals.mode: off` or `--yolo`. Deny
  `git push --force` in Hermes approvals; do not bypass that guardrail in the prompt.
- Do not let Hermes push, merge, release, or change shared state as part of a bounded
  delegation unless that separate action has been expressly reviewed and authorized.

## Validate before relying on this

Whether calling the Hermes CLI is the right orchestration pattern is still unvalidated.
Before using this as a routine workflow:

1. Test what `hermes -z` actually does with approvals on the installed version. Do **not**
   assume it auto-enables YOLO: the docs describe `-z` as a scripted one-shot and place
   `approvals.single_query_mode` on finite chat runs, but do not establish an approval bypass.
   Keep `chat -w --oneshot --query-file` as the handoff form until tested.
2. Run one trivial delegation end to end in a disposable repository or branch. Inspect the
   worktree, resulting diff, approval prompts, and exit status; then have Claude rerun checks.
3. Run `hermes doctor` and resolve any relevant failures before trusting the workflow.

If the test does not work, drop this orchestration pattern rather than relying on the skill.

## Sources

- [Hermes CLI reference](https://hermes-agent.nousresearch.com/docs/reference/cli-commands)
- [Hermes session import](https://hermes-agent.nousresearch.com/docs/user-guide/sessions)
- [Hermes fallback providers](https://hermes-agent.nousresearch.com/docs/user-guide/features/fallback-providers)
- [Vercel AI Gateway and Hermes](https://vercel.com/docs/ai-gateway/coding-agents/hermes)
