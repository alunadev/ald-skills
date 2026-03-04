---
name: feature-to-launch
description: End-to-end workflow from approved PRD to public launch. Chains full-stack-build → changelog-generator → product-launch with explicit readiness gates. Use when a PRD is approved and you're ready to execute the complete build + launch cycle. Triggers on: /feature-launch, "build and launch this feature", "take this PRD to launch", "ship this feature". Prevents shipping without monitoring and launching without a changelog.
---

# Feature to Launch Workflow

Takes an approved PRD through implementation, changelog, and public launch. This workflow runs after `idea-to-prd` — it assumes a PRD with defined success metrics already exists.

## Skill Chain

```
[PRD exists with Success Metrics]
    ↓ [Gate 1: PRD complete]
full-stack-build
    ↓ [Gate 2: Feature deployed + monitoring active]
changelog-generator
    ↓ [Gate 3: Technical + Product readiness complete]
product-launch
    ↓
→ T+7 and T+30 post-launch review
```

---

## Pre-condition — PRD Review

Before loading any skill, verify the PRD is ready:

```
docs/prd/YYYY-MM-DD-[feature].md must contain:
✓ Problem Statement with target user
✓ Success Metrics (at least 1 with target value and measurement method)
✓ Solution Overview (approved design)
✓ Scope: In / Out of scope
✓ Rollout plan (percentage or feature flag)
```

If any section is missing, use `prd-writer` to complete it before proceeding. A PRD without success metrics means you can't tell if the launch worked.

**Gate 1:** All five PRD sections above are present and complete.

---

## Step 1 — Build the Feature

Load workflow: `full-stack-build`

Execute the full build cycle: API design → DB schema → frontend → deploy.

**Read from PRD:**
- Feature scope (one-sentence description)
- API surface (endpoints or server actions needed)
- Data model (tables and relationships)
- Frontend behavior (components, loading/error states)

**The full-stack-build workflow produces:**
- `docs/features/YYYY-MM-DD-[feature]/api.md`
- `docs/features/YYYY-MM-DD-[feature]/schema.md`
- `docs/features/YYYY-MM-DD-[feature]/implementation-notes.md`
- Deployed code on Vercel

**Gate 2:** Two conditions must both be true before proceeding:
1. Feature is live on production (not just staging)
2. Error monitoring is capturing errors in the new code paths (verify in dashboard)

Do not write the changelog while the feature is still in development — changelog describes what actually shipped, not what was planned.

---

## Step 2 — Write the Changelog

Load skill: `changelog-generator`

Transform what was actually built into user-facing release notes.

**Input:** Git commits since the last release + the implementation notes from Step 1.

**Changelog rules:**
- Describe benefits, not implementation details ("Users can now export to CSV" not "Added /api/export endpoint")
- Include every user-facing change — even small ones
- Exclude: refactoring, test changes, CI/CD updates, internal tooling
- Format by category: ✨ New Features · 🔧 Improvements · 🐛 Fixes · 💥 Breaking Changes

**Output:** Markdown changelog ready to be published (embedded in the launch doc or separate)

---

## Step 3 — Plan and Execute the Launch

Load skill: `product-launch`

Coordinate the technical, product, and marketing readiness for going public.

**Readiness checklists (all must pass before Gate 3):**

**Technical:**
- [ ] Error rate stable (no spike in the 24h after deploy)
- [ ] Rollback procedure documented and tested
- [ ] Feature flag controls rollout percentage (if applicable)

**Product:**
- [ ] Empty states guide new users toward first action
- [ ] Error messages are clear and actionable
- [ ] Help doc exists if anything is non-obvious

**Marketing:**
- [ ] GTM brief written (positioning sentence + core message + channels)
- [ ] Announcement copy drafted (adapted per channel)
- [ ] Visual assets ready (screenshot, demo GIF, or short video)

**Gate 3:** All three readiness checklists above are complete. External communication goes out only after monitoring is in place — finding out about bugs from user tweets instead of your dashboard is avoidable.

**Rollout:**
```
Soft launch (5%) → 24-48h → Controlled (25%) → 3-5 days → Full (100%)
```

**Post-launch review dates:** Schedule T+7 and T+30 reviews at launch time, not after.

---

## Output Artifacts

```
docs/features/YYYY-MM-DD-[feature]/
├── api.md                     (full-stack-build Step 1)
├── schema.md                  (full-stack-build Step 1)
└── implementation-notes.md    (full-stack-build Step 1)

docs/launches/YYYY-MM-DD-[feature]-launch.md
├── GTM Brief
├── Technical + Product + Marketing readiness checklists
├── Rollout gate log
└── Post-launch review (T+7, T+30) — filled after launch
```

## Gates Summary

| Gate | Condition to pass |
|------|-------------------|
| Pre-condition | PRD has all 5 required sections |
| Gate 1 → Build | PRD complete and reviewed |
| Gate 2 → Changelog | Feature live on production + monitoring active |
| Gate 3 → Launch | All three readiness checklists complete |

## Common Antipatterns

- **Skipping Gate 2 (writing changelog before deploy)** — Changelogs written from plans describe intent, not reality. Write the changelog after the feature is live.
- **No rollback plan** — "We'll figure it out if something breaks" is not a rollback plan. Document the exact steps before go-live.
- **Announcing before monitoring** — The first 24h of a launch surfaces real-world bugs. Monitoring first, then announcement.
- **No T+30 review** — T+7 tells you if the launch was smooth. T+30 tells you if the feature is valuable. Both are required.

## See Also

- `idea-to-prd` — The workflow that precedes this one (idea → design → PRD)
- `full-stack-build` — The build workflow used in Step 1
- `changelog-generator` — For standalone changelog generation
- `product-launch` — For standalone launch planning
- `product-analytics` — For post-launch impact analysis at T+7 and T+30
