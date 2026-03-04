---
name: content-publishing
description: End-to-end content workflow from raw idea to published post across platforms. Chains writing-system (idea capture → draft → edit) with platform-specific publishing for X/Twitter, LinkedIn, blog, and newsletter. Use when you have a content idea and want to take it from capture to publication without skipping the edit pass. Triggers on: /publish, "write and publish this", "turn this into content", "draft a post about", "content workflow".
---

# Content Publishing Workflow

Takes a raw idea or insight through capture, drafting, editing, and platform-specific publishing. This workflow enforces the two gates that most content processes skip: idea capture as a note (not drafting from memory) and the edit pass before publishing.

## Skill Chain

```
[Raw idea or insight]
    ↓ [Gate 1: Atomic note captured]
writing-system (draft by platform)
    ↓ [Gate 2: Edit pass complete]
platform publishing
    ↓
→ Performance review at 30 days
```

---

## Step 1 — Capture the Idea

Before drafting anything, write the atomic note. This is mandatory — ideas drafted from memory are generic; ideas drafted from captured evidence are specific.

**Atomic note format:**
```
Insight: [one sentence — what did you learn, build, or decide?]
Context: [why this came up — the situation that generated the insight]
Evidence: [the specific thing — metric, code, conversation, result]
```

**Gate 1:** The atomic note must exist and have all three fields before drafting. If you can't fill in the Evidence field, the idea is not specific enough to publish. Find the specific example first.

---

## Step 2 — Select Platform and Draft

Load skill: `writing-system`

Match the idea to the platform where that format works:

| Format | Select when |
|--------|------------|
| X/Twitter thread | Numbered list, quick insight, hot take |
| LinkedIn | Professional lesson, career story, thought leadership |
| Blog | Tutorial, deep dive, architectural decision record |
| Newsletter | Curated + original content, regular audience update |

Draft using the platform-specific structure from `writing-system`:

**X/Twitter thread:**
```
Tweet 1: Full value in one tweet (the hook IS the content)
Tweet 2-5: One insight per tweet, max 25 words, numbered "2/"
Last tweet: Callback + single CTA
```

**LinkedIn:**
```
Line 1: Hook (visible before "see more")
[blank line]
Lines 2-6: Context and insight
Lines 7-10: Takeaway
Last line: One question (not a follow request)
```

**Blog:**
```
Intro: Problem statement (150-200 words)
Section 1-3: One insight + one concrete example each
Conclusion: What changed + single CTA
Target: 1200-2000 words
```

**Newsletter:**
```
Subject: Number or question format
Preview text: Different from subject (add context)
Body: 300-600 words, one main idea
CTA: One link at the bottom
```

---

## Step 3 — Edit Pass

This step is mandatory. Do not skip it to save time — unedited drafts lose readers in the first paragraph.

**4-step edit checklist:**
1. **Cut 30%** — delete every sentence that doesn't move the idea forward
2. **Replace vague with specific** — "significantly improved" → "reduced by 40%"
3. **One concrete example** — if there isn't one already, add it
4. **Read aloud** — if you stumble, the reader will too

**Gate 2:** All 4 edit steps complete. Publishing happens only after the edit pass.

---

## Step 4 — Platform Publishing

### X/Twitter

Paste tweet by tweet. First tweet goes live first — verify it carries the full value of the thread standalone (it will be seen without context by most readers).

### LinkedIn

Use `linkedin-viral-post-writer` for additional optimization if needed. Load it with your edited draft to:
- Generate 3-5 hook variants
- Check content type (ToF/MoF/BoF)
- Verify emotional + informational value balance

### Blog

Save to `docs/content/YYYY-MM-DD-[topic].md`. Add front matter:
```markdown
---
title: [Post title]
date: YYYY-MM-DD
status: ready
platform: blog
---
```

### Newsletter

Subject line is 80% of the open rate — spend 20% of total writing time on it. Write 3 subject variants and pick the strongest before sending.

---

## Step 5 — Performance Review (30 days)

Schedule a review at publication time:
- What was the engagement metric? (views, clicks, saves, replies)
- Was the format right for the platform?
- What would you write differently now?
- Replicate the **pattern** (format, structure, specificity level) — not the content topic

Record in `docs/content/YYYY-MM-DD-content-notes.md`

---

## Output Artifacts

```
docs/content/YYYY-MM-DD-content-notes.md
├── Atomic note (Step 1)
├── Platform selection rationale
├── Published draft (post-edit)
└── Performance notes (30-day review)
```

## Gates Summary

| Gate | Condition to pass |
|------|-------------------|
| Gate 1 | Atomic note with Insight + Context + Evidence written |
| Gate 2 | All 4 edit steps complete |

## Common Antipatterns

- **Drafting from memory** — Specific evidence beats polished prose every time. Capture first.
- **Publishing before editing** — The first draft is never the best version. Cut pass is non-negotiable.
- **Multiple CTAs** — "Follow me, repost this, reply below, read my newsletter" = no clicks. One ask only.
- **Skipping the 30-day review** — You can't improve a process you don't measure. Schedule it at publication time.

## See Also

- `writing-system` — The underlying writing skill this workflow orchestrates
- `linkedin-viral-post-writer` — For optimizing LinkedIn posts specifically
- `product-launch` — When the content is a launch announcement (use alongside this workflow)
