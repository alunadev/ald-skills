---
name: prompt-clarifier
description: >
  Enriches vague, low-detail prompts into structured, agent-optimized XML before execution.
  INVOKE IMMEDIATELY — before any tool use or file reads — when you detect any of these signals:
  prompt under 10 words with no file path or error message; vague action verbs with no object
  ("fix the bug", "make it better", "clean this up", "refactor this", "optimize performance",
  "improve the UI", "add authentication", "add payments", "add notifications", "build the feature");
  CLARIFIER_ADVISORY in your context window; user says "clarify", "help me describe this",
  "enrich this prompt", "structure my request". Also triggers on: "make this work", "it's broken",
  "it looks bad", "add X" with no further detail, "implement Y" with no constraints.
  Do NOT trigger on: prompts ending with ?, prompts containing error messages or stack traces,
  prompts with specific file paths, prompts already containing acceptance criteria or success metrics.
---

# Prompt Clarifier

A skill that converts vague user instructions into structured, agent-optimized prompts through
a brief Socratic interview — before any execution begins.

## Why This Matters

Vague prompts ("fix the bug", "add auth") produce divergent results because the agent makes
arbitrary decisions on scope, constraints, and success criteria. A 2-minute clarification
interview eliminates 80% of revision cycles by capturing intent, constraints, and definition
of done before any code is written.

## When to Invoke

Invoke this skill **before any other action** when:
- The prompt is under 10 words and contains no file path, error message, or acceptance criteria
- `CLARIFIER_ADVISORY` appears in your context window
- The user has expressed intent without saying *what done looks like*

Skip clarification and proceed directly when:
- You can read the relevant files and the intent is unambiguous from codebase context
- The prompt already contains specific file paths, named functions, or error messages
- The prompt is a question (ends with ?)

---

## The 5 Enrichment Dimensions

Every vague prompt is missing coverage across these axes. Your interview targets whichever
dimensions have the largest gap:

| Dimension | The question it answers | Priority |
|-----------|------------------------|----------|
| **Intent** | What does "done" look like? | Always ask first |
| **Scope** | What is explicitly out of scope? | Ask for "add X" / "build X" prompts |
| **Constraints** | What must not change or break? | Ask for risky changes (auth, payments, data) |
| **Success Criteria** | How will you verify it worked? | Ask if not implied by Intent |
| **Context** | Which files / components are the entry point? | Ask if no file paths mentioned |

---

## Interview Protocol

### Step 1: Detect missing dimensions

Scan the original prompt. Which of the 5 dimensions are missing or ambiguous? Rank them by
impact — missing Intent is worse than missing Context.

### Step 2: Ask one question at a time

Pick the highest-impact missing dimension. Ask a single, focused question. Prefer
**multiple-choice** over open-ended:

> "Is this about correctness (wrong output), performance (it's slow), or experience (it
> feels wrong)?" is better than "What's the problem?"

### Step 3: Maximum 3 rounds

After 3 questions, enrich with what you have. Don't let the interview become a form.
If the user answers briefly, accept it and move on.

### Step 4: Produce the enriched prompt

Output the enriched prompt in the XML schema below. Show it to the user and ask:
"Should I proceed with this, or is anything off?"

### Step 5: Execute against the enriched prompt

On approval (including implicit approval — no objection after 10 seconds), proceed with
the enriched prompt as your working specification.

---

## Question Bank

Use these as starting points. Adapt the wording to the context — don't read them verbatim.

For full question guidance, see `references/question-bank.md`.

**Intent questions (ask first for "fix", "improve", "make better" prompts):**
- "What's happening now vs. what should happen?"
- "Is this about correctness, performance, or experience?" [multiple choice]

**Scope questions (ask first for "add X", "build X" prompts):**
- "What existing behavior must stay completely unchanged?"
- "Any edge cases or user types that must be handled?"

**Constraint questions (ask for auth, payments, data-handling prompts):**
- "Any security or compliance requirements? (e.g., session handling, logging restrictions)"

**Success criteria (ask if not answered by Intent):**
- "How will you verify this is working? What test or check would satisfy you?"

**Context (ask if no file paths mentioned):**
- "Which file or component is the starting point? Or should I search the codebase?"

---

## Enriched Prompt XML Schema

ALWAYS use this exact structure for the output:

