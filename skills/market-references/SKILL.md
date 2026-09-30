---
name: market-references
description: >
  Grounds a design review or redesign in real products instead of invented ideas: finds the
  best apps on the market for the same job, pulls their official App Store screenshots for
  free (Apple's public iTunes API, no account, no Mobbin), lays them out as one contact sheet
  per app, reads them, and maps each pattern to a concrete change in the project — every
  recommendation cites the app it comes from. Use when the user says "no inventes", "mira qué
  hacen otras apps", "referencias del mercado", "the best X app", wants Mobbin-style research
  without paying for Mobbin, or before a design review/redesign of an existing screen where
  the direction should come from proven products. Pairs with `taste-redesign` (craft fixes)
  and feeds `design-lab`/`prototype`; it does not decide the brand — the project's DESIGN.md
  does.
---

# Market References

**The rule: no pattern without a source.** Every recommendation this skill produces names the
real app it comes from and what that app does. If no reference supports an idea, it is either
dropped or explicitly labelled as ours, not the market's.

Why App Store screenshots: they are free, current, official and cover the category leaders.
are.na search needs Premium and Mobbin needs a paid account; this needs neither.

## Method

### 1. Define the job and the screens

Write one line for the job ("the best app for running amateur padel leagues") and list the
screens under review (home, standings, fixtures, match detail, result entry, profile…). The
screen list drives which apps are worth pulling.

### 2. Pick 4–6 apps across four slots

| Slot | What it gives you | Example (league app) |
|---|---|---|
| Category leader | What users of this sport/domain already know | Playtomic |
| Best-in-class adjacent | The best version of each screen, even from another sport | FotMob, Sofascore |
| Platform reference | Native feel and motion for the target OS | Apple Sports |
| Direct niche competitor | Same exact job, often small but specific | Copa Fácil |

Find candidates and their IDs:

```bash
python3 ~/.claude/skills/market-references/scripts/appstore_refs.py search "fotmob" --country es
```

Prefer high rating **and** high rating count; a 5.0★ with 3 ratings proves nothing. Search in
the user's store (`--country es` for Adrian) so screenshots come in their language.

### 3. Pull the contact sheets

```bash
python3 ~/.claude/skills/market-references/scripts/appstore_refs.py sheet 488575683 1176147574 \
  --out <project>/docs/references
```

One `<app>.jpg` per app, screenshots side by side. Add `--ipad` for tablet/desktop layouts
(split views, sidebars) — iPhone shots say nothing about the larger breakpoints. The
`docs/references/` folder in the project keeps them next to the decisions they justify.

### 4. Read every sheet

Open each sheet with the image reader. For each screen under review note what each app does:
layout, hierarchy (what's biggest), density, how state is shown (live/finished/pending), how
the user's own item is marked, navigation between sections, and what's conspicuously absent.

Store screenshots are **marketing hero screens**: curated, often mid-flow, sometimes staged.
They show what a product is proud of, not every state. Say so when a conclusion rests on them,
and flag the gaps (empty/error states, full flows) that would need the real app or user
screenshots.

### 5. Synthesize per screen, pattern → source → change

For each screen: the pattern most references share (or the best single one), who does it, and
the concrete change in the project. Lead with **consensus** patterns (3+ apps do it — that's a
convention users expect), then **best single** ideas (one app does it clearly better).

```markdown
## 1. Match card — wrong shape
**All four** (Apple Sports, FotMob, Copa Fácil, Sofascore) draw a match as a horizontal
scoreboard: home left, score/time big in the centre, away right. We stack it like a form.
→ Change: `Luna / Ortega  2 – 1  Molina / Castro`; set breakdown moves to the detail view.
```

Keep brand identity out of it: references decide **structure and behaviour** (layout,
hierarchy, flows, states). Colour, type and shape stay with the project's `DESIGN.md` — never
copy another product's look.

### 6. Deliver

- Send the sheets to the user (they should see the evidence, not just the summary).
- The review in chat: numbered by screen, each item with its source apps, ending with the
  proposed order of implementation — one change at a time, verified before the next.
- Don't implement before the user agrees with the direction.

## Gotchas

- `search` matches store names loosely — check the name before trusting an ID.
- Some apps ship few or no iPad screenshots; fall back to their website or to iPhone shots.
- The iTunes API is unauthenticated and rate-limited; a handful of apps per run is fine.
- Screenshot text is in the store's language; keep `--country` consistent across apps.
