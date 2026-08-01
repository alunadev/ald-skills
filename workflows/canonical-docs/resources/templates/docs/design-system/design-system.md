---
title: "Design System — [FILL IN: Product Name]"
status: draft  # options: draft | approved
date: YYYY-MM-DD
---

# Design System

## Design Tokens

### Colors

[FILL IN: primary brand color, secondary, neutrals, semantic colors (success, error, warning, info)]

```css
/* Define in your app's global stylesheet / theme config */
--color-primary: [FILL IN: hex or oklch value];
--color-primary-foreground: [FILL IN];

--color-background: [FILL IN];
--color-foreground: [FILL IN];

/* Semantic */
--color-success: [FILL IN];
--color-error: [FILL IN];
--color-warning: [FILL IN];
--color-info: [FILL IN];
```

### Typography

[FILL IN: font family, size scale used in the product]

- **Heading font:** [FILL IN]
- **Body font:** [FILL IN]
- **Scale:** [FILL IN: e.g., 12/14/16/18/20/24/32/48]
- **Weights used:** [FILL IN: e.g., Regular 400, Medium 500]

### Spacing

[FILL IN: spacing scale. E.g., 12px / 16px / 24px / 36px / 40px / 64px]

| Token | Value | Usage |
|-------|-------|-------|
| `sp-[FILL IN]` | [FILL IN]px | [FILL IN] |

### Corner Radius

| Token | Value | Usage |
|-------|-------|-------|
| `radius-[FILL IN]` | [FILL IN]px | [FILL IN: e.g., input fields and cards] |
| `radius-full` | 9999px | Circular elements (avatars, indicators) |

### Shadows

[FILL IN: elevation/shadow system, e.g. "card shadow: multi-layered for depth"]

## Component Inventory

[FILL IN: List the custom components in this product. Link to their path.]

| Component | Path | Description |
|-----------|------|-------------|
| [FILL IN] | `components/ui/[name]` | [FILL IN] |

## Component Library Used

[FILL IN: which component library/primitives this project uses, so the agent knows what's already available before building custom components.]

- [FILL IN: e.g., shadcn/ui — Button, ...]

## Visual Style

[FILL IN: 3-5 adjectives that describe the visual direction. E.g., "clean, minimal, data-dense, professional".]

- [FILL IN]

## Accessibility

- Target WCAG level: [AA | AAA]
- Color contrast minimum: [4.5:1 for normal text | 3:1 for large text]
- [FILL IN: any specific accessibility requirements]
