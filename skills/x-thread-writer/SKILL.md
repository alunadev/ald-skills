---
name: x-thread-writer
description: >
  Writes X/Twitter threads and single tweets in the user's own voice — the same craft
  standard as `linkedin-post-writer`, adapted for X's shorter, faster format. Use when
  drafting an X/Twitter thread, turning an insight into a tweet, or reviewing a thread draft
  for tone. Normally invoked by `writing-system` once X is the chosen platform, but works
  standalone too.
---

# X / Twitter Thread Writer

## Core Philosophy

Same rule as `linkedin-post-writer`: one thread is one observation or one earned insight,
never a manufactured hook. X rewards speed and directness more than LinkedIn does — that
changes the format, not the honesty standard.

## Two Formats

### Single Tweet (default — the X equivalent of a Nota)

One observation, stated directly, numbers included if there are any. Most things worth
saying on X fit in one tweet. Don't inflate a single-tweet observation into a thread to look
more substantial — that's padding, and it reads as padding.

### Thread (for a real multi-step insight)

```
Tweet 1 (Hook): Carries the entire value of the thread by itself. Someone who reads
                only this walks away with something real. State the claim, don't tease it.
Tweet 2-5 (Insights): One insight per tweet, numbered ("2/"). Max ~25 words each —
                       shorter reads better than clever.
Last tweet (Close): Callback to tweet 1, then one CTA — never more than one.
```

Rules specific to threads:
- Tweet 1 carries full weight. Most readers won't click "show more" or scroll past it.
- No cliffhangers in tweet 1 — "here's the thing..." is not a hook, it's a stall.
- Each tweet works standalone. No "as I said above" — assume someone lands on tweet 3
  first.
- One CTA at the end (follow, or reply, or repost) — never stack all three.

## Platform Mechanics (facts, not voice)

- ~280 characters per tweet — write for it, don't fight it with abbreviations that hurt
  readability.
- Thread numbering ("2/", "3/") only past 2 tweets; a 2-tweet thread doesn't need numbers.

## Voice Rules (non-negotiable — same standard as linkedin-post-writer)

- **No "No es X. Es Y." / "not X, but Y" constructions** — including in tweet 1.
- **No em dashes.**
- **No hype vocabulary**: "dive into", "unlock", "elevate", "unleash", "next-gen",
  "game-changer", "synergy", "robust", "leverage", "landscape".
- **No urgency, scarcity, or exclusivity devices.**
- **No claim you couldn't defend if quote-tweeted by someone who knows the details.**
- **A counted number beats a superlative.**
- **Plain first tweet beats a formula.** State the claim; don't tease a "secret."

## Before Publishing

- [ ] Real observation or earned insight, not a topic picked because threads about it
      tend to perform
- [ ] Grep for "no es… es" / "not X, but Y" — zero hits, including tweet 1
- [ ] Zero em dashes, zero hype words from the banned list above
- [ ] Every tweet works if someone reads it alone
- [ ] One CTA max at the end
- [ ] Every number is real and counted

## See Also

- `writing-system` — the orchestrator: idea capture and platform selection happen there;
  this skill is what it hands off to once X is the chosen platform.
- `linkedin-post-writer` — same voice rules, adapted for LinkedIn's longer, slower format.
