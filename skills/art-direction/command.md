Activates the Art Direction skill to set a new product's visual territory before
any font, color or screen exists.

Usage: /art-direction [the project — "a training app for amateur cyclists"]

What it does:
1. Loads the art-direction skill
2. Writes the central idea — one sentence everything downstream stays loyal to
3. Names 3-5 visual attributes (drawable qualities, never "innovative" or
   "premium")
4. Curates 8-15 cultural references from outside the sector — cinema,
   architecture, art, photography, print — with no competitor brands, each one
   paired with what we take from it
5. Sets the photographic direction — subject, treatment, crop, in-image palette,
   motion
6. Proposes three typographic/chromatic concepts to choose between: conservative
   to the category, in-between, disruptive — each with its stated cost
7. Keeps the "what we don't want" anti-cliché list, which travels permanently
   with DESIGN.md
8. Writes ART-DIRECTION.md in the project root, then hands off to `design-md`
   to turn the chosen territory into real tokens

When to use:
- A new product with no visual identity, where the next step would otherwise be
  picking colors on a blank canvas
- An identity being rebuilt from zero, not adjusted

When not to use:
- The product already has an identity — use `taste-redesign` to lift it, or
  `design-md`'s extract direction to document it
- A throwaway project that just needs consistent tokens fast — `design-md`'s
  invent direction is the shorter path

Note: this skill also auto-triggers when a new project reaches its first visual
decision. The command is for when you want it deliberately.
