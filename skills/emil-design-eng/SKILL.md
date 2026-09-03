---
name: emil-design-eng
description: >
  Encodes Emil Kowalski's design engineering philosophy — UI polish, component design,
  animation decisions, and the invisible details that make software feel great. Use as the
  reference/philosophy layer for interaction craft. For the narrower, task-specific pieces of
  this same philosophy, see `animation` (build, review, audit or discover motion),
  `animation-vocabulary` (name an effect), `apple-design` (gesture/spring physics),
  `ask-sonner` (the Sonner toast library). Source: github.com/emilkowalski/skills.
---

# Design Engineering

You are a design engineer with the craft sensibility. You build interfaces where every detail
compounds into something that feels right. In a world where everyone's software is good
enough, taste is the differentiator.

## Core Philosophy

### Taste is trained, not innate

Good taste is not personal preference. It is a trained instinct: the ability to see beyond the
obvious and recognize what elevates. You develop it by surrounding yourself with great work,
thinking deeply about why something feels good, and practicing relentlessly.

When building UI, don't just make it work. Study why the best interfaces feel the way they do.
Reverse engineer animations. Inspect interactions. Be curious.

### Unseen details compound

Most details users never consciously notice. That is the point. When a feature functions
exactly as someone assumes it should, they proceed without giving it a second thought. That is
the goal.

> "All those unseen details combine to produce something that's just stunning, like a thousand
> barely audible voices all singing in tune." — Paul Graham

Every decision below exists because the aggregate of invisible correctness creates interfaces
people love without knowing why.

### Beauty is leverage

People select tools based on the overall experience, not just functionality. Good defaults and
good animations are real differentiators. Beauty is underutilized in software. Use it as
leverage to stand out.

## Review Format (Required)

When reviewing UI code, use a markdown table with Before/After columns — never a "Before:" /
"After:" list on separate lines:

| Before | After | Why |
| --- | --- | --- |
| `transition: all 300ms` | `transition: transform 200ms ease-out` | Specify exact properties; avoid `all` |
| `transform: scale(0)` | `transform: scale(0.95); opacity: 0` | Nothing in the real world appears from nothing |
| `ease-in` on dropdown | `ease-out` with custom curve | `ease-in` feels sluggish; `ease-out` gives instant feedback |
| No `:active` state on button | `transform: scale(0.97)` on `:active` | Buttons must feel responsive to press |
| `transform-origin: center` on popover | `transform-origin: var(--transform-origin)` | Popovers should scale from their trigger (not modals — modals stay centered) |

## The Animation Decision Framework

Before writing any animation code, answer these questions in order.

### 1. Should this animate at all?

| Frequency | Decision |
| --- | --- |
| 100+ times/day (keyboard shortcuts, command palette toggle) | No animation. Ever. |
| Tens of times/day (hover effects, list navigation) | Remove or drastically reduce |
| Occasional (modals, drawers, toasts) | Standard animation |
| Rare/first-time (onboarding, feedback forms, celebrations) | Can add delight |

Never animate keyboard-initiated actions. These actions are repeated hundreds of times daily.
Animation makes them feel slow, delayed, and disconnected from the user's actions. Raycast has
no open/close animation — that is the optimal experience for something used hundreds of times
a day.

### 2. What is the purpose?

Every animation must have a clear answer to "why does this animate?" Valid purposes:

- **Spatial consistency** — toast enters and exits from the same direction, making
  swipe-to-dismiss feel intuitive
- **State indication** — a morphing feedback button shows the state change
- **Explanation** — a marketing animation that shows how a feature works
- **Feedback** — a button scales down on press, confirming the interface heard the user
- **Preventing jarring changes** — elements appearing or disappearing without transition feel
  broken

If the purpose is just "it looks cool" and the user will see it often, don't animate.

### 3. What easing should it use?

```
Is the element entering or exiting?
  Yes → ease-out (starts fast, feels responsive)
  No →
    Is it moving/morphing on screen?
      Yes → ease-in-out (natural acceleration/deceleration)
    Is it a hover/color change?
      Yes → ease
    Is it constant motion (marquee, progress bar)?
      Yes → linear
    Default → ease-out
```

Use custom easing curves — the built-in CSS easings are too weak, they lack the punch that
makes animations feel intentional:

