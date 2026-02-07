# Interface Design Principles

## Typography
- Typography **IS** the design.
- Personality comes from weight, tracking, and font choice.
- **Monospace** for data. **High-weight** for headlines. **Readability** for body.

## Spacing & Hierarchy
- The **Squint Test**: Blur your eyes. Hierarchy should still be visible without harsh lines.
- Spacing conveys group membership. Elements that belong together should be closer.

## Color & Mood
- Color should feel like it came **FROM** a world, not applied **TO** a surface.
- Temperature axis is just the beginning; consider density, organic vs. geometric, etc.

## Code Standards
- Use CSS variables for everything.
- Semantic naming over functional naming (e.g., `--ink` over `--gray-900`).
- Group CSS changes via classes or `cssText` for batching.
