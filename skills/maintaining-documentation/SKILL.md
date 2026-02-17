---
name: maintaining-documentation
description: Maintains The Canonical Docs as single source of truth. Trigger after feature completion, before git push, on architecture changes, or explicit "update docs" requests. Skip for trivial changes (<10 LOC, no logic/schema/UI changes).
---

# Documentation Maintenance Skill

## When to use this skill

### ✅ ALWAYS Trigger
- **Post-Feature:** After completing any user story or AC
- **Pre-Commit:** Before `git push` if files changed in `/src`, `/app`, `/lib`, `/db`
- **Architecture Change:** DB schema, API contracts, auth logic modified
- **New Route/Page:** Any file added to `/app` directory
- **Design Token Change:** Modifications to colors, spacing, typography in code
- **Explicit Request:** User says "update docs", "sync documentation", "cleanup docs"

### ❌ NEVER Trigger
- Trivial changes (<10 lines, no business logic)
- Fixing typos in code comments
- Refactoring without behavior change
- Package updates in `package.json` (unless major version or new package)
- Test file additions (unless testing new features)

### ⚠️ ASK FIRST
- Experimental features (ask: "Should I document this now or wait until stable?")
- Breaking changes (ask: "Should I document the migration path?")
- Hotfixes (ask: "Update docs now or after proper solution?")

---

## Canonical Structure

```
/
├── CLAUDE.md                      # ⭐ AI reads FIRST every session
└── docs/
    ├── progress.txt               # Session memory bridge
    ├── product/
    │   ├── prd.md                 # Feature requirements + status
    │   ├── app-flow.md            # Navigation + user flows
    │   ├── product-overview.md    # Vision + goals
    │   ├── product-roadmap.md     # Planned features
    │   ├── sections/
    │   │   └── [section-id]/
    │   │       └── spec.md        # Detailed US + AC
    │   ├── shell/
    │   │   ├── spec.md            # Layout/nav spec
    │   │   └── components/        # Shell components
    │   └── types.ts               # Shared types
    ├── design-system/
    │   ├── guidelines.md          # Design rules (prose)
    │   ├── design-system.json     # Tokens (structured)
    │   ├── components.md          # Component library
    │   └── design-rules.md        # Optional constraints
    └── system/
        ├── tech-stack.md          # Dependencies (exact versions)
        ├── data-flow.md           # Data sources + viz logic
        ├── data-consistency.md    # ⭐ GOLDEN formulas
        ├── implementation-plan.md # Build sequence
        └── backend-structure/
            ├── backend-structure.md
            ├── database-model.md       # Schema + relations
            ├── architecture-overview.md
            ├── api-expectations.md     # Endpoint contracts
            ├── module-map.md           # Code organization
            └── auth-model.md           # Auth flows
```

---

## Decision Tree: What to Update

Use this deterministic tree to decide which docs need updates:

```
START
│
├─ Changed /app routes or pages?
│  ├─ YES → Update app-flow.md + progress.txt
│  │       └─ New feature? → Create sections/[id]/spec.md
│  └─ NO → Continue
│
├─ Changed DB schema or API?
│  ├─ YES → Update backend-structure/database-model.md
│  │       └─ API contracts changed? → Update api-expectations.md
│  │       └─ New dependencies? → Update tech-stack.md
│  └─ NO → Continue
│
├─ Changed business logic or calculations?
│  ├─ YES → Update data-consistency.md (GOLDEN SOURCE)
│  │       └─ grep all docs for old formula → Replace with LINK
│  └─ NO → Continue
│
├─ Changed UI components or design tokens?
│  ├─ YES → Update design-system.json tokens
│  │       └─ New component? → Update components.md
│  │       └─ Design rule changed? → Update guidelines.md
│  └─ NO → Continue
│
├─ Feature status changed?
│  ├─ YES → Update prd.md status (🚧 → ✅)
│  │       └─ Update progress.txt with [x]
│  └─ NO → Continue
│
└─ DONE
```

---

## Update Workflow

### Step 1: Session Start
```bash
# ALWAYS do this first
1. Read CLAUDE.md to load project context
2. Read progress.txt to understand current state
3. Ask: "What changed since last session?"
```

### Step 2: Determine Scope (use Decision Tree above)

### Step 3: Execute Updates

**For each file to update:**

1. **Check redundancy:** Does this info exist elsewhere?
   - If YES → Add link, don't duplicate
   - If NO → Proceed

2. **Update the file:**
   - Find exact section to modify
   - Make minimal, surgical change
   - Preserve existing structure

3. **Update cross-references:**
   - If file moved/renamed → `grep -r "old-name" docs/`
   - Fix all broken links

4. **Update progress.txt:**
   - Mark items [x] done
   - Add new items [ ] if needed

### Step 4: Validate
```bash
# Run these checks
1. grep -r "\[.*\](.*.md)" docs/  # Find all internal links
2. Check each link exists
3. Verify no duplicate content (same formula in 2 places)
4. Confirm progress.txt reflects reality
```

---

## Golden Rules

