# Strict Implementation Plan Template

Every plan follows this structure. Copy it. Fill it in. Don't improvise the format — consistency makes plans easier to review and execute.

---

## Document Header

```markdown
# [Feature Name] Implementation Plan

**Goal:** [One sentence — what does "done" look like for this feature?]
**Architecture:** [2-3 sentences on the approach — what pattern, what tech, why]
**Tech Stack:** [Key technologies, libraries, and versions]
**Dependencies:** [What must exist or be merged before this plan can start?]
**Estimated tasks:** [N tasks, roughly N-M hours]

---
```

---

## Task Structure

Repeat this block for every task. Each task = one commit.

```markdown
### Task N: [Descriptive Name — verb + noun, e.g., "Add user authentication middleware"]

**Context:** [One sentence on why this task exists and what it enables]

**Files:**
- Create: `exact/path/to/new-file.ts`
- Modify: `exact/path/to/existing-file.ts` (add X, change Y at ~line 45)
- Test: `tests/exact/path/to/feature.test.ts`

**Step 1 — Write the failing test (Red)**
```typescript
// In tests/exact/path/to/feature.test.ts
describe('FeatureName', () => {
  it('should [specific behavior being tested]', () => {
    const result = functionUnderTest(input);
    expect(result).toEqual(expectedOutput);
  });
});
```

Run: `npm test -- --testPathPattern="feature.test" --testNamePattern="specific behavior"`
Expected: FAIL ✗ (test should fail because the code doesn't exist yet)

**Step 2 — Minimal implementation (Green)**
```typescript
// In exact/path/to/new-file.ts
export function functionUnderTest(input: InputType): OutputType {
  // Minimum code to make the test pass — no gold-plating
  return expectedOutput;
}
```

Run: same command as above
Expected: PASS ✓

**Step 3 — Refactor (if needed)**
[What to clean up: extract a constant, rename a variable, simplify a condition]
[If nothing to refactor, write "N/A — implementation is already clean"]

**Step 4 — Verify full suite**
Run: `npm test`
Expected: All tests PASS ✓, no regressions

**Step 5 — Commit**
```bash
git add [exact files changed]
git commit -m "feat(scope): [what this task does in imperative tense]"
```
```

---

## Example: Complete 3-Task Plan

```markdown
# User Email Verification Implementation Plan

**Goal:** Add email verification flow so new users must confirm their email before accessing the app.
**Architecture:** Add a `verified` boolean to the users table. On registration, send a verification email with a signed token. On click, mark user as verified. Block unverified users in auth middleware.
**Tech Stack:** Next.js 14, Supabase (Postgres + Auth), Resend (email), jose (JWT signing)
**Dependencies:** Resend API key in env vars, email template design approved
**Estimated tasks:** 4 tasks, ~3-4 hours

---

### Task 1: Add verified column to users table

**Context:** Foundation for the entire flow — nothing else can be built until the DB schema exists.

**Files:**
- Create: `supabase/migrations/20240115_add_user_verified.sql`
- Modify: `types/database.ts` (add `verified: boolean` to User type)

**Step 1 — Write the failing test**
```sql
-- Test: column exists and defaults to false
SELECT column_name, data_type, column_default
FROM information_schema.columns
WHERE table_name = 'users' AND column_name = 'verified';
-- Expected: row with boolean type, default false
```

**Step 2 — Migration**
```sql
ALTER TABLE users ADD COLUMN verified BOOLEAN NOT NULL DEFAULT false;
```

Run: `supabase db push`
Expected: migration applies without error ✓

**Step 3 — Update types**
```typescript
// types/database.ts
export interface User {
  id: string;
  email: string;
  verified: boolean; // Add this
  created_at: string;
}
```

**Step 5 — Commit**
```bash
git add supabase/migrations/ types/database.ts
git commit -m "feat(auth): add verified column to users table"
```

---

### Task 2: Send verification email on registration

[continues...]
```

---

## Mandatory Inclusions Checklist

Before presenting the plan, verify:

- [ ] Every task has exact file paths (not "the auth file" — `src/lib/auth/middleware.ts`)
- [ ] Every test command is runnable as written (no "run the tests")
- [ ] Tasks include both happy path AND error state tests
- [ ] Commit messages follow the project's convention
- [ ] Task 1 can be started in under 10 minutes (no blocked dependencies)
- [ ] The plan doesn't skip verification steps to "save time" — every task is verifiable
