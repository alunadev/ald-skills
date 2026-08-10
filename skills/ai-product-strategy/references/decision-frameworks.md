# AI Product Strategy — Decision Frameworks

Deeper reference for the workflow steps in `SKILL.md`. Read this when the inline
tables aren't enough to make the call.

## RAG vs. Fine-Tuning vs. Neither

| Signal | Points to |
|---|---|
| Answers depend on data that changes daily/hourly (inventory, prices, tickets, docs) | RAG |
| Answers depend on data specific to one user/org that a base model can't know | RAG |
| You need source attribution ("here's where this came from") for trust or compliance | RAG |
| The task needs a distinctive voice, format, or reasoning pattern that's hard to get right with prompting alone, across thousands of calls | Fine-tuning — but try structured output + a strong system prompt first |
| The task is narrow and well-specified (classification, extraction, a fixed output schema) | Often neither — a well-prompted call with structured output is enough |
| You're tempted to fine-tune to "make it sound like us" | Try a detailed system prompt + few-shot examples first; fine-tuning is the expensive fallback, not the starting point |

**Cost asymmetry to keep in mind**: RAG adds infrastructure (retrieval, embeddings, freshness pipelines) but stays portable across model upgrades — swap the underlying model, keep the pipeline. Fine-tuning re-couples the product to a specific model version and has to be redone (or re-validated) every time you'd otherwise want to upgrade. Prefer RAG + good prompting until there's concrete evidence prompting has hit a ceiling.

**Worked example**: A support-ticket triage feature needs today's open tickets (RAG — the data changes constantly) and needs to write in the company's specific tone for canned replies (try prompting first; fine-tune only if prompting demonstrably can't hold the tone across edge cases at volume).

## The Autonomy Ladder, in Detail

| Level | What it looks like | When it's appropriate | Failure mode if used too early |
|---|---|---|---|
| L0 — Suggest only | AI proposes text/action, human does all the work of using it | Any new feature, anything with real cost per mistake, first 30-90 days of any feature | None — this is the safe default |
| L1 — Act with confirmation | AI drafts a concrete action (an email, a file change, a transaction), human reviews and approves before it executes | Once suggestions are consistently useful and users are asking "just do it for me" | Confirmation fatigue — if every action needs approval and approvals are rubber-stamped, you have L2 risk with L1 friction |
| L2 — Act with easy undo | AI executes automatically; a clear, fast undo window exists | Actions are individually low-cost and easily reversible (a draft, a label, a scheduled reminder) | Undo window too short or too hard to find — effectively L3 without the trust that should justify it |
| L3 — Full autonomy | AI executes without per-action review; humans audit in aggregate (dashboards, sampling, alerts on anomalies) | High-volume, low-per-action-cost actions with a strong track record and good aggregate monitoring | Irreversible or high-cost actions running here — this is where AI products lose users' trust for good |

**The evidence bar, concretely**: don't advance a level because the demo worked. Advance when you can point to a measured accuracy/success rate over a real volume of production runs, and a clear answer to "what's the cost when this level is wrong."

## Defensibility Stack, Worked Examples

| Layer | What it means in practice | Example |
|---|---|---|
| Proprietary data flywheel | Every use generates data competitors don't have, and that data measurably improves the product | A coding agent that learns a team's specific codebase conventions over months of use |
| Workflow depth / switching cost | The product is embedded deep enough in a process that removing it breaks things | A finance-ops agent wired into approval chains, audit logs, and existing tools |
| Verticalization | Domain-specific knowledge and integrations a general-purpose AI wrapper won't replicate | A legal-contract review tool that understands jurisdiction-specific clauses, not just "read this PDF" |
| Interface / UX craft | A meaningfully better experience around comparable underlying model capability | A genuinely faster, clearer way to review and correct AI output than competitors offer |
| Thin wrapper on a foundation model API | Being first to call the API with a good prompt | Assume this evaporates within one model generation — 12-18 months, sometimes less |

Most early-stage AI products are honestly sitting at "thin wrapper" or "UX craft" — that's fine as a starting point, but the strategy brief should name what's being built toward layers 1-3, not pretend the wrapper is already a moat.
