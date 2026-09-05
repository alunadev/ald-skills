---
name: art-direction
description: >
  Sets the visual territory for a new product before any font, hex value, screen or token
  exists — one central idea, visual attributes, cultural references from outside the sector,
  photographic direction, then three divergent typographic/chromatic concepts to choose
  between, plus the explicit anti-cliché list. Produces ART-DIRECTION.md, which `design-md`
  then turns into tokens. Use when a project has no visual identity yet and the next step
  would otherwise be picking colors on a blank canvas. Not for products that already have an
  identity — use `taste-redesign` to elevate one, or `design-md`'s extract direction to
  document one.
---

# Art direction

The stage that decides *what a product should look like* — before anything decides what it
does look like.

Without it, the first screen is invented at the moment someone needs a screen, and every
decision after it inherits an accident. With it, every later decision has something to be
right or wrong against.

**This is a working tool, not a moodboard.** A moodboard accumulates; art direction curates.
The test for every element that goes in:

> Does this help decide something concrete later?

If a reference cannot finish the sentence "because of this, we will \_\_\_", it does not go in.
Twelve images that each settle one decision beat sixty that establish a vibe.

## When to use this

- A new product, brand or surface with no visual identity yet.
- The next thing anyone would do is open a blank canvas and pick a color.
- An existing identity is being deliberately rebuilt from zero, not adjusted.

**Not for:** a product that already has an identity. To lift the quality of one, use
`taste-redesign`. To document one that exists somewhere, use `design-md`'s extract direction.
To go straight from an interview to tokens on a throwaway project, `design-md`'s invent
direction is the faster path — this skill is what you use when the identity has to be *right*,
not just consistent.

## Output

One file, `ART-DIRECTION.md`, in the project root next to `DESIGN.md`. It has six sections,
in this order. Sections 1–4 are decided once. Section 5 forks into three concepts and one gets
chosen. Section 6 is written throughout and never gets deleted — it travels with `DESIGN.md`
for the life of the product.

| # | Section | Decided | Feeds |
|---|---|---|---|
| 1 | Central idea | once | everything |
| 2 | Visual attributes | once | §3, §5 |
| 3 | Cultural references | once | §4, §5 |
| 4 | Photographic direction | once | imagery, illustration, motion |
| 5 | Typographic & chromatic territory | **three concepts → one** | `DESIGN.md` tokens |
| 6 | What we don't want | continuously | every review, forever |

---

## 1. Central idea

**One sentence.** What this brand is about — not what the company sells.

It is not a tagline and not a positioning statement. It is the thing every later visual
decision has to stay loyal to.

Ask, in order:
1. What is this product, in one line, and who is it for?
2. What does it want to make someone feel that its category currently doesn't?
3. If it disappeared, what would be missing that nothing else provides?

Then write the sentence and read it back for approval before continuing. Everything downstream
inherits it, so a wrong sentence is expensive.

**Good:** "Training that reads the athlete back to themselves."
**Bad:** "The leading platform for connected fitness." (positioning, not an idea)

## 2. Visual attributes

**Three to five words that name *visual* qualities**, not corporate ones.

This is the section that most often goes wrong. "Innovative", "reliable", "premium",
"human-centered" are corporate attributes — nothing can be drawn from them, so they let any
design pass. Visual attributes constrain.

| Corporate (reject) | Visual (use) |
|---|---|
| innovative | angular, off-grid, unfinished |
| premium | dense, quiet, high-contrast |
| friendly | rounded, warm-neutral, generous |
| trustworthy | orthogonal, flat, evenly weighted |
| bold | oversized, cropped, saturated |

Test each candidate word: **could a designer draw two things and tell you which one is more
of it?** If not, replace it.

**How to get there: start from sensation, not vocabulary.** Ask what someone should feel the
first time they see this, then translate each sensation into a visual directive. The
translation is the work — the sensation alone decides nothing.

