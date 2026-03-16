---
name: case-study-solver
description: Structured methodology for solving, writing, and presenting hiring case studies for Senior Product Manager and Technical PM roles. Use when resolving a case study, reviewing a case study response, or building a presentation prototype from a completed case study. Covers the full process from problem understanding to final delivery, including data analysis, written response, and interactive presentation.
---

# Case Study Solver

Structured methodology for solving hiring case studies at Senior PM and Technical PM level. Built from a real process used to complete a Groupon Senior TPM case study covering production systems, observability, and data analysis.

## Core Philosophy

Case studies are not tests of knowledge. They are tests of judgment under ambiguity.

Three things that matter most:
- **Reasoning quality over output volume.** A short, precise answer beats an exhaustive one every time.
- **Honest engagement with data.** Acknowledging what the data does not support is as important as stating what it does.
- **Voice consistency.** The response must sound like a Senior PM wrote it, not like a document was generated.

Three things that do not matter:
- Specific tools or vendors
- Exhaustive coverage of every edge case
- Polished visualisations

---

## Phase 0 — Problem Understanding (before writing anything)

This is the most important phase. Never skip it.

### Step 1: Read the full brief as a system description

Before forming any opinion, read everything with one question in mind: what is the actual problem here, beneath the surface symptoms described?

Ask:
- What is the company trying to protect? (Revenue, trust, reliability, partnerships)
- What failure mode is being described? (Reactive posture, alert fatigue, data quality, ownership gaps)
- What does "good" look like from their perspective?

### Step 2: Explain the problem out loud (or in writing) before touching any deliverable

If there is a dataset, explore it before forming conclusions. Never start with a conclusion and work backwards.

For datasets specifically:
- Check structure first: shape, columns, nulls, data types, date range
- Check distributions before doing any aggregation
- Ask what the data is NOT showing before asking what it is showing
- Identify structural gaps (missing fields, uneven coverage, incomplete time windows) as first-class findings, not footnotes

### Step 3: Map the questions explicitly

List every question the case study asks. Every sub-bullet counts. Before writing the response, confirm each question has a corresponding answer.

---

## Phase 1 — Response Structure

### Section-by-section approach

Work one section at a time. Never write the full response in one pass.

For each section:
1. Draft a response based on your own thinking first
2. Review it against the exact question asked (not your interpretation of it)
3. Check for completeness: are all sub-questions answered?
4. Check for tone: does this sound like a Senior PM or like a report?
5. Check for format: prose beats bullets in almost every case at this level

### The completeness check

After each section, return to the original question and verify:
- Every explicit bullet point in the question has a corresponding answer
- The answer addresses both the "what" and the "why"
- No answer is implicit — if it requires inference to find, make it explicit

### Format principles

- Write in prose, not bullets, unless the content is genuinely list-like (e.g. a prioritised table of partner failures)
- Never use horizontal rules, em-dashes as structural elements, or emoji in the deliverable
- One table maximum per section, only when a table communicates more clearly than prose
- Bold sparingly — only for terms that must stand out, not for emphasis in general prose
- Section headers should match the case study's own numbering and naming

---

## Phase 2 — Voice and Tone

The goal is to sound like a Senior PM who has seen this problem before and has an opinion about it — not like someone demonstrating they understood the question.

### Phrases that work at Senior PM level
- "That is not a monitoring failure. It is a posture failure."
- "Detection and resolution are two different problems."
- "This is a rational response to signal quality, not a failure of discipline."
- "The data does not support this conclusion for two independent reasons."

### Patterns to avoid
- Bullet-point reasoning (lists of observations without a throughline)
- Hedging without cause ("it could be argued that…", "one might consider…")
- Excessive attribution ("as the case study describes…", "based on the above context…")
- Happy endings that were not asked for ("we resolved this and have not had a recurrence")
- Tabular formats for qualitative reasoning
- Any phrase that sounds like a consulting deliverable rather than a PM's thinking

### The Senior PM test

Read each paragraph and ask: would a Senior PM say this in a live interview, or does it sound like something generated for a document? If the answer is the latter, rewrite it.

---

## Phase 3 — Data Analysis Methodology

### Pre-analysis checklist

Before drawing any conclusions from a dataset:

1. **Understand what the data represents structurally.** What is a row? What is being counted? What is the unit of analysis?
2. **Check for structural gaps before running aggregations.** Missing fields, null rates, and coverage gaps are findings, not data quality issues to note in a footnote.
3. **Check whether comparisons are apples-to-apples.** If comparing groups (partners, stages, time buckets), verify the groups have the same composition. If they do not, the comparison is misleading.
4. **Separate layers.** If data has multiple distinct populations mixed together (e.g. pre-funnel vs funnel), split them before analysing. Mixing them produces a headline number that misrepresents both.

