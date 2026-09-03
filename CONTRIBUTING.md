# Contributing to ald-skills

How a skill gets **into this repo and wired up**. Deliberately not a guide to *writing* a good
skill — every agent harness ships its own (`skill-creator` in Claude Code, the equivalent in
Codex and Cursor), and those stay current in a way a copy here would not. What follows is only
the part that is specific to this repository, and that nothing else can know.

For the writing discipline itself — pointers, progressive disclosure, degrees of freedom,
leading words — see `skills/writing-for-agents/SKILL.md`.

---

## Where things live

```
ald-skills/
├── skills/<name>/SKILL.md        # a skill
│   ├── command.md                # optional — backs a slash command
│   └── references/*.md           # optional — progressive disclosure
├── workflows/<name>/SKILL.md     # a workflow; same shape, chains several skills
├── skills/README.md              # THE INDEX — numbered, global sequence
└── CONTRIBUTING.md               # this file
```

A skill is a directory with a `SKILL.md`. Nothing is registered anywhere else — discovery is by
symlink (below), and the index exists for humans and for agents reading the repo.

## Frontmatter

```yaml
---
name: <folder-name>              # must match the directory name
description: >                   # third person; when to reach for it, and when not to
  ...
disable-model-invocation: true   # optional — user-invoked only, zero context cost
---
```

The `description` is loaded on **every turn**, whether or not the skill fires. Treat it as a
routing decision written in as few words as will still route correctly — name generalized
categories of intent, not a list of near-synonymous example phrases.

Use `disable-model-invocation: true` for anything expensive, destructive, or only useful when
deliberately asked for.

## Adding a skill — the four steps

### 1. Create the directory

```bash
mkdir -p skills/<name>
$EDITOR skills/<name>/SKILL.md
```

### 2. Register it in the index

`skills/README.md`, under the right section (Product Management, Engineering & Development, or
Documentation & Operations):

```markdown
### N. [Skill Display Name]
- **Path**: `skills/<name>/`
- **Purpose**: [One sentence — what it does and when to use it.]
- **Triggers**: [generalized categories of intent that should invoke it]
```

`N` continues a **global** sequence across all sections — check the highest existing number, not
the last one in your section. If the skill belongs in the PM → Engineering → Release flow, add
it to **Workflow Integration** at the bottom too.

Skipping this step leaves the skill on disk but undiscoverable to anyone reading the repo.

### 3. Symlink it so agents can find it

Two targets, because this repo serves more than one agent:

```bash
REPO="$(git rev-parse --show-toplevel)"

ln -sfn "$REPO/skills/<name>" ~/.claude/skills/<name>    # Claude Code, native global skills
ln -sfn "$REPO/skills/<name>" ~/.agents/skills/<name>    # Codex, Cursor, OpenCode, others
```

Workflows get the same two symlinks, pointing at `workflows/<name>` — their `SKILL.md` makes
them invocable exactly like a skill.

**If the skill has a `command.md`**, it also needs a third symlink to become a slash command.
The link filename is the command name, so it does not have to match the skill:

```bash
ln -sfn "$REPO/skills/<name>/command.md" ~/.claude/commands/<slash-name>.md
```

One skill can back several commands by keeping more than one command file — `product-analytics`
does this with `command.md` (`/metrics`) and `command-tracking.md` (`/tracking`).

### 4. Commit — submodule first, then the parent

`ald-skills` is a git submodule of `ald-system`, so every change is two commits in order:

```bash
# in ald-skills
git add skills/<name>/ skills/README.md
git commit -m "feat(skills): add <name> skill"
git push origin main

# then in ald-system
git add ald-skills
git commit -m "chore: update ald-skills submodule (add <name>)"
git push
```

Pushing the submodule without bumping the parent ref means the skill is on GitHub but the
parent repo still points at the old commit.

## Removing or renaming a skill

The failure mode this repo has actually hit, more than once: a skill gets cut and every pointer
to it survives, silently, for months. Do all five:

1. `git rm -r skills/<name>`
2. Remove its entry from `skills/README.md` **and renumber** everything after it
3. Remove both symlinks (`~/.claude/skills/<name>`, `~/.agents/skills/<name>`) and any command
   symlink in `~/.claude/commands/`
4. Grep the **whole system** for references and fix every one:
   ```bash
   grep -rn "<name>" . --include="*.md" --include="*.json"
   grep -rn "<name>" ~/ald-os/ald-system/products ~/ald-os/ald-system/templates --include="*.md"
   ```
   `products/*/CLAUDE.md` files reference skills by absolute path — they break silently, and
   nothing surfaces the failure.
5. Both commits, as above

Historical documents (`docs/roadmap.md`, `docs/pm-workflow.md`, archived audits) are exempt —
they record what was true when written.

## Conventions

- Commit messages in English, imperative: `feat(skills):`, `fix(skills):`, `chore:`, `docs:`
- Never stage `.DS_Store`
- Skill and folder names are lowercase kebab-case, and `name:` matches the folder
- Keep `SKILL.md` readable in one sitting; push detail into `references/` behind a pointer that
  says when to read it
- No absolute paths to one machine's home directory inside a skill — this repo is public
