Activates the Design Lab — a full design exploration with an interview, 5
variants of a whole page or screen, real feedback on the rendered result, and
an implementation plan.

Usage: /design-lab [what to explore — "the onboarding flow", "the dashboard"]

What it does:
1. Loads the design-lab skill
2. Checks for existing project identity (DESIGN.md, Design Memory) before
   inferring anything generically
3. Runs the design interview and saves a structured brief
4. Generates 5 variants, each on a different named axis, in a temporary route
5. Hands you the live route so you react to the actual rendered UI and say,
   in your own words, what works and what doesn't
6. Synthesizes the feedback into an implementation plan + Design Memory
7. Cleans up every temporary file it created

When to use:
- The direction is still open — you don't yet know what the thing should be
- Scope is a whole page, screen, or flow
- You want the exploration recorded (brief, plan, Design Memory) rather than
  just a choice

When not to use:
- Scope is one component and the direction is clear — use `/prototype`, which
  skips the interview
- The UI is already real and just needs a craft pass — use `taste-redesign`

Note: heavier than `/prototype` by design. Reach for it when the exploration
is worth the interview.