### The structural gap as a finding

When data has gaps, the first question is not "how do we work around this?" It is: "what does this gap tell us about the system?"

Example from this case study: 73.1% of requests had no endpoint tag. The initial read was "missing data." The correct read was: these requests failed before entering the funnel — the absence of a tag is itself a signal, not a data quality problem.

Always ask: is the gap an instrumentation failure, or is it structurally correct given the system's architecture?

### The rejected insight

Every data analysis must include at least one explicitly rejected conclusion. This is not optional.

The rejected insight must:
- Name something that looked like a finding initially
- Explain precisely why the data does not support it
- Provide at least two independent reasons when possible

This signals analytical honesty and is one of the highest-value sections in a case study.

### Number verification

Every figure in the final response must be verified against the source data. Never carry a number forward from memory.

Run verification as a separate pass after the analysis is complete. Check:
- All percentages are computed correctly (numerator, denominator, rounding)
- All counts are exact
- All comparisons are scoped to the correct subset

---

## Phase 4 — Review Protocol

### Per-section review

After each section is complete:
1. Re-read the original question
2. Check every sub-bullet is answered
3. Remove any sentence that does not add information (does not restate, does not hedge, does not summarise what was already said)
4. Read aloud — if it sounds stiff or corporate, rewrite

### Full-document review

Before finalising:
1. Read the document as a whole. Does it tell a coherent story, or is it a collection of answers?
2. Check for contradictions between sections
3. Check that the voice is consistent throughout
4. Verify that data figures are consistent across sections (the same number should not appear with different values in different places)

### The alignment check

Final question before delivery: does this response answer what was asked, in the way it was asked, at the level of seniority being evaluated?

---

## Phase 5 — Presentation Prototype (optional but high-impact)

When a hiring process allows or encourages going beyond the written submission, build an interactive prototype to present the findings.

### Approach

1. **Scrape the company's brand** using Firecrawl or equivalent. Extract typography, color tokens, spacing, and component styles from their production site.
2. **Build the prototype using those exact tokens.** The presentation should feel native to the company's product language.
3. **Structure the slides as a narrative arc**, not as a list of answers. The story should move from problem to diagnosis to evidence to decision.
4. **Every slide has one job.** If a slide is trying to communicate two things, split it.

### Slide arc for a Technical PM case study

```
Title
Part 1 intro
Experience / personal story
Diagnosis
Strategy / framework
Part 2 intro
Structural finding (data caveats as findings)
Insight 01
Insight 02
Insight 03
Rejected insight
What's missing
Tooling transparency
Closing — actions by timeline
```

### Navigation

Build keyboard navigation (arrow keys) as default. Add buttons as fallback. Include a progress indicator that shows position in the deck without requiring counting.

### Tooling transparency slide

Always include a slide that explains the tooling used — including AI tools — and specifically how they were used. The framing matters:

The correct framing: AI as a thinking partner that accelerates validation and surfaces blind spots. The human forms the read first, challenges the output, and owns the conclusions.

The wrong framing: AI as the source of the analysis.

---

## Reusable patterns from the Groupon case study

### Pattern 1: Posture vs tooling

When a system has monitoring that is not trusted or acted upon, the problem is almost never the tooling. It is the posture. Frame accordingly.

"The core failure wasn't the tooling. It was the posture."

### Pattern 2: Detection vs resolution

Two separate problems that are frequently conflated. Surfacing this distinction is a signal of systems thinking.

"Detection and resolution are two different problems, and we conflated them."

### Pattern 3: Rational response framing

When people are doing something that looks wrong (ignoring alerts, doing manual reviews), resist the temptation to frame it as a failure of discipline. Frame it as a rational response to the system they are operating in.

"That is not a failure of discipline. It is a rational response to signal quality."

### Pattern 4: Structural gap as signal

When data has missing or incomplete fields, ask whether the gap is itself informative before treating it as a data quality problem.

### Pattern 5: Apples-to-apples check

Before any cross-group comparison, verify the groups have the same composition. Different partner sets per funnel stage, different time windows, different error category taxonomies — all of these invalidate naive comparisons.

### Pattern 6: The misleading headline metric

When a headline number (overall error rate, total volume) obscures more than it reveals, name it explicitly and decompose it.

"That number is misleading. Of the X total errors, Y% are a single category."

---

## Anti-patterns to avoid

- Starting with a conclusion and working backwards to support it
- Treating data gaps as data quality problems rather than potential signals
- Using tables for qualitative reasoning
- Including an executive summary that repeats what the body already said
- Framing compliance with constraints as achievement ("we have gone two full seasons without recurrence")
- Alerting on absolute counts without denominators (applies both to the system being analysed and as a meta-principle for the analysis itself)
- Adding emoji or visual formatting elements that make the response look generated

