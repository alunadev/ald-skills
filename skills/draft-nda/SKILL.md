---
name: draft-nda
description: "Drafts a Non-Disclosure Agreement covering parties, information types, duration, jurisdiction, and key clauses needing legal review. Use when starting work with contractors, freelancers, or partners. Triggers on: NDA, non-disclosure agreement, confidentiality agreement, contractor agreement, partnership NDA, freelancer agreement."
---

# Draft NDA

## Important Disclaimer

This skill produces a draft for review purposes only — not legal advice. Have a licensed attorney review before any party signs. NDAs are legally binding contracts.

## Core Philosophy

A first-draft NDA exists to clarify intent and start the conversation with counsel — not to replace legal review. Write it clearly, flag what needs customization, and get it reviewed quickly. Speed matters when contractors are waiting.

## When to Use

- Before sharing confidential product information with a freelancer or contractor
- When starting a partnership with a company that requires mutual confidentiality
- When an external advisor needs access to internal strategy

## What to Clarify Before Drafting

1. **One-way or mutual?** One-way: only one party shares confidential info. Mutual: both parties share.
2. **What types of information?** Be specific: source code, business plans, pricing, customer lists, financial data.
3. **Jurisdiction?** Which country/state's laws govern the agreement.
4. **Duration?** How long are confidentiality obligations in force after the relationship ends (typically 2-5 years; trade secrets may be indefinite).

## Workflow

### 1. Gather Inputs

Collect: party names and addresses, types of confidential information, jurisdiction, intended duration, one-way or mutual.

### 2. Draft the Core Sections

**Preamble**: Parties, effective date, purpose of the relationship.

**Definitions — Confidential Information**
List what is confidential (use the specific types provided) and what is excluded:
- Information already public at the time of disclosure
- Information independently developed by the receiving party
- Information received from a third party without confidentiality obligations

**Obligations**
- Receiving party must keep information confidential with the same care they use for their own confidential information (no less than reasonable care)
- Permitted uses: only for the stated business purpose
- Permitted disclosures: to employees/advisors with a need to know, who are bound by equivalent confidentiality

**Exceptions (legally required disclosure)**
If compelled by law or court order, receiving party must provide prompt written notice to allow the disclosing party to seek a protective order.

**Term and Duration**
State the duration of confidentiality obligations. Note: trade secrets may require indefinite protection — flag this for legal review. ⚠️ *Legal review required.*

**Return or Destruction of Information**
Upon request or termination: return or certify destruction of all confidential materials.

**Remedies**
Breach may cause irreparable harm entitling the disclosing party to injunctive relief in addition to other remedies. ⚠️ *Legal review required — jurisdiction-specific.*

**General Provisions**
- Governing law and jurisdiction ⚠️ *Legal review required.*
- Severability
- Entire agreement clause
- Amendments in writing only

### 3. Flag Clauses Needing Legal Review

Mark every section with ⚠️ that requires jurisdiction-specific language or where parties must make explicit decisions (duration, remedy language, dispute resolution).

### 4. Produce the Draft

Output the full NDA document in three parts: summary, full document, customization notes.

## Output Format

```
## NDA Draft — [Party A] / [Party B]

### Summary
- Type: [One-way / Mutual]
- Parties: [A] and [B]
- Information covered: [list]
- Duration: [X years post-relationship]
- Jurisdiction: [State/Country]

### Full Agreement
[Complete NDA text with ⚠️ markers on clauses needing legal review]

### Customization Notes
- [Clause X]: [Why it needs legal review / what decision is needed]
- Next step: Legal review before signing
```

## Antipatterns

- **Skipping legal review**: Even a well-structured template needs attorney review for enforceability in your specific jurisdiction.
- **Vague information types**: "Business information" is too broad to be enforceable. Specify what's actually confidential.
- **Forgetting the exclusions**: An NDA without clear exclusions (public info, independently developed) creates disputes later.
- **Indefinite duration without trade secret justification**: Courts may not enforce overly long confidentiality periods for non-trade-secret information.
