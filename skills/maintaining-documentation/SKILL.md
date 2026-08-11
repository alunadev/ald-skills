---
name: maintaining-documentation
description: Maintains a product repo's canonical docs structure (CLAUDE.md, progress.txt, docs/product+system+design-system, context/) as single source of truth, and keeps the log.md session history separate from the progress.txt state snapshot. Trigger after feature completion, before git push, on architecture changes, at session end, or explicit "update docs"/"sync documentation" requests. Skip for trivial changes (<10 LOC, no logic/schema/UI changes).
---

# Documentation Maintenance Skill

Maintains the canonical docs structure for a product repo bootstrapped from a
`templates/canonical-docs/`-style scaffold. This is for individual product repos — a system
repo with its own bespoke docs layout (a meta-repo indexing many products, for instance)
follows its own root `CLAUDE.md` instead; don't force this structure onto a repo that never
adopted it.

## When to use this skill

### Always trigger
- **Post-feature**: after completing any user story or acceptance criterion.
- **Pre-commit**: before `git push` if files changed under the app/source directories.
- **Architecture change**: DB schema, API contracts, auth logic modified.
- **Session end**: every working session should end with a `log.md` entry (see below) —
  this is separate from, and in addition to, any docs updates the change itself needs.
- **Explicit request**: "update docs", "sync documentation", "cleanup docs".

### Never trigger
- Trivial changes (<10 lines, no business logic).
- Fixing typos in code comments.
- Refactoring without behavior change.
- Dependency bumps (unless a major version or a new package).

### Ask first
- Experimental features: "Document this now or wait until it's stable?"
- Breaking changes: "Document the migration path?"
- Hotfixes: "Update docs now or after the proper fix?"

---

## Canonical Structure

```
/
├── CLAUDE.md                      # AI reads this FIRST every session
├── progress.txt                   # Current-state snapshot (root, max ~50 lines)
├── log.md                         # Append-only session history (create lazily)
├── agents/                        # Versioned mirror of personal subagents, if used
├── context/
│   ├── product-context.md         # Vision, value prop, strategic pillars
│   ├── team-context.md            # Team structure, ways of working, constraints
│   └── user-personas.md           # Who this is built for
└── docs/
    ├── product/
    │   ├── prd.md                 # Problem statement, success metrics, solution
    │   └── app-flow.md            # Navigation + user flows
    ├── system/
    │   ├── tech-stack.md          # Stack decisions and rationale
    │   └── implementation-plan.md # Build sequence
    └── design-system/
        └── design-system.md       # Tokens + component rules, prose and structured
```

Every doc under `docs/` carries YAML frontmatter — `title`, `status` (`draft` / `approved` /
`shipped`, adjust per doc type), `date`. Keep it current when a doc's state changes.

If the actual repo's structure differs from this (extra files, a different layout it settled
into), follow the repo's real structure — this is the default shape, not a rule to force onto
an established project.

---

## progress.txt vs. log.md — different jobs, don't conflate them

This is the single most important distinction in this skill, and the one most likely to be
gotten wrong.

- **`progress.txt`** — the **current-state snapshot**. Overwritten in place, not appended to.
  Sections: Current State, Last Session, Active Task, Next Up, Blockers, Decisions Log. Answers
  "where do things stand right now?" Keep it under ~50 lines — it's read at the start of every
  session, so it has to stay scannable.
- **`log.md`** — the **append-only session history**. A new entry gets added at the top on
  every working session; old entries are never edited or removed. Answers "what happened,
  session by session, and why?"

Update `progress.txt` whenever the state meaningfully changes. Append to `log.md` every
working session, regardless of whether `progress.txt` also changed — a session that only
investigated something without changing state still deserves a log entry saying so.

### log.md format

```markdown
# Session Log

<!-- Append newest entry at the TOP, below this line. -->

## YYYY-MM-DD HH:MM — Short title of what happened
- model: <model used>
- status: done | in-progress | blocked
- issue: <the problem being worked on, or the blocker — "none" if clean>

- done: what actually changed (1-2 bullets max)
- next: the single most useful next step
```

Write only what a future session needs: decisions made and why, state changes, the concrete
next step with file paths, open blockers. Don't narrate every command, don't repeat what's
already in git history, don't summarize unchanged things. Keep each entry under ~10 lines —
if it needs more, the detail belongs in a doc or commit message, linked from the entry.

Create `log.md` lazily — the first time a session does real work in a repo that doesn't have
one yet, not preemptively.

### If the repo generates a cross-repo rollup file (e.g. `NOW.md`)

Some setups generate a single "what's live, what's next" view across multiple repos, derived
from each repo's `progress.txt` and `log.md`. If one exists in this repo, it's generated —
**never hand-edit it.** Update the source files (`progress.txt`, `log.md`) and let the
generation step (whatever the repo uses — a script, a hook) pick up the change.

---

## Decision Tree: What to Update

