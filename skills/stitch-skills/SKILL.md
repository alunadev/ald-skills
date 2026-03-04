---
name: using-stitch-skills
description: Converts Stitch AI design tool screens to production-ready code and generates complete UI systems. Use when working with the Stitch MCP server, converting Stitch screens to React components, generating DESIGN.md documentation from Stitch projects, integrating Stitch output with shadcn/ui components, or creating UI walkthroughs with Remotion. Triggers on: "use Stitch", "convert Stitch screen", "generate DESIGN.md", "Stitch to React", "generate from Stitch".
---

# Using Stitch Skills

Stitch is an AI design tool that generates UI screens from prompts. This skill coordinates six sub-skills to convert Stitch output into production-ready code and documentation.

Requires the **Stitch MCP server** to be active. If Stitch is not available, use `frontend-design` + `tailwind-design-system` instead.

## Core Philosophy

Stitch generates the visual blueprint; your job is to translate it into maintainable, accessible, production-ready code. Treat Stitch output as a high-fidelity wireframe — extract design decisions, then implement them properly.

## When to Use Each Sub-Skill

| Task | Sub-skill |
|------|-----------|
| Document a Stitch project's design system | `design-md` |
| Convert screens to React component system | `react-components` |
| Generate a complete multi-page website | `stitch-loop` |
| Improve a vague UI prompt before using Stitch | `enhance-prompt` |
| Create a video walkthrough of a Stitch project | `remotion` |
| Integrate Stitch output with shadcn/ui | `shadcn-ui` |

---

## 1. `design-md` — Generate Design Documentation

**When:** After creating a Stitch project, before writing any code.

**What it does:** Analyzes all Stitch screens and extracts the design system into a `DESIGN.md` file:
- Color palette (with semantic names: `--color-primary`, `--color-surface`, etc.)
- Typography scale (font families, sizes, weights, line heights)
- Spacing system (base unit, scale steps)
- Component inventory (list of all UI components seen across screens)
- Layout patterns (grid system, breakpoints observed)

**Output:** `DESIGN.md` in the project root.

**How to invoke:**
1. Open Stitch project via MCP
2. Read all screens
3. Extract visual tokens → write to `DESIGN.md`
4. Validate: every color and font in the screens must appear in `DESIGN.md`

---

## 2. `react-components` — Convert Screens to React

**When:** After `design-md` is complete and `DESIGN.md` exists.

**What it does:** Converts each Stitch screen into a typed React component system:
- One component per distinct UI element (not one per screen)
- Shared components go in `components/ui/`; screen-specific go in `components/[screen]/`
- Props typed with TypeScript interfaces
- Styles via Tailwind v4 utility classes (from tokens in `DESIGN.md`)
- Accessibility: semantic HTML, aria-labels on interactive elements, keyboard navigation

**Validation loop:**
1. Generate component
2. Check: does it match the Stitch screen visually? (compare key measurements)
3. Check: does it use tokens from `DESIGN.md` rather than hardcoded values?
4. Check: does it pass TypeScript type checking?

**Output:** `components/` directory with typed, accessible React components.

---

## 3. `stitch-loop` — Generate Complete Multi-Page Website

**When:** Building a full site or app from a single prompt.

**What it does:** Orchestrates an end-to-end generation loop:
1. Prompt enhancement (see `enhance-prompt`)
2. Generate each page/screen in Stitch
3. Extract design system → `DESIGN.md`
4. Generate React components → `components/`
5. Assemble pages with Next.js routing
6. Add navigation between pages

**Gate between steps:** Each step's output must be validated before proceeding. Do not generate all screens upfront and convert later — iterate screen by screen so design consistency is maintained.

**Output:** Complete Next.js app with pages, components, and `DESIGN.md`.

---

## 4. `enhance-prompt` — Optimize Prompts for Stitch

**When:** Before generating a screen in Stitch. Especially useful when the idea is vague or high-level.

**What it does:** Transforms a rough UI idea into a Stitch-optimized prompt by adding:
- **Platform context:** web / mobile / tablet
- **Visual style:** minimalist, bold, glass morphism, etc.
- **Content specifics:** what text, data, and actions appear on screen
- **Design system hints:** color palette direction, font personality
- **Layout direction:** left-to-right, card-based, split-screen, etc.

**Input format:**
```
Original idea: [rough description]
Platform: [web/iOS/Android]
Style direction: [reference or adjectives]
Key content: [main elements on screen]
```

**Output:** Enhanced Stitch prompt, ready to paste.

---

## 5. `remotion` — Create Video Walkthrough

**When:** Presenting a Stitch project to stakeholders or for Product Hunt launch.

**What it does:** Creates a Remotion video that walks through Stitch screens:
- Each screen becomes a video segment
- Transitions between screens
- Highlight animations for key interactions
- Voiceover-ready timing (configurable duration per screen)

**Setup required:**
```bash
npm install remotion @remotion/player
```

**Output:** `remotion/` directory with video composition. Run with `npx remotion studio`.

---

## 6. `shadcn-ui` — Integrate with shadcn/ui

**When:** After generating React components from Stitch, to replace custom primitives with shadcn/ui components.

**What it does:** Maps Stitch-generated components to their shadcn/ui equivalents:
- Buttons → `<Button>` with correct variant
- Inputs → `<Input>`, `<Textarea>`, `<Select>`
- Cards → `<Card>`, `<CardHeader>`, `<CardContent>`
- Dialogs → `<Dialog>` (not custom modal)
- Navigation → `<NavigationMenu>`, `<Tabs>`

**Process:**
1. Audit generated components for shadcn/ui replacements
2. Install needed shadcn/ui components: `npx shadcn@latest add [component]`
3. Replace custom implementations with shadcn/ui primitives
4. Preserve custom styling via `className` prop and Tailwind overrides

**Output:** Refactored component directory using shadcn/ui primitives.

---

## Output Format

Document all generated files in `DESIGN.md`:

```
## Generated Files
- components/ui/Button.tsx — primary/secondary/ghost variants
- components/ui/Card.tsx — with header, content, footer slots
- components/[screen]/HeroSection.tsx — screen-specific
- remotion/Walkthrough.tsx — video composition
```

## Quality Checklist

- [ ] `DESIGN.md` created before any React components
- [ ] All colors reference CSS variables from `DESIGN.md`, not hardcoded hex values
- [ ] All interactive elements have accessible labels
- [ ] Components typed with TypeScript — no `any`
- [ ] shadcn/ui primitives used where available
- [ ] Video walkthrough covers all key screens (if Remotion used)

## Common Antipatterns

- **Starting with React before DESIGN.md** — You lose the opportunity to establish a consistent token system. Design system first, code second.
- **One component per screen** — Screens share components. Extract shared patterns into reusable components.
- **Hardcoded colors/fonts** — Always extract to CSS variables; hardcoded values create maintenance debt.
- **Ignoring accessibility** — Stitch output is visual-only. Accessibility (aria, keyboard nav, semantic HTML) must be added explicitly.

## See Also

- `frontend-design` — For design system decisions and component architecture
- `interface-design` — For UI pattern selection and layout principles
- `tailwind-design-system` — For Tailwind v4 token setup and CVA component variants
- `react-best-practices` — For React performance and rendering best practices