```
precision  → simple forms, generous air, nothing decorative
solidity   → heavy composition, deep colour, weight low in the frame
intimacy   → close crop, warm neutral, small type set large enough to be read slowly
```

The right-hand column is what becomes an attribute. The left-hand column is the reason, and it
goes in the file too — a later reviewer needs to know which sensation an attribute was serving
before they trade it away.

## 3. Cultural references

Where the visual world comes from — deliberately, **from outside the sector**.

**Sources:** cinema, architecture, art, photography, sculpture, editorial and print, product
design, textile, signage, packaging, scientific illustration, games.

**Hard rule — no competitor brands.** Referencing the sector is how a brand ends up looking
like the sector. The decontamination is the point: pull the visual world from somewhere the
category has never looked, then let the category's constraints filter it. A fitness product
that references Bauhaus signage and Tarkovsky lands somewhere no other fitness product is; one
that references three other fitness apps lands exactly where they already are.

Each reference is one line: **what it is → what we take from it.**

```
Barbican Estate, London (architecture) → repeated concrete modules; structure is
    the ornament, nothing applied on top.
Chris Marker, "La Jetée" (cinema) → stillness carrying motion; a sequence of held
    frames instead of continuous movement.
Josef Müller-Brockmann, Zurich concert posters (print) → one geometric event on a
    strict grid, enormous negative space.
```

Aim for 8–15. Anything you cannot write the "what we take from it" half for is accumulation —
cut it.

If the user keeps design inspiration in are.na, search the relevant channels first (`arena
search`, `arena channel contents <slug>`), and save anything new that survives the curation
test back to the matching channel.

## 4. Photographic direction

How reality gets depicted — the rules for photography, illustration, 3D, iconography and
motion, whichever the product will actually use.

Decide and write down:
- **Subject** — people, objects, environments, abstractions, nothing.
- **Treatment** — natural or staged; available light or lit; grain, flare, and imperfection, or
  clinical.
- **Distance and crop** — wide and contextual, or tight and cropped past the edge.
- **Palette in-image** — does photography carry the brand color, or stay neutral so the
  interface carries it?
- **Motion** — if it moves: what kind of movement, and what never moves.

Two or three sentences per bullet, each traceable to a §3 reference.

## 5. Typographic & chromatic territory — three concepts

**This is the only section that forks.** Everything above stays fixed; three concepts explore
three different ways to express it. This is deliberate — a single proposal is a decision made
in private, and the second and third exist to make the first one *legible* as a choice.

| Concept | Relationship to the sector | Purpose |
|---|---|---|
| **A — Conservative** | speaks the category's visual language, done well | the safe answer, made explicit so it can be rejected on purpose |
| **B — In-between** | recognizable as the category, unmistakably not the others in it | usually where the answer is |
| **C — Disruptive** | owes the category nothing | shows where the ceiling is, and drags B upward |

**Territory, not values.** No real typeface names, no hex codes yet. Describe the region:

```
Concept B — "Field notes"

Typographic territory:
  A grotesque with visible construction — squared terminals, tight apertures —
  set at two weights only, never three. Body text one step larger than comfortable.
  Numerals tabular everywhere; this product is read as much as it is looked at.

Chromatic territory:
  One saturated accent against a warm off-white and a near-black that is not black.
  The accent appears at most once per screen. No second accent, no gradient, no
  semantic color beyond error.

Where it comes from:
  Müller-Brockmann's grid (§3) with La Jetée's stillness (§3); the accent is the
  single geometric event.

What it costs:
  Two weights and one accent means hierarchy has to come from size and space alone.
  If the product needs dense data tables, this concept fights them.
```

Every concept carries that last block. A concept with no stated cost has not been thought
through.

### The memorability pass — run it on all three, before the choice

Saffron's six keys to memorability, applied to each concept **while all three are still on the
table.** Run before the choice, not after: the model's whole use is discriminating between
options, and running it on the winner only turns it into a rubber stamp.

Answer each key with the concrete visual decision that earns it, not with yes/no. A key with no
decision behind it is a "no", however good the concept looks.

