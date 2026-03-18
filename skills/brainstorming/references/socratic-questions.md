# Socratic Question Bank

Use these questions to surface hidden constraints, test assumptions, and guide the user toward a clear design decision. Ask one at a time. Each answer should unlock the next question.

---

## Architecture Questions

**Scoping**
- "What does 'done' look like for this? If I showed you the finished product, what would you see?"
- "What's the smallest version of this that would be useful?"
- "What are we explicitly NOT building? What's out of scope?"

**Constraints**
- "What are the hard constraints? (performance budget, tech stack, team size, deadline)"
- "What does the existing system do that this can't break?"
- "What would make you abandon this approach entirely?"

**Failure modes**
- "What happens if [external service / database / network] is unavailable?"
- "What's the worst-case scenario for a user if this goes wrong?"
- "How do we know when something has gone wrong?"

---

## Data Model Questions

**Shape**
- "What does a single record look like? Walk me through the fields."
- "What's the relationship between X and Y — one-to-one, one-to-many, or many-to-many?"
- "Does this data change after it's created, or is it append-only?"

**Volume and access**
- "How many of these records do you expect? Thousands, millions, billions?"
- "How often is this read vs. written? Is it read-heavy or write-heavy?"
- "Do you need the full record, or do you usually query a subset of fields?"

**Ownership**
- "Who creates this data, who reads it, and who can change it?"
- "Does this data belong to a user, a team, a system, or something else?"

---

## API Design Questions

**Contract**
- "Who are the callers? Internal services, mobile clients, third parties?"
- "What does the request look like? What must the caller provide?"
- "What does a successful response look like? What about an error?"

**Behavior**
- "Should this be synchronous (caller waits for result) or async (caller gets a job ID)?"
- "What happens if the same request is sent twice? Should it be idempotent?"
- "Are there rate limits or quotas the caller needs to know about?"

---

## UI/UX Questions

**User context**
- "Who is the user doing this task? What do they know and what don't they know?"
- "What were they doing before this, and what do they do after?"
- "What's the most common path? What's the exception path?"

**Interaction model**
- "Does the user expect immediate feedback, or is waiting acceptable here?"
- "What happens if they make a mistake? Can they undo it?"
- "Is this a one-time action or something they'll do repeatedly?"

---

## Performance Questions

- "What's an acceptable response time for the user? Under 200ms, under 1s, or can it take longer?"
- "Is the bottleneck likely to be compute, I/O, or network?"
- "Is this on the critical path (user is waiting) or a background job (user doesn't notice)?"
- "Do you need real-time updates, or is eventual consistency acceptable?"

---

## Make-vs-Buy Questions

- "Does an off-the-shelf solution exist for this? What would we lose by using it?"
- "What's the cost of maintaining this ourselves over 2 years vs. paying for a managed service?"
- "Are we solving a unique business problem here, or is this infrastructure?"
