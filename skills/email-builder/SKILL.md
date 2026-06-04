---
name: email-builder
description: Builds complete bilingual email drafts from intent and audience. Use when the user asks to write, rewrite, localize, polish, or generate an email, campaign email, outreach message, customer update, follow-up, announcement, invite, sales email, internal note, or lifecycle email and wants clear subject lines, preheaders, body copy, CTAs, variants, or English and Spanish versions.
---

# Email Builder

Build complete emails from two core inputs and always answer in two languages:
1. English
2. Spanish

## Inputs

Use these inputs when provided:
- Intent: what message to convey.
- Audience: who will receive it, including role, relationship, region, language, and expected level of formality.

If details are missing, infer a sensible first pass from context. Ask at most one quick question only when the missing detail would materially change the email, such as the audience, call to action, or sensitive context.

## Output Structure

Always produce the English version first, then the Spanish version. For each language include:
- 3 subject lines.
- 1-2 preheaders.
- Body with greeting, hook, value, proof, and CTA.
- Primary CTA, plus an optional secondary CTA when useful.
- Short and long variants when the context benefits from length options.
- Safe placeholders such as `{{FirstName}}`, `{{Company}}`, `{{Date}}`, `{{Link}}`, or `{{Metric}}` when details are missing.

Keep formatting easy to scan. Use short paragraphs and minimal bullets.

## Writing Style

Write in a close, clean, professional style. Be natural, clear, and direct. Avoid sounding corporate, artificial, grandiose, or overly formal.

Prioritize:
- Clarity over cleverness.
- Benefit-led framing over feature dumps.
- Specificity over vague claims.
- Natural flow over rigid templates.
- A human, credible voice over generic marketing copy.

Localize tone to the audience. Default Spanish to neutral international Spanish unless the audience region calls for a different register.

## Personal Voice Profile

When the user asks for the email in Adrian's style, my style, or gives no competing tone instruction, use this voice profile by default.

Core voice:
- Close, clear, direct, and professional.
- Practical PM tone: give context quickly, explain the issue or opportunity, propose a path, and close with a concrete ask.
- Friendly without being casual to the point of losing precision.
- Natural Spanish business tone with the informal second person by default, not stiff formal language.
- Concise English for international work contexts: context, issue, ask.

Default structure:
1. Simple greeting: `Hola {{FirstName}}` or `Hi {{FirstName}}`.
2. Short context: `Te escribo por...`, `Tras revisarlo con el equipo...`, `Comparto...`, or `We are seeing...`.
3. Clear explanation of the problem, doubt, or proposal.
4. Recommendation or next step, framed collaboratively.
5. Concrete CTA.
6. Warm close when appropriate: `Thanks!` plus an optional football emoji in close professional contexts.

Preferred phrasing patterns:
- `Te escribo por...`
- `Tras revisarlo con el equipo...`
- `Creemos que...`
- `Nuestra propuesta...`
- `Ya me dices`
- `Si necesitas que nos juntemos 10 mins me dices por supuesto`
- `Can you review it please?`

Formatting habits:
- Use short paragraphs.
- Use bold section headers for complex messages, such as `Feedback principal`, `Nuestra propuesta`, or `En resumen`.
- Use bullets only when they make a decision, list of concerns, or recommendation easier to scan.
- Keep the ask near the end and make it easy to answer.

Avoid:
- Corporate filler, grand claims, or theatrical persuasion.
- Over-polished marketing language.
- Excessive courtesy.
- Literal translation when a localized version would sound more natural.
- Forcing the warm close in legal, HR, finance, conflict, or highly formal contexts.

## Editorial Rules

- Never invent facts, numbers, customer names, testimonials, dates, links, guarantees, or case studies.
- Mark unknown details clearly with placeholders.
- Do not overstate proof. If evidence is missing, write proof as a placeholder or soften the claim.
- Use a minimal confidentiality footer only for sensitive contexts, such as legal, HR, finance, partnership negotiations, or private internal updates.
- Avoid sensitive personal data unless the user provides it and it is necessary for the email.
- Do not provide legal or medical advice.
- Keep respectful, non-discriminatory language.

## Workflow

1. Identify intent, audience, desired action, tone, and risk level.
2. Draft a complete first pass even if some details are missing.
3. Use placeholders for missing details instead of fabricating.
4. Match the CTA to the intent and audience.
5. End with 2-3 quick knobs the user can choose from, such as tone, length, CTA strength, formality, or Spanish regional flavor.

## CTA Guidance

Choose one clear primary CTA:
- Book a meeting.
- Reply with a decision or preference.
- Review a link.
- Confirm attendance.
- Start a trial.
- Download, read, or share a resource.
- Approve, reject, or unblock a next step.

Add a secondary CTA only if it reduces friction, such as "Reply with any questions" or "Forward this to the right person."

## Quality Check

Before answering, verify:
- English appears before Spanish.
- Both versions cover the same meaning without becoming literal translations when localization would read better.
- Subject lines and preheaders do not repeat each other.
- The body has greeting, hook, value, proof, and CTA.
- Placeholders are safe and explicit.
- Tone fits the audience and context.
- No unsupported fact has been introduced.
