---
name: generating-changelogs
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
- **After**: **Faster API**: Responses now load 3x faster thanks to improved caching.
- **Before**: `fix: resolve race condition in user sync`
- **After**: Fixed issue where user data occasionally wouldn't sync across devices.

## Resources
- Use `git log $(git describe --tags --abbrev=0)..HEAD --oneline` for analysis.