```css
/* Strong ease-out for UI interactions */
--ease-out: cubic-bezier(0.23, 1, 0.32, 1);

/* Strong ease-in-out for on-screen movement */
--ease-in-out: cubic-bezier(0.77, 0, 0.175, 1);

/* iOS-like drawer curve (from Ionic Framework) */
--ease-drawer: cubic-bezier(0.32, 0.72, 0, 1);
```

Never use `ease-in` for UI animations. It starts slow, which makes the interface feel sluggish
and unresponsive. A dropdown with `ease-in` at 300ms *feels* slower than `ease-out` at the same
300ms, because `ease-in` delays the initial movement — the exact moment the user is watching
most closely. Need a curve not listed here? Use easing.dev or easings.co rather than hand-rolling one.

### 4. How fast should it be?

| Element | Duration |
| --- | --- |
| Button press feedback | 100-160ms |
| Tooltips, small popovers | 125-200ms |
| Dropdowns, selects | 150-250ms |
| Modals, drawers | 200-500ms |
| Marketing/explanatory | Can be longer |

UI animations should stay under 300ms. A 180ms dropdown feels more responsive than a 400ms
one. A faster-spinning spinner makes the app feel like it loads faster, even when the load
time is identical.

### Perceived performance

Speed in animation is not just about feeling snappy — it directly affects how users perceive
your app's performance. A fast-spinning spinner makes loading feel faster (same load time,
different perception). Instant tooltips after the first one is open (skip delay + skip
animation) make the whole toolbar feel faster. Easing amplifies this: `ease-out` at 200ms
*feels* faster than `ease-in` at 200ms because the user sees immediate movement.

## Spring Animations

Springs feel more natural than duration-based animations because they simulate real physics.
They don't have fixed durations — they settle based on physical parameters.

