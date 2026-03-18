# Task Breakdown Guide by Feature Type

Use this guide when you need to know how to break down a specific type of feature into atomic tasks. Each pattern lists the natural seams where one task ends and the next begins.

---

## CRUD Feature (Create, Read, Update, Delete)

**Natural task order:**
1. DB schema / migration (the foundation — everything depends on it)
2. Data access layer / repository (queries that wrap the schema)
3. API route — GET (read before write — easier to test)
4. API route — POST (create)
5. API route — PUT/PATCH (update)
6. API route — DELETE (with any soft-delete or cascade logic)
7. UI — List view (display before interaction)
8. UI — Create form
9. UI — Edit form (often shares components with create)
10. UI — Delete confirmation

**Splitting advice:** Each API route is one task. Each UI view is one task. Don't combine "create and edit" into one task — they have different test surfaces.

---

## Authentication Feature

**Natural task order:**
1. DB schema changes (users table, sessions table, tokens)
2. Password hashing utility / token signing utility
3. Registration endpoint
4. Email verification (if required) — send + verify routes
5. Login endpoint — returns session/token
6. Auth middleware — validates token on protected routes
7. Logout endpoint
8. UI — Registration form
9. UI — Login form
10. UI — Protected route wrapper / redirect logic

**Key insight:** Auth middleware (Task 6) must be done before any UI protected routes. The middleware is what makes all other protection work.

---

## Third-Party API Integration

**Natural task order:**
1. API client setup — credentials, base URL, error handling wrapper
2. Test the connection — simplest possible call that proves credentials work
3. First endpoint integration — the core use case
4. Error handling — rate limits, auth failures, network errors
5. Response transformation — map external data model to internal
6. Caching layer (if needed) — avoid hitting limits
7. UI integration — display the data
8. UI error states — show what happens when API is unavailable

**Key insight:** Always start with a minimal "prove it works" call before building the full integration. Discovering that the API doesn't work as documented on Task 2 (not Task 8) is worth the extra step.

---

## AI / LLM Feature

**Natural task order:**
1. Prompt engineering — write and test the prompt manually first (not in code)
2. API client setup — model, temperature, token limits, error handling
3. Streaming setup — if response needs to stream to the UI
4. Input validation — what can/can't be sent to the model
5. Output parsing — structured extraction if the model returns structured data
6. Guardrails — content filtering, length limits, fallback on failure
7. Persistence — save inputs/outputs if needed for history or billing
8. UI — input form
9. UI — streaming response display
10. UI — error states (model unavailable, content filtered, timeout)

**Key insight:** Test the prompt manually (Task 1) before writing any code. Prompt iteration is fast and cheap; prompt iteration after you've wired everything up is expensive.

---

## Data Pipeline / Background Job

**Natural task order:**
1. Input schema — define what the job receives
2. Output schema — define what the job produces
3. Core transformation logic — unit-testable, no I/O
4. I/O layer — reading input data, writing output data
5. Error handling + retry logic
6. Job registration — connect to queue or scheduler
7. Monitoring — log what happened, how long, any errors
8. Manual trigger — an endpoint or CLI command to run the job on demand for testing

**Key insight:** The core logic (Task 3) should be testable without any I/O. If you can't test the transformation without hitting a database, the logic isn't sufficiently isolated.

---

## Performance Optimization

**Natural task order:**
1. Baseline measurement — profile and record the current numbers
2. Identify the bottleneck — don't optimize until you know where the time goes
3. Implement the single highest-impact change
4. Measure again — compare to baseline
5. Decide: is the improvement sufficient, or iterate?

**Key insight:** Task 1 and Task 4 are mandatory. An optimization without a before/after measurement is a guess. If you can't measure it, you can't know if it worked.

---

## UI Component (reusable)

**Natural task order:**
1. Define the component API — what props does it accept? What does it emit?
2. Static version — render with hardcoded data, no behavior
3. Variants — handle different states (empty, loading, error, populated)
4. Interactive behavior — click handlers, form submission, keyboard nav
5. Accessibility — aria labels, keyboard focus, screen reader testing
6. Responsive behavior — mobile, tablet, desktop
7. Documentation — prop table, usage example, edge cases

**Key insight:** Task 1 (the API) is the most important design decision. Get it wrong and everything downstream is wrong. Spend time here before writing any implementation.

---

## Common Splitting Mistakes

**Don't split by time:** "Spend 2 hours on feature X" is not an atomic task. Split by behavior.

**Don't combine frontend + backend into one task:** "Build the login page and login API" is two tasks. The API should be testable without the UI.

**Don't skip the error state tasks:** Every happy-path task has a corresponding error-path task. They can be combined, but they can't be skipped.

**Don't make Task 1 "set up the project":** If setup is needed, it's its own task. But if the project is already set up, start with something that produces business value immediately.
