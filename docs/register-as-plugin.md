# How to Register ALD Skills as a Claude Code Plugin

> **Superseded 2026-08-16.** This was Adrian's own registration path from 2026-07-07 to 2026-08-16 — `ald-skills@local` is no longer installed on his machine. The plugin surfaced skills correctly only from within this repo's own working directory; sessions in other project directories saw an empty skill list, with no diagnosed fix. His personal setup now symlinks each `ald-skills/skills/<name>` (and `workflows/<name>`) directly into Claude Code's native `~/.claude/skills/<name>` and the cross-agent `~/.agents/skills/<name>`, with `command.md` files symlinked into `~/.claude/commands/<slash-name>.md` — see the root `CLAUDE.md` in `ald-system`. This guide is kept as a reference for the plugin path (still valid for other Claude Code users installing from GitHub — see the main [README](../README.md)), not as current instructions for this machine.

## Why this is needed

The Claude Code `Skill` tool only recognizes skills from **installed plugins** registered in `~/.claude/plugins/installed_plugins.json`. The ALD skills live in this repo as plain markdown files — Claude can read them via file path, but cannot invoke them with the `Skill` tool automatically.

This guide converts this repo into a proper Claude Code plugin so all skills become first-class, auto-discoverable via the `Skill` tool.

---

## Step 1 — Add plugin metadata to this repo

Create two files at the root of this repo (`/Users/adrianlunadiaz/ald-os/ald-system/ald-skills/`):

### `.claude-plugin/plugin.json`
```json
{
  "name": "ald-skills",
  "description": "Adrian Luna Díaz personal skill library — product management, engineering, design, and operations skills.",
  "version": "1.0.0",
  "author": {
    "name": "alunadev"
  }
}
```

### `package.json`
```json
{
  "name": "ald-skills",
  "version": "1.0.0",
  "type": "module"
}
```

---

## Step 2 — Verify the skills directory structure

Each skill must follow this exact layout (yours already do):

```
skills/
└── skill-name/
    └── SKILL.md    ← required, must have name + description frontmatter
```

Each `SKILL.md` must have a frontmatter header like this:

```yaml
---
name: deploying-to-github
description: Use when the user wants to push code, commit changes, or run git operations. Triggers on "push to github", "commit", "save changes", "git push".
---
```

> If any of your SKILL.md files are missing this frontmatter, the plugin system will ignore that skill. Check each file and add it if missing.

---

## Step 3 — Register in `installed_plugins.json`

Open `~/.claude/plugins/installed_plugins.json` and add this entry inside the `"plugins"` object:

```json
"ald-skills@local": [
  {
    "scope": "user",
    "installPath": "/Users/adrianlunadiaz/ald-os/ald-system/ald-skills",
    "version": "1.0.0",
    "installedAt": "2026-04-10T00:00:00.000Z",
    "lastUpdated": "2026-04-10T00:00:00.000Z",
    "gitCommitSha": "local"
  }
]
```

The final file should look like:
```json
{
  "version": 2,
  "plugins": {
    "code-simplifier@claude-plugins-official": [ ... ],
    ...existing plugins...,
    "ald-skills@local": [
      {
        "scope": "user",
        "installPath": "/Users/adrianlunadiaz/ald-os/ald-system/ald-skills",
        "version": "1.0.0",
        "installedAt": "2026-04-10T00:00:00.000Z",
        "lastUpdated": "2026-04-10T00:00:00.000Z",
        "gitCommitSha": "local"
      }
    ]
  }
}
```

---

## Step 4 — Enable the plugin in `settings.json`

Open `~/.claude/settings.json` and add `"ald-skills@local": true` to the `enabledPlugins` block:

```json
"enabledPlugins": {
  "code-simplifier@claude-plugins-official": true,
  ...existing entries...,
  "ald-skills@local": true
}
```

---

## Step 5 — Restart Claude Code

Close and reopen Claude Code (or start a new session). The skills will now be available via the `Skill` tool.

To verify, ask Claude: `use the deploying-to-github skill` — it should load without error.

---

## File checklist

After completing the steps, your repo root should contain:

```
ald-skills/
├── .claude-plugin/
│   └── plugin.json       ← NEW
├── package.json          ← NEW
├── skills/
│   ├── deploying-to-github/
│   │   └── SKILL.md      ← verify frontmatter exists
│   ├── brainstorming/
│   │   └── SKILL.md
│   └── ... (all other skills)
├── workflows/
├── docs/
└── README.md
```

And two system files updated:
- `~/.claude/plugins/installed_plugins.json` — new `ald-skills@local` entry
- `~/.claude/settings.json` — `"ald-skills@local": true` in enabledPlugins

---

## Notes

- The `installPath` points directly to this repo — no copying or symlinking needed. Any edits you make to a `SKILL.md` are live immediately (no reinstall required).
- If you rename or add a skill directory, restart Claude Code to pick up the change.
- The `@local` suffix in `ald-skills@local` is just a convention to distinguish it from marketplace plugins. You can use any string after `@`.
