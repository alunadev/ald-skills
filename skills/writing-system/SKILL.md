---
name: using-writing-system
description: Personal writing system for technical blogs, newsletters, X/Twitter threads, and LinkedIn posts. Use when writing long-form content, drafting social media posts, preparing newsletters, building a content calendar, repurposing existing content across platforms, or turning a technical insight into publishable writing. Triggers on: "write a post about", "turn this into a thread", "draft newsletter", "write this up", "content calendar", "publish this".
---

# Using the Writing System

## Core Philosophy

Capture once, publish everywhere. An idea has one source, many surfaces. Never start from blank — start from evidence: a thing you built, a problem you solved, a decision you made.

Good writing removes friction between an idea and the reader understanding it. Cut everything that doesn't serve that goal.

---

## 4-Part Pipeline

### 1. Idea Capture

Write a single atomic note before drafting anything. An atomic note answers one of:
- What did I learn?
- What did I build?
- What decision did I make and why?
- What surprised me?

**Format:**
```
Insight: [one sentence]
Context: [why this came up]
Evidence: [the specific thing that happened — metric, code, conversation]
```

Resist writing more at this stage. Capture → store → draft later. Don't let idea capture become writing.

---

### 2. Platform Selection

Match the idea to the platform where that format works:

| Format | Best for | Audience expectation |
|--------|----------|---------------------|
| X thread | Quick insight, numbered list, hot take | Fast scan, 280 chars/tweet |
| LinkedIn | Professional insight, career lesson | First 2 lines must hook |
| Blog | Deep dive, tutorial, decision record | 1200-2000 words, scannable |
| Newsletter | Curated + original, personal | Subject line drives open rate |

Choose one primary platform. Adapt for others after the primary draft is done.

---

### 3. Draft by Channel

#### X/Twitter Thread

Structure:
```
Tweet 1 (Hook): The entire value of the thread in one tweet.
                Someone who reads only this should walk away with something.
Tweet 2-5 (Insights): One insight per tweet. Max 25 words each.
                       Numbered: "2/ "
Last tweet (Remate): Callback to tweet 1 + CTA or question.
```

Rules:
- Tweet 1 carries full weight — most people won't click "read more"
- No cliffhangers in tweet 1 ("Here's the thing..." is not a hook)
- Each tweet works standalone — no "as I said above"
- CTA at the end: one ask (follow / repost / reply) — never all three

---

#### LinkedIn

Structure:
```
Line 1 (Hook): First line is all most people see. Make it count.
Line 2 (blank)
Lines 3-6 (Context): Why this matters. Brief.
Lines 7-10 (Insight): The core idea or lesson.
Lines 11-13 (Takeaway): What someone should do or think differently.
Last line (CTA): One question or one action. Never ask for follows.
```

Rules:
- No "I am humbled to share..." — start with the insight
- Blank line after line 1 forces the hook to stand alone
- LinkedIn's algorithm rewards comments over likes — end with a question
- 150-400 words optimal. Longer posts bury the insight.

---

#### Blog Post

Structure:
```
Intro (150-200 words): State the problem. Why does this matter to the reader?
Section 1 (400-500 words): First point + one concrete example
Section 2 (400-500 words): Second point + one concrete example
Section 3 (400-500 words): Third point + one concrete example
Conclusion (150-200 words): Restate what changed + one call to action
```

Rules:
- One concrete example per section — abstract without example is forgettable
- Subheadings should be informative, not clever: "Why I switched to Tailwind v4" not "A tale of two stylesheets"
- Code examples: show the before + after, not just the solution
- Optimal length: 1200-2000 words. Under 1000 feels thin; over 2500 loses most readers.

---

#### Newsletter

Structure:
```
Subject: [Number] [benefit] — "3 things I learned building [X]"
         OR question: "Why does [common thing] work this way?"
Preview text: Different from subject. Add context, not repetition.
Body: 300-600 words. One main idea + supporting points.
CTA: One link, one ask. At the bottom.
```

Rules:
- Subject line is 80% of the open rate — spend 20% of writing time on it
- Preview text in email clients shows after subject — use it, not "View in browser"
- One CTA. "Read the post + follow me + reply with your thoughts" = zero clicks.
- Conversational tone. Newsletter is personal; blog is editorial.

---

### 4. Edit

After first draft:
1. **Cut 30%** — every sentence that doesn't move the idea forward
2. **Replace vague with specific** — "improved significantly" → "reduced load time by 40%"
3. **Add one concrete example** if there isn't one already
4. **Read aloud** — if you stumble reading it, the reader will too
5. **Final check:** Does the first sentence earn the second? Does each section earn the next?

---

## Performance Loop

Review your top 5 posts every 30 days:
- What format resonated most?
- What topic got the most engagement?
- What did you write that you'd write differently now?

Replicate the **pattern**, not the content. If a numbered list format worked, use numbered lists again — but with new insights.

Output: `docs/content/YYYY-MM-DD-content-notes.md`

---

## Quality Checklist

- [ ] Atomic note captured before drafting
- [ ] Platform selected based on idea format (not habit)
- [ ] First sentence hooks — no "In this post, I will..."
- [ ] One concrete example per section (blog) or per thread (X)
- [ ] Cut 30% in edit pass
- [ ] Single CTA — not multiple asks

## Common Antipatterns

- **Writing without a captured insight** — Starting from "I should post something" leads to generic content. Start from a specific thing that happened.
- **Same copy on every platform** — A thread pasted to LinkedIn reads like a thread. Adapt the structure, not just the length.
- **Multiple CTAs** — "Follow me, repost this, comment below, read my newsletter" = decision paralysis. Pick one.
- **Vague claims** — "This saved us a lot of time" tells the reader nothing. "This reduced our deploy time from 45 minutes to 8 minutes" is memorable.
- **Saving performance analysis for "someday"** — The 30-day review is where you learn what actually works. Schedule it.
