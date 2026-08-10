---
name: changelog-generator
description: Transforms technical git commits into polished, user-friendly changelogs. Use when preparing release notes, creating product update summaries, documenting changes for customers, or maintaining a public changelog page.
---

# Changelog Generator

Transforms technical git commits into polished, user-friendly changelogs that your customers and users will actually understand and appreciate.

## When to use this skill
- Preparing release notes for a new version.
- Creating weekly or monthly product update summaries.
- Documenting changes for customers.
- Writing changelog entries for app store submissions.
- Maintaining a public changelog/product updates page.

## Workflow
1.  **Analyze Git History**: Use `git log` to get commits since the last tag or between dates.
2.  **Categorize Changes**: Group commits into Features, Improvements, Fixes, Breaking Changes, and Security.
3.  **Translate to User-Friendly Language**: Convert technical jargon into clear, benefit-driven descriptions.
4.  **Filter Noise**: Exclude internal refactoring, tests, and CI/CD changes.
5.  **Format Output**: Generate a clean Markdown document following the standard structure.

## Instructions

### Categorization
- ✨ **New Features**: New functionality added.
- 🔧 **Improvements**: Enhancements to existing features.
- 🐛 **Fixes**: Bug fixes and corrections.
- 💥 **Breaking Changes**: Changes requiring user action.
- 🔒 **Security**: Security-related updates.

### Language Transformation Examples
- **Before**: `feat: add redis cache layer for API responses`
- **After**: **Faster API**: Responses now load noticeably faster thanks to improved caching.
- **Before**: `fix: resolve race condition in user sync`
- **After**: Fixed issue where user data occasionally wouldn't sync across devices.

**Never invent a number.** If the commit message or PR doesn't state a measured impact
(a percentage, a duration, a count), describe what changed functionally — "loads faster,"
"fewer failed syncs" — don't guess a multiplier or percentage to sound more impressive. A
specific number belongs in a changelog only when it's real and you can point to where it
came from (a benchmark, a PR description, a linked metric).

## Resources
- Use `git log $(git describe --tags --abbrev=0)..HEAD --oneline` for analysis.
