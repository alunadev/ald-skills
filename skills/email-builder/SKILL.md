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
- Body with greeting, hook, value, proof, and CTA (full drafts only; see below).
- Primary CTA when the email has an ask, plus an optional secondary CTA when useful.
- Short and long variants when the context benefits from length options.
- Safe placeholders such as `{{FirstName}}`, `{{Company}}`, `{{Date}}`, `{{Link}}`, or `{{Metric}}` when details are missing.

Short replies and confirmations do not need the full structure above: no subject-line or preheader sets, no hook/value/proof, and no CTA. Include a CTA only when there is an ask. The user's personal voice guide and any specific instructions take precedence over this structure.

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

## Before Drafting: The User's Own Voice

If the user's instructions (`CLAUDE.md`, `AGENTS.md`) point to a personal voice or
writing guide, read it **before the first draft**. Its email-specific file or section
and its confirmed examples decide greeting, closing, length, language and level of
formality. Without that guide, drafts come out correct but generic, and the user
ends up rewriting them to add the lived detail.

Precedence: when the user's personal guide conflicts with the generic rules in this
skill (structure, language, formality, CTA, length), the personal guide wins. The
generic rules are the fallback for users without a personal guide.

Keep the user's private voice data out of this public skill: reference the guide,
never copy its contents here.

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

A CTA exists only when the email has an ask. Short replies and confirmations get no
CTA at all; if a personal voice guide applies, its length and closing rules decide.

When there is an ask, choose one clear primary CTA:
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
- A full draft has greeting, hook, value, proof, and CTA; short replies and confirmations follow the personal guide (or common sense) instead.
- Placeholders are safe and explicit.
- Tone fits the audience and context.
- No unsupported fact has been introduced.