**When to use springs:** drag interactions with momentum, elements that should feel "alive"
(like Apple's Dynamic Island), gestures that can be interrupted mid-animation, decorative
mouse-tracking interactions. See `apple-design` for the full gesture/spring physics model.

**Spring-based mouse interactions.** Tying visual changes directly to mouse position feels
artificial because it lacks motion. Use `useSpring` from Motion to interpolate value changes
instead of updating immediately:

```jsx
import { useSpring } from 'framer-motion';

// Without spring: feels artificial, instant
const rotation = mouseX * 0.1;

// With spring: feels natural, has momentum
const springRotation = useSpring(mouseX * 0.1, { stiffness: 100, damping: 10 });
```

This works because the animation is decorative — it doesn't serve a function. If this were a
functional graph in a banking app, no animation would be better.

**Spring configuration.** Apple's approach (recommended — easier to reason about):
`{ type: "spring", duration: 0.5, bounce: 0.2 }`. Traditional physics (more control):
`{ type: "spring", mass: 1, stiffness: 100, damping: 10 }`. Keep bounce subtle (0.1-0.3);
avoid it in most UI contexts, use it for drag-to-dismiss and playful interactions.

**Interruptibility.** Springs maintain velocity when interrupted — CSS animations and
keyframes restart from zero. When you click an expanded item and quickly press Escape, a
spring-based animation smoothly reverses from its current position.

## Component Building Principles

**Buttons must feel responsive.** Add `transform: scale(0.97)` on `:active` (subtle range:
0.95-0.98).

```css
.button { transition: transform 160ms ease-out; }
.button:active { transform: scale(0.97); }
```

**Never animate from `scale(0)`.** Nothing in the real world disappears and reappears
completely. Start from `scale(0.9)` or higher, combined with opacity — like a balloon that has
a visible shape even when deflated.

```css
/* Bad */
.entering { transform: scale(0); }
/* Good */
.entering { transform: scale(0.95); opacity: 0; }
```

**Make popovers origin-aware.** Popovers should scale in from their trigger, not from center.
`transform-origin: center` is wrong for almost every popover. Exception: modals — they're not
anchored to a specific trigger, so they stay centered.

```css
.popover { transform-origin: var(--transform-origin); } /* Base UI */
```

**Tooltips skip delay on subsequent hovers.** Tooltips should delay before appearing to
prevent accidental activation. Once one tooltip is open, hovering adjacent tooltips should
open them instantly with no animation.

```css
.tooltip {
  transition: transform 125ms ease-out, opacity 125ms ease-out;
  transform-origin: var(--transform-origin);
}
.tooltip[data-starting-style], .tooltip[data-ending-style] { opacity: 0; transform: scale(0.97); }
.tooltip[data-instant] { transition-duration: 0ms; } /* skip animation on subsequent tooltips */
```

**Use CSS transitions over keyframes for interruptible UI.** Transitions can be interrupted
and retargeted mid-animation; keyframes restart from zero. For anything triggered rapidly
(toasts, toggles), transitions produce smoother results.

**Use blur to mask imperfect transitions.** When a crossfade between two states feels off
despite tuning easing/duration, add subtle `filter: blur(2px)` during the transition — without
it, the eye reads two distinct objects swapping. Keep blur under 20px (heavier is expensive,
especially in Safari).

**Animate enter states with `@starting-style`** — the modern CSS way to animate element entry
without JavaScript, replacing the `useEffect`-set-`mounted`-flag pattern:

```css
.toast {
  opacity: 1; transform: translateY(0);
  transition: opacity 400ms ease, transform 400ms ease;
  @starting-style { opacity: 0; transform: translateY(100%); }
}
```

## CSS Transform Mastery

- **Percentages in `translate()`** are relative to the element's own size —
  `translateY(100%)` moves by its own height regardless of dimensions. This is how Sonner
  positions toasts and Vaul hides drawers before animating in. Prefer percentages over
  hardcoded pixels.
- **`scale()` scales children too.** Scaling a button on press scales its font size, icons,
  and content proportionally — a feature, not a bug.
- **3D transforms for depth** — `rotateX()`/`rotateY()` with `transform-style: preserve-3d`
  create real 3D effects (orbits, coin flips) without JavaScript.
- **`transform-origin`** — every element has an anchor point transforms execute from. Default
  is center; set it to match where the trigger lives for origin-aware interactions.

## clip-path for Animation

`clip-path` is not just for shapes — it's one of the most powerful animation tools in CSS.
`clip-path: inset(top right bottom left)` defines a rectangular region; each value "eats" into
the element from that side.

- **Tabs with perfect color transitions** — duplicate the tab list, style the copy as
  "active," clip the copy so only the active tab is visible, animate the clip on change. Seamless
  color transition that timing individual colors never achieves.
- **Hold-to-delete** — `clip-path: inset(0 100% 0 0)` on a colored overlay, transition to
  `inset(0 0 0 0)` over 2s linear on `:active`, snap back with 200ms ease-out on release.
- **Image reveals on scroll** — start `inset(0 0 100% 0)`, animate to `inset(0 0 0 0)` on
  viewport entry (`IntersectionObserver` or Motion's `useInView({ once: true, margin: "-100px" })`).
- **Comparison sliders** — clip one overlaid image with `inset(0 50% 0 0)`, adjust the right
  value on drag. No extra DOM elements, fully hardware-accelerated.

## Gesture and Drag Interactions

- **Momentum-based dismissal** — don't require dragging past a threshold. Calculate velocity
  (`Math.abs(dragDistance) / elapsedTime`); dismiss if it exceeds ~0.11 regardless of distance.
- **Damping at boundaries** — dragging past a natural boundary should move the element less
  the further it goes; real things slow before they stop.
- **Pointer capture** — once dragging starts, capture pointer events so dragging continues
  even if the pointer leaves the element's bounds.
- **Multi-touch protection** — ignore additional touch points after the drag begins, or
  switching fingers mid-drag jumps the element.
- **Friction, not hard stops** — allow over-drag with rising resistance rather than refusing
  it outright.

See `apple-design` for the full gesture physics model (velocity handoff, momentum projection,
rubber-banding formula).

## Performance Rules

- **Only animate `transform` and `opacity`** — they skip layout and paint, running on the GPU.
  `padding`/`margin`/`height`/`width` trigger all three rendering steps.
- **CSS variables are inheritable** — changing one on a parent recalculates styles for every
  child. Update `transform` directly on the element instead of driving it through a shared
  variable.
- **Framer Motion's `x`/`y`/`scale` shorthands are NOT hardware-accelerated** — they run on
  `requestAnimationFrame` on the main thread and drop frames under load. Use the full
  `transform` string instead: `animate={{ transform: "translateX(100px)" }}`.
- **CSS animations beat JS under load** — they run off the main thread; `requestAnimationFrame`-based
  animation drops frames while the browser loads, scripts, or paints. CSS for predetermined
  motion, JS for dynamic/interruptible motion.
- **WAAPI** (`element.animate()`) gives JS control with CSS-grade performance, hardware-accelerated,
  interruptible, no library needed.

## Accessibility

```css
@media (prefers-reduced-motion: reduce) {
  .element { animation: fade 0.2s ease; } /* keep opacity/color, drop transform-based motion */
}
@media (hover: hover) and (pointer: fine) {
  .element:hover { transform: scale(1.05); } /* touch fires false hovers on tap */
}
```

Reduced motion means fewer and gentler animations, not zero — keep transitions that aid
comprehension, remove movement and position animations.

## The Sonner Principles (Building Loved Components)

From building Sonner (13M+ weekly downloads) — apply to any component:

1. **Developer experience is key.** No hooks, no context, no complex setup — the less friction
   to adopt, the more people use it.
2. **Good defaults matter more than options.** Most users never customize; the default easing,
   timing, and visual design should be excellent out of the box.
3. **Naming creates identity.** Sacrifice discoverability for memorability when appropriate.
4. **Handle edge cases invisibly** — pausing timers on hidden tabs, filling gaps between
   stacked toasts, capturing pointer events during drag. Users never notice, and that's exactly
   right.
5. **Use transitions, not keyframes, for dynamic UI** — added rapidly, need to retarget
   smoothly.
6. **Build a great documentation site** — let people touch and understand the product before
   they adopt it.

**Cohesion matters.** Sonner's animation is slightly slower than typical UI and uses `ease`
rather than `ease-out` to feel more elegant — matching the toast design, the page design, the
name. Match motion to the component's personality: a playful component can be bouncier, a
dashboard stays crisp.

**Asymmetric enter/exit timing.** Slow where the user is deciding (a hold-to-delete press: 2s
linear), snappy where the system responds (release: 200ms ease-out).

## Stagger Animations

When multiple elements enter together, stagger their appearance (30-80ms between items — long
delays make the interface feel slow). Stagger is decorative; never block interaction while it
plays.

```css
.item { opacity: 0; transform: translateY(8px); animation: fadeIn 300ms ease-out forwards; }
.item:nth-child(2) { animation-delay: 50ms; }
.item:nth-child(3) { animation-delay: 100ms; }
@keyframes fadeIn { to { opacity: 1; transform: translateY(0); } }
```

## Debugging Animations

Play animations in slow motion (2-5x duration, or the DevTools Animations panel) to spot
issues invisible at full speed: do colors transition smoothly or overlap as two distinct
states, does easing feel right, is `transform-origin` correct, are multiple animated
properties in sync. Step frame-by-frame for timing issues between coordinated properties.
For touch interactions, test on a real device — Safari's remote devtools over USB, or the
Xcode Simulator as a fallback. **Review with fresh eyes the next day** — you notice
imperfections you missed during development.

## Review Checklist

| Issue | Fix |
| --- | --- |
| `transition: all` | Specify exact properties: `transition: transform 200ms ease-out` |
| `scale(0)` entry animation | Start from `scale(0.95)` with `opacity: 0` |
| `ease-in` on UI element | Switch to `ease-out` or custom curve |
| `transform-origin: center` on popover | Set to trigger location or `var(--transform-origin)` (modals exempt) |
| Animation on keyboard action | Remove animation entirely |
| Duration > 300ms on UI element | Reduce to 150-250ms |
| Hover animation without media query | Add `@media (hover: hover) and (pointer: fine)` |
| Keyframes on rapidly-triggered element | Use CSS transitions for interruptibility |
| Framer Motion `x`/`y` props under load | Use `transform: "translateX()"` for hardware acceleration |
| Same enter/exit transition speed | Make exit faster than enter |
| Elements all appear at once | Add stagger delay (30-80ms between items) |

## See Also

- `animation` — the four working modes over this philosophy: build turns motion requests into implementation following this
  same philosophy step by step.
- `animation-vocabulary` — reverse-lookup glossary for naming an effect.
- `apple-design` — the full gesture/spring physics model this skill only summarizes.
- `ask-sonner` — setup, styling, and troubleshooting for the Sonner toast library.
- `taste-skill` / `taste-redesign` — the broader anti-slop system (layout, content, AI-tells)
  this skill's motion sections used to cover only in outline.
