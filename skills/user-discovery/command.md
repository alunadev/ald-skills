Activates the User Discovery protocol for a segment or hypothesis.

Usage: /discovery [user segment or hypothesis to test]

What it does:
1. Loads the user-discovery skill
2. Asks: research type (interview guide / synthesis / both), target segment, and key hypotheses to validate
3. For interviews: generates a tailored interview guide with screener, warm-up, and core questions
4. For synthesis: takes your notes and extracts patterns, Opportunity Statements, and ranked insights
5. Output: docs/research/YYYY-MM-DD-[segment]-discovery.md

When to use:
- Before writing a PRD for a new feature area
- After seeing unexpected drop-off in analytics (understand the why)
- When roadmap direction is unclear and you need user signal
- When you have user interview notes that need synthesis

What NOT to use it for:
- Quantitative analysis (use /metrics instead)
- Validating copy or design (use a usability test, not a discovery interview)

Example: /discovery solo freelancers dropping off at payment step
Example: /discovery power users who use the product daily
Example: /discovery new signups who don't activate in first week
