Activates the Content Publishing workflow — from raw idea to published post with mandatory capture and edit gates.

Usage: /publish [idea or platform]

What it does:
1. Captures the idea as an atomic note (Insight + Context + Evidence) — Gate 1
2. Selects the right platform and drafts using writing-system format
3. Runs edit pass: cut 30%, add concrete example, read aloud — Gate 2
4. For LinkedIn: optionally loads linkedin-viral-post-writer for hook optimization
5. Publishes or prepares the final draft
6. Saves to docs/content/YYYY-MM-DD-content-notes.md + schedules 30-day review

When to use:
- When you have an insight or idea worth sharing publicly
- For any content that will be published (thread, post, article, newsletter)
- When you want to avoid publishing an unedited draft

What NOT to use it for:
- Internal documentation (use codebase-documenter or maintaining-documentation)
- PRDs or feature specs (use /prd)
- Launch announcements (use alongside /feature-launch, not instead of it)

Platforms supported:
- X/Twitter — thread format
- LinkedIn — uses linkedin-viral-post-writer for hook optimization
- Blog — saves to docs/content/ with front matter
- Newsletter — subject line variants + preview text

Example: /publish X thread about why I switched to Tailwind v4
Example: /publish LinkedIn — launched my side project today
Example: /publish newsletter edition #12
Example: /publish blog post about building with Supabase RLS