```
START
│
├─ Changed a route, page, or user flow?
│  └─ YES → Update app-flow.md
│
├─ Changed DB schema, API contracts, or auth logic?
│  └─ YES → Update tech-stack.md if new dependencies; document the change in
│           implementation-plan.md if it's part of an in-flight build
│
├─ Changed design tokens or component rules?
│  └─ YES → Update design-system.md
│
├─ Feature status changed (draft → shipped)?
│  └─ YES → Update prd.md status, and progress.txt
│
├─ Product vision, team structure, or personas changed?
│  └─ YES → Update the relevant context/ file
│
└─ Always: update progress.txt if state changed, and append a log.md entry
   at session end regardless of what else changed.
```

---

## Update Workflow

### Step 1: Session start
1. Read `CLAUDE.md` to load project context.
2. Read `progress.txt` to understand current state.
3. If `log.md` exists, its last few entries give session-by-session context `progress.txt`
   alone doesn't carry.

### Step 2: Determine scope
Use the Decision Tree above.

### Step 3: Execute updates
For each file:
1. **Check redundancy** — does this info already live in its owner doc? If yes, link to it,
   don't duplicate.
2. **Update surgically** — find the exact section, make the minimal change, preserve
   structure.
3. **Fix cross-references** if a file moved or was renamed — `grep -r "old-name" docs/` and
   fix every hit.
4. **Update `progress.txt`** if state changed.

### Step 4: Validate
```bash
grep -r "\[.*\](.*\.md)" docs/ context/     # find internal links
# check each target exists
# check for the same content duplicated in two files
```

### Step 5: Session end
- Append the `log.md` entry — mandatory, even if `progress.txt` didn't need changes.

---

## Golden Rules

### Single source of truth
| Topic | Owner document |
|---|---|
| Problem, success metrics, solution | `docs/product/prd.md` |
| Navigation and user flows | `docs/product/app-flow.md` |
| Stack decisions | `docs/system/tech-stack.md` |
| Build sequence | `docs/system/implementation-plan.md` |
| Design tokens, component rules | `docs/design-system/design-system.md` |
| Product vision and strategy | `context/product-context.md` |
| Team structure and constraints | `context/team-context.md` |
| Who this is built for | `context/user-personas.md` |
| Current state | `progress.txt` |
| Session-by-session history | `log.md` |

**Rule:** if the info exists in its owner doc, link to it. Never copy it into a second file.

### File placement
- Don't put loose `.md` files at the repo root or in `docs/` root — organize under
  `product/`, `system/`, `design-system/`, or `context/`.
- Exceptions: `CLAUDE.md` and `progress.txt` belong at the repo root; `log.md` too.

### CLAUDE.md priority
`CLAUDE.md` is the AI's operating manual — update it when conventions change, keep it under
~2000 words since it loads every session.

---

## Common Scenarios

### "Feature X is complete"
1. `progress.txt` → update Current State / Active Task / Next Up.
2. `docs/product/prd.md` → status to `shipped`.
3. `docs/product/app-flow.md` → if new routes were added.
4. `log.md` → session entry, `status: done`.

### "Changed DB schema or API"
1. `docs/system/tech-stack.md` → if new dependencies.
2. `docs/system/implementation-plan.md` → if this is part of an in-flight build.
3. `progress.txt` → record the change.
4. `log.md` → session entry.

### "Changed a design token"
1. `docs/design-system/design-system.md` → update the token and, if the rationale changed,
   the surrounding prose.
2. Don't touch individual component files that reference the token — they inherit it.

### "Cleanup documentation"
1. `find . -name "*.md" -not -path "./node_modules/*"` and check each file against the
   canonical structure above.
2. Move misplaced files into the right folder.
3. Remove genuinely stale files (`temp_*.md`, `old_*.md`, `backup_*.md`).
4. Run the link audit (Step 4 above) and fix anything broken.
5. Report a summary of what moved/changed.

---

## Session-End Checklist

- [ ] `progress.txt` reflects the actual current state, not last week's
- [ ] `log.md` has a new entry for this session, even if brief
- [ ] Feature status in `prd.md` matches reality
- [ ] New routes/flows are in `app-flow.md`
- [ ] Design changes are in `design-system.md`
- [ ] No broken internal links (`grep` check)
- [ ] No duplicate content across two files
- [ ] `CLAUDE.md` updated if conventions changed
- [ ] No hand-edits to a generated rollup file, if the repo has one

---

## Error Prevention

1. **Duplicating instead of linking** — copying a decision or a schema description into a
   second file instead of linking to its owner doc. Costs nothing to link, costs a real drift
   bug later to duplicate.
2. **Forgetting the log.md entry** — updating specs but skipping the session log means the
   next session re-derives context that already existed.
3. **Confusing progress.txt with log.md** — progress.txt gets overwritten with the current
   state; log.md gets a new entry appended. Don't append to progress.txt, don't overwrite
   log.md.
4. **Breaking links when moving files** — `grep -r "old-name"` before moving, not after.
5. **Over-documenting trivial changes** — a 2-line fix doesn't need a docs pass; use the
   "Never trigger" list above.
6. **Hand-editing a generated file** — if the repo has a generated cross-repo view, edit the
   source files instead and let generation happen normally.
