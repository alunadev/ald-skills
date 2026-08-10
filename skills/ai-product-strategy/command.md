Activates the AI Product Strategy skill for a feature or product built on an LLM or agent.

Usage: /ai-strategy [feature or product name]

What it does:
1. Loads the ai-product-strategy skill
2. Defines the wedge — the specific high-friction task AI will own, and whether it clears the disproportionate-payoff bar
3. Chooses the architecture — RAG, fine-tuning, both, or neither
4. Designs for non-determinism — how the interface handles confidently-wrong output
5. Sets the autonomy level (L0-L3) and the evidence bar to advance it
6. Assesses defensibility — where the real moat is, honestly
7. Output: docs/strategy/YYYY-MM-DD-[feature]-ai-strategy.md

When to use:
- Before building any feature where an LLM decides or generates something a user acts on
- When choosing between RAG and fine-tuning
- When an AI feature is live but users don't trust its output
- When deciding how much a feature should act on its own vs. ask for confirmation
- When testing whether "add AI" is real value or feature theater

What NOT to use it for:
- General product strategy without an AI/LLM component (use /strategy instead)
- Choosing an AI vendor or model (that's a build/buy/tooling decision, not a strategy one)

Example: /ai-strategy support ticket triage agent
Example: /ai-strategy our AI feature keeps hallucinating and users don't trust it
Example: /ai-strategy should this be a suggestion or should it just act automatically
