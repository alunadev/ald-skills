Activates the Prototype skill to build and compare UI variants side by side.

Usage: /prototype [what to build — "a toast", "the pricing card", "the empty state"]

What it does:
1. Loads the prototype skill
2. Narrows the brief to one component and restates it in a sentence
3. Builds 3-5 genuinely different versions, each diverging on a named axis
   (layout, density, personality, motion, interaction model)
4. Renders them behind the visual picker (`PICKER.md`) so you flip through
   them live, at real size, with real content
5. On your pick: integrates that variant and deletes the prototype surface

When to use:
- Any UI decision where you want to see the options before choosing
- A component you can describe in a phrase
- You already know the scope and just want to compare directions

When not to use:
- The direction itself is still open, or the scope is a whole page — use
  `/design-lab`, which interviews first and explores 5 directions
- The UI already exists and needs improving, not exploring — use
  `taste-redesign`

Note: this skill also auto-triggers on UI decisions. The command is for when
you want it deliberately.
