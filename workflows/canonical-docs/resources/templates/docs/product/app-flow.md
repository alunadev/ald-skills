---
title: "App Flow — [FILL IN: Product Name]"
status: draft  # options: draft | approved
date: YYYY-MM-DD
---

# App Flow

## Navigation Structure

[FILL IN: High-level navigation tree. What are the main areas of the app?]

```
App
├── [Area 1]
│   ├── [Page/Screen]
│   └── [Page/Screen]
├── [Area 2]
└── [Area 3]
```

## Core User Flows

### Flow 1: [FILL IN: Name of primary action, e.g., "Onboarding"]

[FILL IN: Describe the flow step by step. Include entry point, steps, and exit point.]

Entry point: [FILL IN]

1. [FILL IN: step]
2. [FILL IN: step]
3. [FILL IN: step]

Exit: [FILL IN: what happens after the flow completes]

---

### Flow 2: [FILL IN: Name of secondary action]

Entry point: [FILL IN]

1. [FILL IN]
2. [FILL IN]

Exit: [FILL IN]

---

## Auth Flow

[FILL IN: How does the user sign up / log in? What happens on first visit vs returning visit?]

- **New user:** [FILL IN]
- **Returning user:** [FILL IN]
- **Unauthenticated access:** [FILL IN: what can they see without logging in?]

## Error States & Edge Cases

| Scenario | What the user sees |
|----------|--------------------|
| [FILL IN] | [FILL IN] |
| Network error | [FILL IN] |
| Empty state (first time) | [FILL IN] |

## Key Routes

| Route | Page | Auth required |
|-------|------|---------------|
| `/` | [FILL IN] | No |
| `/dashboard` | [FILL IN] | Yes |
| `[FILL IN]` | [FILL IN] | [Yes/No] |
