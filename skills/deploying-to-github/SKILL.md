---
name: deploying-to-github
description: General GitHub workflow — branching, commits, pull requests, code review, secrets hygiene, submodules, and git worktrees. Use when the user wants to save changes, push to GitHub, open a PR, work with a submodule, set up a worktree, or perform any git/GitHub operation.
---

# Deploying to GitHub

A general-purpose GitHub workflow, not tied to any one project's quirks. Covers the full
range: solo direct-push repos, team repos that require PRs, repos with submodules, and
working in parallel with git worktrees.

## When to use this skill
- Saving and pushing changes, opening a pull request, reviewing git status before committing.
- Deciding whether a change should go straight to `main` or through a PR.
- Working with a submodule, or setting up/cleaning up a git worktree.

---

## 1. Decide the branching model first

Not every repo works the same way — check before assuming:

- **Solo project, direct push is the convention** (check `CLAUDE.md` / README for this):
  commit and push straight to `main`, in small increments.
- **Team repo, or `main` is protected**: work on a feature branch, open a PR, get it
  reviewed and merged. Never force this repo into the other model just because it's more
  familiar — read the repo's own conventions first.
- **Uncertain which applies**: default to a feature branch and a PR. It's the safer default
  and costs little extra for a repo that turns out to allow direct pushes.

### Feature branch naming
`type/short-description` — `feat/user-search`, `fix/login-redirect`, `docs/api-reference`.
Keep it short enough to read in a PR list.

---

## 2. Commit hygiene

### Verify before staging
```bash
git status
git diff
```
Know what you're about to commit before you stage it.

### Stage by name, not blanket
```bash
git add path/to/file1.md path/to/file2.ts
```
**Avoid `git add .` / `git add -A`** as a default habit. It stages everything in the working
tree indiscriminately — unrelated work-in-progress, stray build artifacts, or a `.env` file
that shouldn't be tracked. Reviewing `git status` first and staging by name is cheap insurance
against all three. (`git add .` is fine when you've just reviewed `git status` and genuinely
want everything in it — the point is to look first, not to make it the reflex.)

### Write commit messages that explain why, not just what
```bash
git commit -m "fix: retry failed uploads instead of dropping them silently"
```
Conventional prefixes (`feat:`, `fix:`, `refactor:`, `docs:`, `chore:`) help anyone scanning
`git log`. One logical change per commit — don't bundle an unrelated fix into a feature
commit because it was convenient.

### Never commit secrets
Check `.gitignore` covers `.env*`, credentials, API keys, and private keys before the first
commit in a new repo. If a secret does get committed, rotating the credential is mandatory —
removing it from a later commit does not remove it from history.

---

## 3. Pulling and pushing without losing work

```bash
git pull origin <branch>
```
Do this before starting work, and again immediately before pushing — someone else (a
teammate, a CI bot, another session) may have pushed since you last synced. If a push is
rejected because the remote has moved on:

```bash
git pull --rebase origin <branch>
git push origin <branch>
```

If the rebase applies cleanly, it was just a race, not a real conflict. If it doesn't,
resolve the conflict deliberately — never resolve by discarding one side wholesale without
understanding what would be lost. **Never force-push to overwrite someone else's work**
without explicit confirmation; the one narrow exception is force-pushing your own,
not-yet-reviewed feature branch after a rebase, which is normal.

---

## 4. Pull Requests and code review

When the branching model calls for a PR:

1. Push the feature branch, open the PR with a description that states *why*, not just a
   diff summary.
2. Use the `requesting-code-review` skill before merging anything non-trivial — catching
   issues before a human reviewer sees them is strictly better than after.
3. Wait for CI to pass before merging, if the repo has CI.
4. Prefer a clean merge strategy the repo already uses (merge commit, squash, or rebase) —
   check existing PR history rather than picking one arbitrarily.
5. Delete the branch after merge unless the repo keeps them for history.

---

## 5. Tags and releases

For a versioned project:
```bash
git tag -a v1.2.0 -m "v1.2.0"
git push origin v1.2.0
```
Pair with `changelog-generator` for the release notes, and semantic versioning
(`major.minor.patch`) unless the project uses a different scheme already.

---

## 6. Submodules

A submodule is its own independent git repo; the parent repo only stores a pointer (a commit
SHA) to one specific commit in it.

**Commit and push inside the submodule first, then update the pointer in the parent:**

```bash
cd submodule-dir/
git add <files>
git commit -m "..."
git push origin main

cd ..
git pull origin main          # check whether an Action or bot already bumped the pointer
git add submodule-dir
git commit -m "chore: bump <submodule> to <short-sha> — <what changed>"
git push origin main
```

Some repos run automation that bumps the parent's submodule pointer whenever the submodule's
default branch gets a push — pull in the parent before bumping by hand to avoid a redundant
commit. **Never let the pointer reference a commit that was never pushed to the submodule's
remote** — a pointer to a local-only commit breaks any clone or CI checkout of the parent.

---

## 7. Git worktrees — for real parallel work

A worktree gives you a second working directory checked out to a different branch, sharing
the same `.git` history — useful for working on two things at once without stashing or
switching in a single checkout (a long-running feature next to a quick hotfix, or running a
long build on one branch while coding on another).

```bash
git worktree add ../repo-feature-x feature-x        # existing branch
git worktree add -b feature-y ../repo-feature-y      # new branch
```

If the repo has a submodule, each worktree needs its own init — it doesn't inherit the main
checkout's:
```bash
cd ../repo-feature-x
git submodule update --init --recursive
```

```bash
git worktree list
git worktree remove ../repo-feature-x   # after the branch is merged/done
```

Don't `rm -rf` a worktree directory directly — it leaves stale references in the main repo's
`.git`. Use `git worktree remove`, or `git worktree prune` if the directory is already gone.

Use a worktree when two branches genuinely need to be checked out *simultaneously*; for
sequential work, switching branches in place is simpler.

---

## 8. Working alongside other active sessions

If more than one person or agent might be pushing to the same repo around the same time:
pull before every push (not just at the start of a session), commit in small frequent
increments to shrink the collision window, and rebase-and-retry on a rejected push rather
than force-pushing.

---

## Troubleshooting

- **Push rejected**: pull with `--rebase`, resolve if needed, push again.
- **Pre-commit hooks fail**: fix the underlying issue and recommit — don't skip hooks with
  `--no-verify` unless explicitly told to.
- **Submodule pointer looks wrong after a pull**: `git log -1 --format='%H %s' -- <submodule-dir>`
  on the parent shows the last pointer change and why.

## See Also

- `requesting-code-review` — run before merging any non-trivial PR.
- `changelog-generator` — pair with tagging a release.
