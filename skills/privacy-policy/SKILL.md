---
name: privacy-policy
description: "Drafts a privacy policy covering data types collected, user rights, jurisdiction-specific requirements (GDPR, CCPA), and compliance considerations, with clauses marked for legal review. Use when launching an app or preparing for data compliance. Triggers on: privacy policy, GDPR, CCPA, data protection, data privacy, user data, cookie policy, compliance, data collection."
---

# Privacy Policy

## Important Disclaimer

This skill produces a draft for review purposes only — not legal advice. Have a qualified data privacy attorney review before publishing. Privacy policies are legally binding and must match your actual data practices.

## Core Philosophy

A privacy policy is a promise to your users about how you handle their data. Write it in plain language — users should be able to understand it. Vague, lawyer-speak policies erode trust and often don't protect you legally anyway.

The policy must match what the product actually does. If reality and policy diverge, the policy is the liability.

## When to Use

- Before launching any product that collects user data (including just an email address)
- When updating an existing policy after adding new data collection or third-party integrations
- When preparing for GDPR or CCPA compliance requirements
- When an investor, app store, or enterprise customer requests a privacy policy

## What to Clarify Before Drafting

1. **What data do you actually collect?** Direct (name, email, preferences) + automatic (IP, usage behavior, device info) + third-party (analytics, payment processors)
2. **Who are your users?** EU users → GDPR applies. California users → CCPA applies. Children under 13 → COPPA applies.
3. **What third parties receive the data?** Analytics tools, payment processors, hosting providers, CDNs
4. **How long do you retain data?**

## Core Sections to Include

### 1. What We Collect
- Direct collection: what users enter (name, email, profile data)
- Automatic collection: tracking (IP, device, usage events, cookies)
- Third-party sources: data from integrations or partners
- Special categories ⚠️: health, financial, biometric, children's data require explicit legal handling

### 2. How We Use It
Be specific. Not "to improve our service" — say exactly what: personalization, analytics, fraud detection, transactional email, marketing (with opt-out).

### 3. Legal Basis for Processing *(GDPR required)*
For each purpose: consent / contract / legal obligation / legitimate interest. ⚠️ *Legal review required.*

### 4. Who We Share It With
- Service providers (list categories: hosting, analytics, payments)
- Business partners (if any)
- Legal authorities (if compelled by law)
- Location of third parties, especially if outside the EU ⚠️

### 5. User Rights
Vary by jurisdiction ⚠️. GDPR: access, deletion, correction, portability, restriction. CCPA: know, delete, opt-out of sale. Include how users exercise these rights (contact email + response timeframe).

### 6. Data Retention
How long each category is retained. Be specific — not "as long as necessary." ⚠️ *Legal review required.*

### 7. Cookies and Tracking
What cookies and tools are used, why, and how to manage them. ⚠️ GDPR requires explicit consent for non-essential cookies.

### 8. Security
Encryption in transit and at rest, access controls, incident response. Include the caveat that no system is 100% secure.

### 9. Children's Privacy
If the product could be used by under-13s: age verification, parental consent, COPPA compliance ⚠️.

### 10. Policy Updates
How users will be notified (email + in-app), notice period (typically 30 days for material changes).

### 11. Contact
Privacy contact email, mailing address, response timeframe for data requests.

## Output Format

```
## Privacy Policy — [Product Name]

### Summary
- Product: [Name and purpose]
- Data collected: [List]
- Jurisdiction: [GDPR / CCPA / Other]
- Key user rights: [List]
- Retention: [Periods by category]
- Contact: [privacy@domain.com]

### Full Privacy Policy
[Complete policy text with ⚠️ markers on clauses requiring legal review]

### Compliance Checklist
- [ ] Legal basis documented for each processing purpose (GDPR)
- [ ] User rights request process implemented
- [ ] DPA signed with all third-party processors
- [ ] Cookie consent mechanism in place (if GDPR)
- [ ] Policy reviewed by data privacy attorney
- [ ] Policy matches actual data practices
```

## Antipatterns

- **Copying another app's policy verbatim**: Their data practices are not your data practices. A mismatched policy is a liability.
- **Vague language**: "We may share your data with partners" needs to specify: what partners, what data, what purpose.
- **No user rights process**: Publishing GDPR rights without a process to honor them exposes you to regulatory fines.
- **Publishing before legal review**: Especially for EU/California users, jurisdiction-specific requirements are non-trivial. Get the review.
- **Set and forget**: Update the policy whenever you add new data collection, third-party integrations, or change data practices.
