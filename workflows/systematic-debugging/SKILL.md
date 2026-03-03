---
name: systematic-debugging
description: Enforces a disciplined, evidence-based debugging protocol. Use when the user reports a bug, an unexpected behavior, a broken test, or asks "why is X not working?". Prevents premature fixes and treats symptoms. Blocks code changes until a root cause is confirmed.
---

# Systematic Debugging

You are a Senior Engineer enforcing the **Systematic Debugging** protocol.

**CORE RULE:** No fixes are allowed without a confirmed Root Cause.

## Workflow

<workflow>
  <phase number="1" name="Root Cause Investigation">
    <instruction>Do not propose code changes yet. Gather evidence first.</instruction>
    <step>
      <action>Analyze stack traces and logs. Identify exact file paths and line numbers.</action>
    </step>
    <step>
      <action>Attempt to reproduce. Ask user: "Can we reproduce this consistently?"</action>
    </step>
    <step>
      <condition>IF system is multi-component (e.g., API→DB, CI→Build):</condition>
      <action>Add diagnostic logging at component boundaries to trace data flow (Input vs Output).</action>
    </step>
    <check>Do you know the exact line of code or config causing the issue? If NO, do not proceed.</check>
  </phase>

  <phase number="2" name="Pattern Analysis">
    <step>
      <action>Find a working example of this same pattern elsewhere in the codebase.</action>
    </step>
    <step>
      <action>List the explicit differences between the working example and the broken code.</action>
    </step>
    <step>
      <action>Check git log for recent changes in the affected files. When did this start breaking?</action>
    </step>
  </phase>

  <phase number="3" name="Hypothesis">
    <action>Formulate a single, testable hypothesis: "I think X is broken because Y."</action>
    <action>Perform a minimal test (hardcoded value, isolated log, unit test) to prove or disprove.</action>
    <check>Did the minimal test prove the hypothesis?</check>
    <loop>If NO → return to Phase 1 with new evidence. Do NOT skip back to guessing.</loop>
  </phase>

  <phase number="4" name="Implementation — The Fix">
    <instruction>Only proceed if Phase 3 returned YES.</instruction>
    <step>
      <action>Write a FAILING test that reproduces the exact bug (TDD: Red).</action>
    </step>
    <step>
      <action>Implement the minimal fix — do NOT refactor unrelated code.</action>
    </step>
    <step>
      <action>Run the test to confirm it now passes (TDD: Green).</action>
    </step>
    <step>
      <action>Run the full test suite to confirm no regressions.</action>
    </step>
  </phase>

  <circuit-breaker>
    <rule>Track the count of failed fix attempts in this session.</rule>
    <check>
      IF failed_attempts >= 3:
      STOP IMMEDIATELY.
      Output: "⚠️ ARCHITECTURAL ALERT ⚠️ — 3 consecutive fixes failed. We are treating symptoms, not the root cause. Recommendation: step back and discuss potential refactoring or architectural change before proceeding."
    </check>
  </circuit-breaker>
</workflow>

## Anti-Patterns to Block

| Anti-Pattern | Why it's dangerous | What to do instead |
|---|---|---|
| "Let me try changing X and see if it helps" | Guessing, not diagnosing | Stop and return to Phase 1 |
| "This looks similar to a bug I've seen before" | Bias over evidence | Verify with current stack trace first |
| Fixing the symptom not the cause | Creates new bugs | Trace to root before touching code |
| Refactoring while fixing | Conflates changes | One commit = one concern |
| Skipping the failing test | Can't verify the fix | TDD is not optional |

## Debugging Toolkit by Layer

**Frontend (React/Next.js):**
- `console.log` → `JSON.stringify(obj, null, 2)` for objects
- React DevTools → check props, state, renders
- Network tab → check actual requests vs expected
- `useEffect` deps → missing deps cause stale closures

**API / Backend:**
- Log full request/response at boundary
- Check env vars are loaded correctly (`console.log(process.env.X)`)
- Isolate: does the route handler work with a hardcoded payload?

**Database (Supabase/Postgres):**
- Run the raw SQL query in the Supabase dashboard
- Check RLS policies — most mysterious "no data" bugs are RLS
- Verify the return shape matches what the client expects

**Build / CI:**
- Check if the bug exists locally first
- Compare Node/package versions between environments
- Clear `.next/`, `node_modules/`, reinstall from scratch
