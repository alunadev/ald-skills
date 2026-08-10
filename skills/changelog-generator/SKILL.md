---
name: changelog-generator
description: Transforms technical git commits into a clear, compact, user-friendly changelog. Use when preparing release notes, creating product update summaries, documenting changes for customers, or maintaining a public changelog page.
---

# Changelog Generator

Transforms technical git commits into a changelog real users will actually read. The target
is clear, simple, compact — one line per change, no filler, no marketing voice.

## When to use this skill
- Preparing release notes for a new version.
- Creating weekly or monthly product update summaries.
- Documenting changes for customers.
- Writing changelog entries for app store submissions.
- Maintaining a public changelog/product updates page.

## Workflow
1. **Analyze Git History**: `git log` since the last tag or between dates.
2. **Categorize Changes**: New, Improved, Fixed, Breaking.
3. **Translate to plain language**: one line per change, no jargon, no hype.
4. **Filter Noise**: exclude internal refactoring, tests, CI/CD changes, and anything a user
   wouldn't notice.
5. **Format Output**: a flat list under 4 category headers. No sub-bullets, no paragraphs.

## Format

Four categories, plain text labels — no emoji, no decoration:

- **New** — functionality that didn't exist before
- **Improved** — an existing feature got better
- **Fixed** — something broken now works
- **Breaking** — requires the user to do something

**One line per entry. If it needs a second sentence, it's two entries or it's not
changelog-worthy.**

### Example

```
## 2026-08-10

New
- Dark mode, toggle in Settings.

Improved
- Search results load faster.

Fixed
- Fixed occasional sync failures between devices.
```

### Language Transformation Examples

- **Before**: `feat: add redis cache layer for API responses`
- **After**: `Improved — API responses load faster.`
- **Before**: `fix: resolve race condition in user sync`
- **After**: `Fixed — occasional sync failures between devices.`

**Never invent a number.** If the commit message or PR doesn't state a measured impact
(a percentage, a duration, a count), describe what changed functionally — don't guess a
multiplier or percentage to sound more impressive. A specific number belongs in a changelog
only when it's real and you can point to where it came from (a benchmark, a PR description,
a linked metric).

## Resources
- Use `git log $(git describe --tags --abbrev=0)..HEAD --oneline` for analysis.
