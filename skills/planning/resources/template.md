# Strict Planning Template

Every implementation plan MUST follow this structure to ensure it is actionable and testable.

## 1. Document Header
```markdown
# [Feature Name] Implementation Plan

**Goal:** [One sentence describing what this builds]
**Architecture:** [2-3 sentences about approach]
**Tech Stack:** [Key technologies/libraries]

---
```

## 2. Task Structure (The "Bite-Sized" Rule)
Each task must be atomic (one action, one commit).

```markdown
### Task N: [Component Name]

**Files:**
- Create: `exact/path/to/file.py`
- Modify: `exact/path/to/existing.py:123-145`
- Test: `tests/exact/path/to/test.py`

**Step 1: Write the failing test**
```python
def test_specific_behavior():
    result = function(input)
    assert result == expected
```

**Step 2: Verify Failure**
Run: `pytest tests/path/test.py::test_name`
Expected: FAIL

**Step 3: Minimal Implementation**
```python
def function(input):
    return expected
```

**Step 4: Verify Success**
Run: `pytest tests/path/test.py::test_name`
Expected: PASS

**Step 5: Commit**
```bash
git add .
git commit -m "feat: description of task N"
```
```

## 3. Mandatory Inclusions
1.  **Exact File Paths:** Never say "component folder", say `src/components/Button.tsx`.
2.  **Test Commands:** Provide the exact command to run the specific test case.
3.  **Negative Paths:** Include tests for error states, not just the happy path.