---

## Output checklist

Before delivering any case study response:

- [ ] Every question in the brief has a corresponding answer
- [ ] Every sub-bullet in the brief is addressed
- [ ] All data figures are verified against the source
- [ ] At least one insight is explicitly rejected with two independent reasons
- [ ] The response is written in prose, not bullets (except where a table is genuinely the clearest format)
- [ ] No horizontal rules, em-dashes as structural elements, or emoji in the deliverable
- [ ] The voice reads as Senior PM, not as a generated document
- [ ] The full document has been read as a whole for coherence and consistency
- [ ] If a prototype is included, it uses the company's actual brand tokens

---

## Phase 6 — Verbal Presentation Protocol

This phase bridges the written case study to the live interview. A common failure mode: the written submission is excellent, and the verbal presentation of it is not. They are different skills. The Groupon rejection naming "crisp product storytelling" as the gap — after strong written work — is the clearest evidence that Phase 6 needs to be explicit.

### The transfer problem

Reading your own case study is not the same as presenting it. The written version contains your full reasoning chain. The verbal version must select the one sentence that matters per slide and deliver it as if you've always known it — not as if you're narrating a document you wrote.

Specifically:
- Written: shows reasoning from data to conclusion
- Verbal: leads with conclusion, supports it in 60 seconds or fewer

If you present your verbal version in written order (data → analysis → conclusion), you will lose the panel by slide 3.

### Pre-presentation preparation (required, not optional)

Before any live case study presentation:

1. **Write the one-sentence finding for each slide.** Not a summary. Not a title. The actual finding, in one sentence, in your own words, that you could say to someone who has never seen the data.

2. **Write the one decision each finding informs.** Not the observation — the decision. "This means we should not invest in preReserve as a funnel design problem. We should treat it as a partner integration problem."

3. **Say both sentences out loud, for every slide, before the presentation.** Not silently. Out loud. If you cannot say it smoothly out loud, you do not know it well enough to present it under pressure.

4. **Prepare one number per slide.** Not three numbers. One. The number that makes the finding concrete. Know it without looking at the slide.

### During the presentation

**Lead with finding, not with process.** Every slide opens with the conclusion. The process that produced it comes second, only if asked.

Wrong: "So here I was looking at the partner breakdown, and I noticed..."
Right: "Partner 8 has an 89% error rate at preReserve. That's the highest-volume critical failure in the dataset. Here's what the data shows."

**One idea per minute.** If you are spending more than 60 seconds on a slide, you are narrating instead of presenting. Cut to the finding and move on.

**Invite questions at natural breaks, not at the end.** After Insight 1, after Insight 3, and before the closing. Not "any questions?" — instead: "Does that track with what you're seeing in production?" This converts the presentation into a conversation and signals operational curiosity.

### Handling challenges mid-presentation

When challenged on a finding:

1. Stop presenting. Do not continue narrating while processing a challenge.
2. Acknowledge in one sentence: "That's exactly the tension I was working through."
3. Answer in three sentences maximum.
4. Signal return to the presentation: "Back to the slide" or "Continuing."

If you cannot resolve the challenge in three sentences, it means the finding needs more support — acknowledge this: "That's where I'd want engineering confirmation before acting on it." Then move on. This is stronger than defending an under-evidenced position.

### Handling the AI workflow question

This question will come up in any process where you've used AI tools. It is not a trap — it is a signal check. The interviewer wants to know: does this person understand their own thinking, or did the tool do the thinking?

The correct answer has three parts:
1. **What you formed independently** — before using the tool
2. **What you used the tool for** — specifically (aggregations, validation, presentation, drafting)
3. **Which insight was yours** — name the most consequential finding and say it came from your analysis

Do not be vague. "I used it as a tool, not a crutch" is not an answer. "The pre-funnel structural finding came from my analysis — Claude confirmed it when I asked it to make the case against my hypothesis" is an answer.

### Post-presentation self-assessment

Immediately after the session, record:

- Which slides generated questions (high engagement signals)
- Which slides you overexplained (where you narrated instead of presented)
- Which challenges you handled cleanly
- Which challenges made you lose your thread
- What the one-sentence version of each answer should have been

This feeds back into Phase 0 of the next case study: you now know where your verbal blind spots are.

---

## Integration with pm-interview-communication skill

Phase 6 is the case study–specific layer. The broader verbal communication framework — SCQA structure, English-under-pressure tactics, pushback handling, answer templates by question type — lives in the `pm-interview-communication` skill. Both skills should be loaded when preparing for a live case study presentation.

Use case-study-solver for: written response quality, data methodology, slide arc, content completeness.
Use pm-interview-communication for: how to say it, how to handle pressure, how to answer in English, how to recover when challenged.