### Single Source of Truth
| Topic | Owner Document |
|-------|----------------|
| Calculations/formulas | `data-consistency.md` |
| DB schema | `backend-structure/database-model.md` |
| API contracts | `backend-structure/api-expectations.md` |
| Dependencies | `tech-stack.md` |
| Design tokens | `design-system.json` |
| User flows | `app-flow.md` |

**Rule:** If info exists in owner doc → Link to it. Never copy.

### File Placement
- ❌ **Never** put loose .md files in `/docs/` root
- ✅ **Always** organize under `product/`, `system/`, or `design-system/`
- ✅ **Exception:** Only `CLAUDE.md` (root), `progress.txt` (docs/)

### CLAUDE.md Priority
- CLAUDE.md is AI's operating manual
- Update it when conventions change
- Keep it under 2000 words (AI loads it every session)

### Progress.txt Discipline
- Update EVERY feature completion
- Format: `[x] Feature name - Brief status`
- Acts as session memory bridge

---

## Common Scenarios

### Scenario 1: "Feature X is complete"
```
Trigger: Post-feature
Files to check:
1. progress.txt → Mark [x]
2. prd.md → Update status to ✅
3. sections/X/spec.md → Verify spec matches implementation
4. app-flow.md → If new routes added
5. data-consistency.md → If formulas involved
```

### Scenario 2: "Changed DB schema"
```
Trigger: Architecture change
Files to update:
1. backend-structure/database-model.md → Document new schema
2. backend-structure/api-expectations.md → If endpoints changed
3. tech-stack.md → If new DB packages added
4. progress.txt → Record change
```

### Scenario 3: "Added /dashboard/analytics page"
```
Trigger: New route
Files to update:
1. app-flow.md → Add route + user flow description
2. progress.txt → Add to completed
3. sections/analytics/spec.md → Create if new feature domain
4. prd.md → If this fulfills a requirement
```

### Scenario 4: "Changed button radius from 16px to 12px"
```
Trigger: Design token change
Files to update:
1. design-system.json → Update radius-button token
2. design-system/guidelines.md → Update if explanation needed
3. DO NOT update individual component files (they reference tokens)
```

### Scenario 5: "Formula for inventory calculation changed"
```
Trigger: Business logic change
Files to update:
1. data-consistency.md → Update THE formula (golden source)
2. Run: grep -r "old formula pattern" docs/
3. Replace all occurrences with LINK to data-consistency.md
4. sections/inventory/spec.md → Link to data-consistency.md
```

### Scenario 6: "Cleanup documentation"
```
Trigger: Explicit request
Actions:
1. find docs/ -name "*.md" -type f
2. Check each file against canonical structure
3. Move misplaced files to correct folders
4. rm temp_*.md old_*.md backup_*.md
5. Run link audit: grep -r "\[.*\](.*.md)" docs/
6. Fix broken links
7. Report summary of changes
```

### Scenario 7: "Starting new session"
```
Trigger: Session start
Actions:
1. Read CLAUDE.md first (AI context)
2. Read progress.txt (what's done/in-progress)
3. Ask user: "What are we working on today?"
4. Proceed with work
```

---

## Pre-Commit Checklist

Before `git push`, verify:

```
[ ] progress.txt updated?
[ ] Feature status in prd.md reflects reality?
[ ] Relevant spec files synced with implementation?
[ ] New pages documented in app-flow.md?
[ ] Design changes in design-system/?
[ ] Backend changes in backend-structure/?
[ ] No broken internal links? (grep check)
[ ] No duplicate content? (same info in 2+ places)
[ ] CLAUDE.md updated if conventions changed?
```

---

## Validation Commands

Run these to verify docs health:

```bash
# Find all internal markdown links
grep -r "\[.*\](.*.md)" docs/

# Find potential duplicates (same heading in multiple files)
grep -r "^## " docs/ | sort | uniq -d

# Find files not in canonical structure
find docs/ -maxdepth 1 -name "*.md" ! -name "progress.txt"

# Check for TODO/FIXME in docs
grep -r "TODO\|FIXME" docs/
```

---

## Error Prevention

### Common Mistakes to Avoid

1. **Updating latest instead of best**
   - ❌ Always updating the newest file
   - ✅ Check if older version has better info

2. **Duplicating instead of linking**
   - ❌ Copying formula to multiple docs
   - ✅ Reference data-consistency.md

3. **Forgetting progress.txt**
   - ❌ Only updating specs
   - ✅ Always update progress.txt too

4. **Breaking links when moving files**
   - ❌ Moving file without updating references
   - ✅ grep for all references first

5. **Over-documenting trivial changes**
   - ❌ Updating docs for 2-line fix
   - ✅ Use "When NOT to use" criteria

---

## Success Metrics

After using this skill, docs should be:

✅ **Consistent** - No contradictions between files  
✅ **Complete** - All implemented features documented  
✅ **Current** - Reflects actual codebase state  
✅ **Linked** - Cross-references work, no duplicates  
✅ **Organized** - Files in correct canonical folders  
✅ **Accessible** - CLAUDE.md + progress.txt provide entry points
