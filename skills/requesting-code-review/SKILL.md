---
name: requesting-code-review
description: Self-contained code review checklist — formatting, type safety, duplication, readable conditions, logic-out-of-UI, test coverage, comment quality. Adapts to whatever tooling the project actually has (skips Prettier/TypeScript/test-runner checks if unconfigured). Use before merging, after completing a feature, or any time you want a second pass on code quality. In Claude Code, prefer the official `code-review` skill or `pr-review-toolkit`/`feature-dev` code-reviewer agents instead — both are real, installed, and go deeper than this checklist. This copy exists for Codex/Cursor portability, where those agents aren't available.
---

# Code Review

Review the current branch's changes. If the working tree is clean and there's
no diff against a base branch (common on small solo repos), review the full
source of the changed area instead of an empty diff.

**Core principle:** Review early, review often. Fix issues as you find them
rather than only reporting them.

## Detect available tooling first

Don't assume a stack — check what's actually configured before running a
step, and skip it cleanly (note the gap, don't fabricate a pass) if it isn't:

| Check | Look for |
|---|---|
| Prettier | `.prettierrc*`, or `"prettier"` in `package.json` |
| TypeScript | `tsconfig.json` |
| Test runner | `vitest.config.*`, `jest.config.*`, or a `test` script in `package.json` |
| Runtime validation (Zod etc.) | `zod` (or similar) in `package.json` dependencies |
| Lint | `.eslintrc*`, `eslint.config.*` |

A plain vanilla-JS project (no `package.json`, no build step) will legitimately
skip most of this table — that's expected, not a failure.

## Review Checklist

### 1. Formatting + Type Safety (only if configured)

```bash
npx prettier --check <changed files>   # only if Prettier is configured
npx tsc --noEmit                        # only if tsconfig.json exists
```

Fix prettier violations. Report TypeScript errors in code you touched.

### 2. Type Assertions (TypeScript projects only)

Search for `as any`, `as SomeType`, non-null `!` assertions. Each one is a
red flag — ask *why does this assertion exist?* Prefer: validating the value
at runtime and letting TypeScript infer the narrowed type, fixing the
upstream type, or a proper type guard.

### 3. Duplicate Code and Repeated Logic

Look for repeated logic that could be shared (a function, a hook, a util),
types/shapes defined more than once, and copy-pasted blocks with minor
variations. A pattern repeated 4+ times, or one that has already drifted
(the copies no longer agree), is worth a shared helper — three similar lines
on their own are fine.

### 4. Readable Conditions

When an `if`/ternary has 3+ conditions, involves negation, or its intent
isn't obvious from the raw expression, extract it to a named constant:

```ts
// Hard to scan
if (!isLoading && user !== null && user.role !== 'guest') { ... }

// Clear intent
const canAccessDashboard = !isLoading && user !== null && user.role !== 'guest'
if (canAccessDashboard) { ... }
```

### 5. Test Coverage (only if a test runner is configured)

For each changed file with branching logic, ask: *could this fail silently?*
Good candidates: utility functions, data transformations/formatters, hooks
with non-trivial state, validation logic. Tests live next to the file they
test. Skip this section entirely if no test runner exists — don't invent one
mid-review.

### 6. Logic Out of UI / Render Code

UI code (React components, or hand-rolled DOM-building functions in vanilla
JS) should describe *what renders*, not implement business logic. Multi-step
calculations, data transforms, or branching classification logic belongs in a
plain function outside the render path — testable in isolation, reusable,
and easier to read in both places.

### 7. Comment Quality

Remove comments that restate the next line. Keep comments that explain *why*
something non-obvious is done that way. If you're unsure whether a comment
adds value, it probably doesn't.

## Output Format

After completing all checks, give a brief summary:

- What you fixed (with file references)
- Issues found but not fixed, and why
- Checks skipped because the tooling isn't configured (so the gap is visible, not silent)
- Anything the author should know or decide

Keep it concise — the user can see the diff.
