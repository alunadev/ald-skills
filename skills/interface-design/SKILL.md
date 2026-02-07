---
name: interface-design
description: Build interface design with craft and consistency for dashboards, admin panels, and SaaS tools. Generates intentional, non-generic designs by exploring product domains and creating signature elements.
---

# Interface Design Skill

Build interface design with craft and consistency. This skill focuses on dashboards, admin panels, SaaS apps, tools, settings pages, and data interfaces.

## When to use this skill
- Designing complex dashboards or admin interfaces
- Building data-dense SaaS tools
- Creating consistent design systems for software products
- **Note**: For landing pages or marketing sites, use `frontend-design` instead.

## Core Mandate: Avoid the Generic
Defaults are invisible traps. If your design looks like every other dashboard, you have failed. Every choice (typography, navigation, data presentation, token names) must be intentional and emerge from the specific product domain.

---

## Design Thinking Process

### 1. Intent First
Answer these before coding:
- **Who is this human?** (Specific persona, context, mental state)
- **What must they accomplish?** (Core verb: grade, debug, approve)
- **What should this feel like?** (Specific words: warm notebook, cold terminal, dense trading floor)

### 2. Product Domain Exploration
**Required Outputs before proposal:**
- **Domain**: 5+ concepts/vocabulary from the product's world.
- **Color World**: 5+ colors that exist naturally in this physical domain.
- **Signature**: One element (visual/structural) unique only to this product.
- **Defaults**: 3 obvious patterns to avoid.

### 3. Every Choice is a Choice
Explain WHY for:
- Layout, color temperature, typeface, spacing scale, hierarchy.
- **The Swap Test**: If you swapped the choice for a default and it didn't feel different, it wasn't a choice.

---

## Technical Principles

### Spacing & Padding
- Base unit multiples for consistency.
- Symmetrical padding unless specifically justified.

### Depth & Layering
Commit to ONE strategy:
1. **Borders-only**: Technical/Dense.
2. **Subtle shadows**: Approachable.
3. **Layered shadows**: Premium/Dimensional.
- **Subtle Layering**: Surface shifts should be "whisper-quiet".

### Colors
- Build from primitives: Foreground (text), Background (elevation), Border (separation), Brand, Semantic.
- No random hex values.

### Interaction & States
- Mandatory states: default, hover, active, focus, disabled.
- Data states: loading, empty, error.
- Fast micro-interactions (~150ms) with smooth easing.

---

## Workflow

### Initial Communication
1. Explore domain (Propose the 4 required outputs).
2. Propose direction (Connection to logic).
3. Confirm with user.

### Knowledge Management
- Look for `.interface-design/system.md` in project root.
- If it exists, follow it.
- After completing a task, offer to save patterns to `system.md` for persistence.

---

## Resources
- [See Principles & Values](resources/principles.md)
- [Validation & Memory Management](resources/validation.md)

## Commands
- `/interface-design:status`: Current system state
- `/interface-design:audit`: Check code against system
- `/interface-design:extract`: Extract patterns from code
