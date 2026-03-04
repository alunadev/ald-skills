Activates the Product Strategy skill for a product or time horizon.

Usage: /strategy [product name or planning horizon]

What it does:
1. Loads the product-strategy skill
2. Asks: current North Star metric, most recent OKR results, key strategic context (market, competition, constraints)
3. Runs Opportunity Tree mapping (problems worth solving → approaches → bets)
4. Produces 3 strategic bets with rationale + OKR recommendations for next quarter
5. Output: docs/strategy/YYYY-MM-DD-[product]-strategy.md

When to use:
- Before quarterly planning when roadmap direction is unclear
- When North Star metric is stagnant and you need to diagnose why
- When evaluating multiple big bets and need a framework to compare them
- When you need to align stakeholders on strategic direction

What NOT to use it for:
- Feature-level decisions (use /prd instead)
- Post-hoc analysis of what happened (use /metrics instead)

Example: /strategy Q2 planning for [product name]
Example: /strategy [product] — North Star has been flat for 3 months
Example: /strategy choosing between 3 big bets for next year
