---
name: deploying-to-github
description: Standardized git workflow for committing and pushing changes safely, including submodule-first flow, concurrent-session hygiene, and git worktrees for parallel work. Use when the user wants to save changes, push to GitHub, work in a worktree, or perform any git operation.
---

# Deploying to GitHub

Standardized workflow for pushing local changes to GitHub, built to survive the two things
that actually cause problems in practice: another session pushing to the same repo while
you're working, and a parent repo with a submodule that has its own commit history.

## When to use this skill
- When you have finished a task and need to save changes remotely.
- When the user mentions "push to github", "save changes", "subir cambios".
- When working with a submodule and its parent repo together.
- When the user wants to work on something in parallel without disturbing the main checkout —
  see Worktrees below.

## Workflow

### 0. Pull before you start, and pull again before you push

Never assume the local branch is current. Another session — human or agent — may have pushed
since you last synced.

```bash
git pull origin <branch>
```

Do this both when starting work and again immediately before pushing. If the pull rejects
because of local uncommitted changes, commit or stash first — don't discard anything without
checking `git status`.

### 1. Verification

Check what actually changed before staging anything.

```bash
git status
git diff
```

### 2. Staging — never blanket-add

**Do not use `git add .` or `git add -A`.** Stage files by name:

```bash
git add path/to/file1.md path/to/file2.ts
```

Blanket staging risks committing unrelated work-in-progress, secrets (`.env`, credentials),
or large files that happened to be sitting in the working tree. Reviewing `git status` output
before staging is the cheap insurance against all three.

### 3. Committing

```bash
git commit -m "type: brief description of changes"
```

Use conventional prefixes: `feat:`, `fix:`, `refactor:`, `docs:`, `chore:`. Group related
changes into one commit; don't bundle unrelated work.

### 4. Pushing — pull first if rejected

```bash
git push origin <branch>
```

If this is rejected ("tip of your current branch is behind"), someone else pushed in the
meantime. Do not force-push. Instead:

```bash
git pull --rebase origin <branch>
git push origin <branch>
```

A rebase that applies cleanly means no real conflict existed — just a race. If it doesn't
apply cleanly, resolve the conflict, don't discard either side blindly.

---

## Submodule-first flow

When the repo has a submodule (this repo's `ald-skills` inside `ald-system` is the
reference case), the submodule is its own independent git history. The parent repo just
stores a pointer (a commit SHA) to one specific commit in the submodule.

**Always commit and push inside the submodule first, then update the pointer in the parent:**

```bash
cd submodule-dir/
git add <files>
git commit -m "..."
git push origin main

cd ..
git pull origin main          # the parent may already have a bot/Action that bumped
                               # the pointer for you — check before bumping by hand
git add submodule-dir
git commit -m "chore: bump <submodule> to <short-sha> — <what changed>"
git push origin main
```

**Check for an automated pointer-bump Action before doing it by hand.** Some repos run a
GitHub Action that auto-updates the parent's submodule pointer whenever the submodule's
`main` gets a push. If one exists, `git pull` in the parent after your submodule push may
already show the pointer updated — don't create a duplicate bump commit, just verify and move
on.

**Never let the parent repo's submodule pointer reference a commit that was never pushed.**
A pointer to a local-only commit breaks anything that clones or checks out the parent
(`actions/checkout` with `submodules: true` fails outright) — this is a real failure mode,
not a hypothetical one.

---

## Concurrent sessions (multiple agents/people on the same repo)

If more than one session might be working on the same repo at the same time:

- Pull immediately before every push, not just at the start of a work block.
- Commit and push in small, frequent increments rather than one large batch at the end —
  it shrinks the window where two sessions can collide on the same lines.
- If a push is rejected, rebase and retry — don't force-push to "win."
- Before touching a specific file, consider whether another active session might be editing
  it right now; coordinate scope if you can (e.g., "I'll take these files, you take those").

---

## Git Worktrees — for real parallel work

A worktree gives you a second working directory checked out to a different branch, sharing
the same `.git` history — useful when you want to work on two things at once (e.g., a
long-running feature branch and a quick hotfix) without stashing/switching in a single
checkout.

### Create one

```bash
git worktree add ../repo-feature-x feature-x        # existing branch
git worktree add -b feature-y ../repo-feature-y      # new branch
```

### With a submodule present

Each worktree needs its own submodule init — it doesn't inherit the main checkout's:

```bash
cd ../repo-feature-x
git submodule update --init --recursive
```

### List and clean up

```bash
git worktree list
git worktree remove ../repo-feature-x   # after the branch is merged/done
```

Don't `rm -rf` a worktree directory directly — it leaves stale references in the main repo's
`.git`. Use `git worktree remove`, or `git worktree prune` if the directory is already gone.

### When to use a worktree vs. just switching branches

- Switching branches in place: fine for sequential work, one thing at a time.
- A worktree: worth it when you need two branches checked out *simultaneously* — running a
  long build/test on one while coding on the other, or comparing behavior side by side.

## Troubleshooting

- **Push rejected**: pull with `--rebase`, resolve if needed, push again. Never force-push
  without explicit confirmation from the user — it can overwrite someone else's work.
- **Submodule pointer looks wrong after a pull**: check whether an Action already bumped it;
  `git log -1 --format='%H %s' -- <submodule-dir>` on the parent shows the last pointer
  change and why.
- **Pre-commit hooks fail**: fix the underlying issue and recommit — don't skip hooks with
  `--no-verify` unless explicitly told to.