```xml
<enriched_prompt>
  <original_request>[verbatim user prompt]</original_request>

  <intent>
    <what_to_accomplish>[one sentence — the actual goal]</what_to_accomplish>
    <type>bug_fix | new_feature | refactor | performance | ui_improvement | other</type>
    <priority>critical | high | normal</priority>
  </intent>

  <context>
    <entry_point>[file path or component where work starts, or "TBD — search codebase"]</entry_point>
    <affected_systems>[comma-separated affected components]</affected_systems>
  </context>

  <constraints>
    <must_not_break>[existing behaviors, APIs, or tests that must stay intact]</must_not_break>
    <scope_boundary>[what is explicitly out of scope for this task]</scope_boundary>
    <security>[security or compliance requirements, or "none stated"]</security>
  </constraints>

  <success_criteria>
    <criterion>[verifiable outcome #1]</criterion>
    <criterion>[verifiable outcome #2]</criterion>
    <definition_of_done>[how the user will verify the task is complete]</definition_of_done>
  </success_criteria>

  <output_format>
    <deliverable>[what to produce: code change, explanation, PR description, etc.]</deliverable>
  </output_format>
</enriched_prompt>
```

For the copy-pasteable blank template, see `references/enriched-prompt-template.xml`.

---

## Examples

### Before / After: "add authentication"

**Before:**
> add authentication

**After 2 questions** ("What auth method — email/password, OAuth, or both?" + "Which routes
need protection?"):

```xml
<enriched_prompt>
  <original_request>add authentication</original_request>
  <intent>
    <what_to_accomplish>Add email/password login with session persistence so unauthenticated
    users are redirected to /login before accessing protected routes</what_to_accomplish>
    <type>new_feature</type>
    <priority>high</priority>
  </intent>
  <context>
    <entry_point>src/app/(protected)/layout.tsx — gate all protected routes here</entry_point>
    <affected_systems>Next.js app router, Supabase Auth, middleware</affected_systems>
  </context>
  <constraints>
    <must_not_break>Public routes (/, /about, /pricing) must stay accessible without auth</must_not_break>
    <scope_boundary>OAuth providers (Google, GitHub) are out of scope for this iteration</scope_boundary>
    <security>Use httpOnly cookies for session storage. Do not log passwords or tokens.</security>
  </constraints>
  <success_criteria>
    <criterion>Unauthenticated user hitting /dashboard is redirected to /login</criterion>
    <criterion>Authenticated user can log out and session is cleared</criterion>
    <definition_of_done>Manual test: sign up → log in → access protected route → log out → confirm redirect</definition_of_done>
  </success_criteria>
  <output_format>
    <deliverable>Code changes to middleware, new auth pages, Supabase config</deliverable>
  </output_format>
</enriched_prompt>
```

---

### Before / After: "fix the bug"

**Before:**
> fix the bug

**After 2 questions** ("What's happening vs. what should happen?" + "Where does the bug occur —
which page, action, or API call?"):

```xml
<enriched_prompt>
  <original_request>fix the bug</original_request>
  <intent>
    <what_to_accomplish>Fix the checkout form submission that silently fails when the user's
    cart has more than 10 items — no error shown, order not created</what_to_accomplish>
    <type>bug_fix</type>
    <priority>critical</priority>
  </intent>
  <context>
    <entry_point>src/components/CheckoutForm.tsx → handleSubmit function</entry_point>
    <affected_systems>CheckoutForm component, /api/orders route handler, cart state</affected_systems>
  </context>
  <constraints>
    <must_not_break>Existing orders with ≤10 items must continue to work</must_not_break>
    <scope_boundary>Cart pagination and bulk discount logic are out of scope</scope_boundary>
    <security>none stated</security>
  </constraints>
  <success_criteria>
    <criterion>Submitting a cart with 11+ items creates an order successfully</criterion>
    <criterion>If the order fails, the user sees a clear error message</criterion>
    <definition_of_done>Add a cart with 11 items, submit checkout, confirm order appears in the DB</definition_of_done>
  </success_criteria>
  <output_format>
    <deliverable>Bug fix in CheckoutForm.tsx and/or the orders API route</deliverable>
  </output_format>
</enriched_prompt>
```

---

## Failure Modes to Avoid

- **Don't ask all 5 questions upfront.** It feels like a bureaucratic form. Ask the most critical one first.
- **Don't block on partial information.** After 3 rounds, fill the gaps with reasonable assumptions and label them `[assumed]`.
- **Don't paraphrase back the entire original prompt.** State the enriched intent in your own words.
- **Don't clarify obvious things.** If the user says "fix the TypeScript error in src/auth.ts:42", proceed — that's already specific enough.