| Key | The question | What a "yes" looks like |
|---|---|---|
| Emotion | Does it make someone feel a specific thing, or just look competent? | You can name the feeling and point at the element producing it |
| Attention | Is there one element that arrests, or is it uniformly pleasant? | One deliberate disruption — scale, colour, crop — and only one |
| Story | Can someone explain where it comes from in one sentence? | The sentence traces to a §3 reference, not to a trend |
| Involvement | Does it ask anything of the viewer, or only broadcast? | Something rewards a second look: a detail, a system the viewer decodes |
| **Repetition** | Is there an element that can recur everywhere without becoming wallpaper? | A named, reusable device — a rule, a crop, a shape, a spacing signature |
| **Consistency** | Can it hold across every surface without inventing exceptions? | Every surface you can name resolves without a special case |

**Repetition and consistency are the two that carry the weight on a solo project**, and they
are bolded for that reason. The other four assume an audience and repeated exposure — real for
a brand with a media budget, thin for a product nobody has seen yet. Do not discard them: they
are what stops a concept that is merely tasteful from winning. But when two concepts split, let
repetition and consistency break the tie, because they are the two you can actually act on
tomorrow.

Repetition is also the key most often failed by the concept that looks best in the
presentation. A concept with no recurring device photographs well as three screens and
disintegrates across thirty.

**Then present all three, with their costs and their memorability answers, and let the user
choose.** Do not recommend one until asked, and if asked, name the cost you would be accepting.

A "no" on any key is not a rejection — it is a note that travels into `DESIGN.md` with the
winning concept, so the gap is known rather than discovered later.

## 6. What we don't want

The anti-cliché list. Explicit, written down, and **permanent** — it travels with `DESIGN.md`
and gets read at every design review for the life of the product.

Two kinds of entry:

**Category clichés** — what everything in this sector already does:
```
- Blue-to-purple gradients (every product in this category, without exception)
- Isometric 3D illustrations of abstract people
- A hero with a laptop mockup floating at a 15° angle
- Rounded-everything as a substitute for warmth
```

**Concept-specific exclusions** — what the chosen concept rules out *for this product*:
```
- No second accent color, ever. Hierarchy comes from size and space.
- No drop shadows. Elevation is expressed with border and background only.
- No stock photography of people. If people appear, they are the actual users.
```

Write category clichés while researching §3 — they are the by-product of looking at the sector
you are refusing to reference. Write concept exclusions the moment a concept is chosen.

Every entry is enforceable: it names a thing you can point at in a screen and say *that*.
"Don't be generic" is not an entry.

---

## Handoff

`ART-DIRECTION.md` is the input to `design-md`. The chosen concept's territory becomes real
values there:

| `ART-DIRECTION.md` | → | `DESIGN.md` |
|---|---|---|
| §5 typographic territory | → | a real typeface, the scale, the weights |
| §5 chromatic territory | → | hex/oklch values, the neutral ladder, roles |
| §1 central idea, §2 attributes | → | the Overview prose that explains *why* those values |
| §4 photographic direction | → | the imagery/motion rules in the body |
| §6 what we don't want | → | the Don'ts section, verbatim |

Run `design-md`'s **invent** direction with `ART-DIRECTION.md` already written — the six-question
interview it would otherwise run has been answered, with far more behind each answer. Skip
straight to drafting tokens.

Only after `DESIGN.md` exists does design move to screens (`design-lab`) or components
(`prototype`).

## Sources

- La Mina Estudio Branding — *Cómo hacer una guía de estilo para el diseño de identidad de
  marca*: the six components, and curation-over-accumulation as the discipline that separates a
  style guide from a moodboard.
- Jose Trave — the three-concept method (conservative to the industry / in-between /
  disruptive) and deliberate decontamination from the sector when choosing references.
- Saffron Brand Consultants — *The Six Keys to a Memorable Brand*: emotion, attention, story,
  involvement, repetition, consistency.
