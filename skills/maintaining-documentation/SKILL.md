---
name: maintaining-documentation
description: Manages the lifecycle of project documentation. Use when the user asks to update docs, after major feature changes, or before committing to GitHub to ensure the knowledge base remains the single source of truth.
---

# Documentation Maintenance Skill

## When to use this skill
- **Post-Feature:** Immediately after completing a feature (e.g., "Feature X is done").
- **Pre-Commit:** Before committing code to GitHub (to ensure docs match code).
- **On Request:** When the user explicitly asks to "update documentation" or "clean up docs".
- **Architecture Change:** When modifying DB schema, API routes, or core business logic.

## Canonical Structure
**Strict** file organization to prevent redundancy:

```
/docs/
├── agent.md                    # AI Context (Tech stack, conventions, business rules)
├── progress.txt                # Project status tracker (Features done, In progress)
├── product/
│   ├── prd.md                  # High-level requirements & feature status
│   ├── app-flow.md             # Navigation & User Flows (Mermaid diagrams)
│   └── sections/               # Detailed specs per feature
│       ├── inventory/spec.md   # Inventory specific US & AC
│       └── proposals/spec.md   # Proposals specific US & AC
├── system/
│   ├── data-consistency.md     # ⭐️ CORE TRUTH for calculations & state
│   ├── data-flow.md            # Data sources & visualization logic
│   ├── tech-stack.md           # Infrastructure & dependencies
│   ├── mock-data.json          # Canonical mock data source
│   └── backend-structure/      # DB Model & API structure
└── design-system/
    ├── guidelines.md           # Design tokens & rules
    └── design-system.json      # Structured tokens
```

## Update Workflow

### 1. Identify Scope of Change
- **UI/Nav Change?** → Update `APP-FLOW.md` + `design-system/`.
- **Business Logic?** → Update `data-consistency.md` + `sections/[feature]/spec.md`.
- **Database/API?** → Update `backend-structure/` + `tech-stack.md`.
- **New Feature?** → Update `prd.md` (status) + Create/Update `sections/[feature]/spec.md`.

### 2. Execution Steps
1.  **Check Redundancy:** Before writing, check if it exists in `data-consistency.md`. If so, **link to it**, do not duplicate.
2.  **Update Progress:** Mark relevant items in `progress.txt`.
3.  **Refine PRD:** Update status (e.g., 🚧 → ✅) in `prd.md`.
4.  **Verify Links:** Run a grep to ensure no broken links if files moved/renamed.

### 3. Golden Rules
- **One Truth:** `data-consistency.md` owns the math. `backend-structure/` owns the schema.
- **No Root Clutter:** Only `agent.md` and `progress.txt` live in `/docs/` root.
- **Link, Don't Copy:** If a logic exists in a spec, link to it from the PRD.

## Common Scenarios

### Scenario: "I just finished the Proposal Wizard"
1.  Open `docs/progress.txt` → Mark "Proposal creation wizard" as `[x]`.
2.  Open `docs/product/prd.md` → Update F5 status to `✅ Implemented`.
3.  Open `docs/product/sections/proposals/spec.md` → Verify implementation matches spec. Update spec if implementation diverged (and is better).

### Scenario: "We changed the inventory formula"
1.  **CRITICAL:** Open `docs/system/data-consistency.md`.
2.  Update the "Golden Formula".
3.  Search all other docs (`grep`) for the old formula and replace with a **link** to `data-consistency.md`.

### Scenario: "Cleanup documentation"
1.  List files in `/docs/`.
2.  Move any loose MD files to `product/` or `system/`.
3.  Delete any `temp_` or `old_` files.
4.  Run link audit.
