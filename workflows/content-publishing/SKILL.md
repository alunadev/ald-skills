---
name: content-publishing
description: End-to-end content workflow from raw idea to published post across platforms. Chains writing-system (idea capture → draft → edit) with platform-specific publishing for X/Twitter, LinkedIn, blog, and newsletter. Use when you have a content idea and want to take it from capture to publication without skipping the edit pass. Triggers on: /publish, "write and publish this", "turn this into content", "draft a post about", "content workflow".
---

# Content Publishing Workflow

Takes a raw idea or insight through capture, drafting, editing, and platform-specific publishing — including real publishing to LinkedIn and X via the Zernio CLI, once you explicitly approve the final text. This workflow enforces the three gates that most content processes skip: idea capture as a note (not drafting from memory), the edit pass before publishing, and an explicit yes before anything goes live.

## Skill Chain

```
[Raw idea or insight]
    ↓ [Gate 1: Atomic note captured]
writing-system (draft by platform)
    ↓ [Gate 2: Edit pass complete]
platform publishing
    ↓ [Gate 3: Final text shown, explicit approval received]
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

### X/Twitter and LinkedIn — draft together, publish together

Draft both in the same pass, not one platform then the other later:

- **X**: `x-thread-writer` — owns thread structure and the voice rules. First tweet goes live
  first — verify it carries the full value of the thread standalone (it will be seen without
  context by most readers).
- **LinkedIn**: `linkedin-post-writer` — owns post structure (Nota vs. Insight Post) and the
  voice rules. Check the edited draft against its voice checklist.

**Gate 3 — explicit publish confirmation (mandatory, no exceptions):** once both drafts pass
their voice checklists, show the exact final text for each platform, formatted exactly as it
will post (tweet-by-tweet for X, the full post for LinkedIn). Then stop and wait. Do not call
a real publish command until the user replies with explicit approval — "looks good," "yes,"
"publish it," or equivalent. A revision request is not approval; re-show the updated text and
wait again. Silent auto-publish is never acceptable here, regardless of how confident the
draft is.

**Publish via the Zernio CLI**, once approved:

```bash
zernio posts:create \
  --text "<final approved text>" \
  --accounts <linkedin_account_id>,<x_account_id>
```

One call posts to both platforms at once — that's the point of drafting them together. For an
X thread (multiple tweets), check `zernio posts:create --help` for the current thread-content
flag (the CLI's own help is the source of truth here, not this doc, since command surfaces
change) — the tweets should post in order as one Gate-3-approved unit, not one at a time
re-confirmed per tweet.

**Setup (one-time, per machine):**

```bash
npm install -g @zernio/cli
zernio auth:login          # opens a browser, saves a key to ~/.zernio/config.json
zernio auth:check          # confirms it worked
zernio accounts:list       # find the LinkedIn and X account IDs for --accounts above
```

Alternatively, set `ZERNIO_API_KEY` as a local environment variable (get the key from the
Zernio dashboard) — it overrides the config file and works well for non-interactive/CI use.
**Never commit a real API key or account ID to `ald-skills` — this repo is public.** The key
lives only in `~/.zernio/config.json` or the shell environment on Adrian's own machine; this
file documents how to set it up, not what the value is.

**No Zernio account configured yet?** Fall back to the manual flow: paste the X thread
tweet-by-tweet, and post the LinkedIn draft by hand. The Gate 3 confirmation step still
applies — showing the final text and getting a yes before you post it, manually or not, is the
actual requirement; Zernio just removes the copy-paste step once it's set up.

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
| Gate 3 | Final text shown exactly as it will post, explicit user approval received — before any real publish call (X and LinkedIn) |

## Common Antipatterns

- **Drafting from memory** — Specific evidence beats polished prose every time. Capture first.
- **Publishing before editing** — The first draft is never the best version. Cut pass is non-negotiable.
- **Multiple CTAs** — "Follow me, repost this, reply below, read my newsletter" = no clicks. One ask only.
- **Skipping the 30-day review** — You can't improve a process you don't measure. Schedule it at publication time.
- **Auto-publishing without Gate 3** — even a great draft doesn't get posted silently. Show the exact final text and wait for an explicit yes, every time, no exceptions for "obviously fine" posts.
- **A real API key anywhere in `ald-skills`** — this repo is public. Credentials live only in `~/.zernio/config.json` or a local env var on Adrian's machine.

## See Also

- `writing-system` — The underlying writing skill this workflow orchestrates
- `linkedin-post-writer` — For LinkedIn drafting specifically
- `x-thread-writer` — For X/Twitter drafting specifically
- `product-launch` — When the content is a launch announcement (use alongside this workflow)
