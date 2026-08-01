Activates the Canonical Docs bootstrap workflow — grills you one question at a time (with a
recommended answer each time) until the full project knowledge base is filled in for real,
instead of left as `[FILL IN]` guesses.

Usage: /canonical-docs [project or product name]

What it does:
1. Detects whether this is a brand-new project, a lighter product folder graduating to a full
   build, or an existing set of canonical docs that's stale or incomplete
2. Copies whichever template files are missing from the bundled set in `resources/templates/`
3. Interviews branch by branch — Team & Constraints → Product Context & Personas → PRD → App Flow
   → Design System → Tech Stack → Backend Structure → Implementation Plan — one question at a
   time, always with a recommended default, never moving to the next branch until the current one
   is resolved or explicitly marked as an open question
4. Writes each doc as its branch closes, with a short "here's what we captured" checkpoint
5. Closes by updating progress.txt and CLAUDE.md, then giving one consolidated summary of every
   confirmed decision and every open question across all docs

When to use:
- Starting a brand-new product or side project, before any code or other build-oriented skill
- An ald-system product (`products/<name>/`) that only has the lightweight context notes is
  moving into a real build and needs the full PRD/App Flow/Design System/Tech Stack/Backend
  Structure/Implementation Plan set
- Existing canonical docs are half-filled, stale, or were written by guessing instead of asking

What NOT to use it for:
- A single feature PRD inside an already-documented product (use /prd or `prd-writer` directly)
- An idea that hasn't been validated yet (run /idea first — canonical-docs assumes there's a real
  product to document, not one still being decided)
- A quick mid-build design decision (use `brainstorming` instead)

Example: /canonical-docs lunaroid
Example: /canonical-docs new side project — a habit tracker for freelancers
Example: /canonical-docs pulse (graduating from notes to a real build)
