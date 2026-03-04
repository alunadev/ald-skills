---
name: planning-product-launch
description: Creates go-to-market plans and launch checklists for features and side projects. Use when preparing a feature for public release, planning a Product Hunt launch, defining a rollout strategy, creating a post-launch review framework, or coordinating the technical, product, and marketing work for a launch. Triggers on: "prepare launch", "go-to-market", "Product Hunt", "launch checklist", "rollout plan", "launch this feature".
---

# Planning Product Launch

## Core Philosophy

Launch is a process, not an event. Most launches fail not because the product is bad, but because the preparation was incomplete — monitoring wasn't in place, the rollback plan wasn't tested, or the messaging was unclear.

Every launch is a rehearsal for the next one. Document what happened and why so the process improves each time.

---

## Workflow

### Step 1 — GTM Brief

Define the narrative before any tactical work:

```
Feature: [Name]
Positioning sentence: For [audience], [feature] is a [category] that [key benefit], unlike [alternative].
Target audience: [specific segment — not "everyone"]
Core message: [one thing you want people to remember]
Key channels: [where this audience actually is]
Launch date: [date]
Success metric: [number that changes in 7 days if launch works]
```

The positioning sentence forces you to make choices. If you can't complete it, the feature scope is unclear and launch should wait.

Output: Top of `docs/launches/YYYY-MM-DD-[feature]-launch.md`

---

### Step 2 — Technical Readiness Checklist

Verify before any external communication goes out:

**Monitoring**
- [ ] Error rates visible in dashboard (Sentry, Vercel logs, or equivalent)
- [ ] Key metric tracked (primary action event fires correctly)
- [ ] Alerts configured for error rate spike > threshold

**Rollback**
- [ ] Rollback procedure documented (how to revert in <10 minutes)
- [ ] Feature flag in place if gradual rollout (env var or flags service)
- [ ] DB migrations are reversible (tested with `down` migration)

**Performance**
- [ ] Page load time tested on production (not dev server)
- [ ] API endpoints respond < 500ms under normal load
- [ ] No N+1 queries in the happy path (check with EXPLAIN ANALYZE if needed)

**Security**
- [ ] Auth flows tested (unauthenticated access properly blocked)
- [ ] RLS policies verified (users can't access each other's data)
- [ ] No sensitive data in client-visible responses

---

### Step 3 — Product Readiness Checklist

**Documentation**
- [ ] Feature described in changelog / release notes
- [ ] Help doc or tooltip for anything non-obvious
- [ ] Error messages are clear and actionable (not "Something went wrong")

**Support**
- [ ] You know how to reproduce reported issues
- [ ] Support response template ready for common failure modes

**Onboarding**
- [ ] Empty state guides new users toward the first action
- [ ] First-run experience works (tested fresh account)

---

### Step 4 — Marketing Checklist

Scale to what makes sense for the launch size. A small feature update needs steps 1-2; a major launch needs all of them.

1. **Announcement copy** — headline, body, CTA. One message, one CTA. Adapt length per channel.
2. **Visual assets** — screenshot, demo GIF, or short video (≤60 seconds)
3. **Channel execution:**
   - X/Twitter: thread or single tweet
   - LinkedIn: post with first paragraph carrying full weight (it gets truncated)
   - Newsletter: subject with number or question, single CTA
   - Product Hunt: tagline (<60 chars), first comment with story, hunter lined up
4. **Timing:** Post when your audience is online. Check your analytics for peak engagement time.

---

### Step 5 — Rollout Gates

Use progressive rollout when the feature affects data writes, payments, or user auth:

| Stage | Audience | Duration | Gate to next |
|-------|----------|----------|--------------|
| Soft launch | Internal / 5% | 24-48h | Error rate stable, no critical bugs |
| Controlled | 25% | 3-5 days | Key metric moving in right direction |
| Full | 100% | — | Post-launch review scheduled |

For small features (UI-only, no data changes): skip to full launch directly.

---

### Step 6 — Post-Launch Review

**T+7 days — What happened?**
- What was the error rate in the first 24h?
- What did the first user reports say?
- Did the key metric move as expected?
- What would you do differently with the preparation?

**T+30 days — Did it work?**
- Did the success metric reach the target?
- What is the retention rate of users who tried the feature?
- Is there follow-up work (bug fixes, improvements) that came out of launch?
- What's the next iteration based on data?

Output: Append results to `docs/launches/YYYY-MM-DD-[feature]-launch.md`

---

## Output Artifacts

```
docs/launches/YYYY-MM-DD-[feature]-launch.md
├── GTM Brief
├── Technical Readiness Checklist (with checkmarks)
├── Product Readiness Checklist
├── Marketing Checklist + copy drafts
├── Rollout Gate log
└── Post-Launch Review (T+7, T+30)
```

## Quality Checklist

- [ ] Positioning sentence completed (not skipped)
- [ ] Success metric defined before launch (not "we'll see what happens")
- [ ] Rollback procedure documented and tested
- [ ] Error monitoring active before external announcement
- [ ] Post-launch review date in calendar

## Common Antipatterns

- **Announcing before monitoring is in place** — You find out about the bug from a user tweet, not your dashboard. Monitoring first, then announcement.
- **"Success" undefined** — If you don't define success before launch, you can't tell if it worked. Define the metric in Step 1.
- **Marketing copy written after technical work** — The best launches start with the announcement draft. If you can't write it clearly, the feature isn't ready.
- **Skipping T+30 review** — T+7 tells you if the launch went smoothly; T+30 tells you if the feature is valuable. Both are required.

## See Also

- `building-fullstack-features` — For the technical implementation before launch
- `product-strategy` — For positioning this launch within broader strategy
- `product-analytics` — For defining success metrics and post-launch analysis
