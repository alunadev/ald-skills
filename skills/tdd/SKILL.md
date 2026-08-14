---
name: tdd
description: Red-green-refactor test-driven development discipline — write a failing test at the public interface first, minimal code to pass it, one slice at a time. Use when writing new logic or fixing a bug (write the regression test first), for any code where correctness matters more than raw speed.
---

# TDD

Red-green-refactor, one slice at a time. Tests describe WHAT the code does, not HOW — code can
change entirely; the test shouldn't.

## The loop

1. **Red.** Write one failing test for the next smallest piece of behavior. Confirm it actually
   fails, and fails for the reason you expect, before writing implementation.
2. **Green.** Write the minimum code to pass it. Resist building ahead for behavior you haven't
   tested yet.
3. **Refactor — later, not here.** Don't refactor inside the red-green loop; that's
   `requesting-code-review`'s job, or a deliberate follow-up pass. Mixing refactor into the loop
   makes it unclear whether a failure is a real regression or a refactor artifact.

Repeat per vertical slice. Each test is a tracer bullet revealing what to build next — writing
every test before any implementation (horizontal slicing) hides the lessons each cycle would
have taught you.

## What to test — and what not to

Test at **seams** (public interfaces), never implementation details:

- GOOD: exercises the public interface, describes WHAT, survives a refactor that doesn't change
  behavior.
- BAD: mocks internal collaborators, tests private methods, asserts call counts/order — breaks
  on any refactor even when behavior is unchanged.

Avoid **tautological tests** — an expected value recomputed the same way the implementation
computes it passes by construction and catches nothing. Use an independent, known literal
instead.

Full good/bad examples: [tests.md](tests.md).

## When to mock

Mock only at **system boundaries**: external APIs, time/randomness, sometimes the database or
filesystem. Never mock your own modules or anything you control — that's testing the mock, not
the code.

Design for it: accept dependencies instead of creating them internally (dependency injection),
and prefer specific SDK-style functions per external operation over one generic fetcher with
conditional logic — each becomes independently, simply mockable.

Full guidance: [mocking.md](mocking.md).

## Why this exists

Today, tests get written "when I remember" — that's the honest starting point. This skill is the
discipline behind Engineering #13 in `products/ald-os/context/product-builder-principles.md`:
every push/release needs coverage, and tests get written as part of building, not bolted on
after. AI can write and run the tests; the loop and the seam/boundary discipline above are what
keep AI-written tests from becoming implementation-coupled busywork instead of a real safety
net.

## Source

Adapted from [mattpocock/skills](https://github.com/mattpocock/skills)' `tdd` skill.
