# Strategy Frameworks Reference

Quick reference for the frameworks used in the `product-strategy` skill. Each section includes when to use it, the format, and a worked example.

---

## 1. North Star Metric + Input Metrics Tree

**When to use:** Always. This is the foundation of any product strategy.

**The North Star test (ask these 3 questions):**
1. Does it measure value to users (not just to the company)?
2. Can the whole team influence it?
3. Is it a lagging indicator (moves slowly but meaningfully)?

**Good North Stars by product type:**

| Product Type | North Star Example |
|---|---|
| Marketplace | Transactions where both sides rated each other ≥4 stars |
| SaaS | Weekly teams with ≥3 members who complete a core workflow |
| Consumer app | Users who return in week 2 after signup |
| Media | Subscribers who read ≥3 articles per week |

**The Input Metric Tree:**
```
North Star: Weekly active teams (≥3 members, completed ≥1 workflow)
│
├── Input 1: New team creation rate (acquisition)
├── Input 2: Day-1 activation rate (onboarding — first workflow completed)
├── Input 3: Week-2 return rate (early retention)
└── Input 4: Invitation acceptance rate (virality — team size growth)
```

---

## 2. Opportunity Tree (Teresa Torres)

**When to use:** When you need to prioritize between multiple user problems or product areas.

**The structure:**
```
Desired Outcome (= North Star or key input metric)
├── Opportunity 1 (user problem / unmet need)
│   ├── Solution A (experiment/feature)
│   └── Solution B (experiment/feature)
├── Opportunity 2
│   ├── Solution C
│   └── Solution D
└── Opportunity 3
    └── Solution E
```

**Rules:**
- Opportunities = problems users have, not solutions
- Solutions = experiments you run to address the opportunity
- Map opportunities before jumping to solutions
- Don't force all solutions through one opportunity

**Prioritization formula:**
```
Priority Score = Importance + (Importance - Satisfaction)

Where:
- Importance (1-5): How critical is this problem to the user?
- Satisfaction (1-5): How well does the current solution address it?

High importance + low satisfaction = biggest opportunity
```

**Example:**
| Opportunity | Importance | Satisfaction | Score |
|---|---|---|---|
| "I can't find past conversations" | 5 | 2 | 5 + (5-2) = 8 |
| "Notifications are overwhelming" | 4 | 1 | 4 + (4-1) = 7 |
| "Hard to know who's responsible" | 4 | 3 | 4 + (4-3) = 5 |

---

## 3. OKRs (Objectives and Key Results)

**When to use:** When you need to translate a strategy bet into a quarterly execution plan.

**Structure:**
```
Objective: [Qualitative, inspirational direction]
  Key Result 1: [Specific metric] from [X] to [Y] by [date]
  Key Result 2: [Specific metric] from [X] to [Y] by [date]
  Key Result 3: [Specific metric] from [X] to [Y] by [date]

Initiatives (how):
  - [Initiative] → expected to move KR[X] by [delta]
```

**Quality rules:**
- Objectives should make you slightly uncomfortable — if you're 100% sure you'll hit it, it's not ambitious enough
- Key Results are binary (hit/miss) at the end — no "we got halfway there"
- Initiatives explain HOW you'll hit KRs — they can change mid-quarter, KRs should not
- 3 KRs max per objective. If you have 6, you're listing tasks, not outcomes

**Good vs Bad KRs:**

| Bad (output) | Good (outcome) |
|---|---|
| Launch 3 new features | Increase D30 retention from 42% to 52% |
| Run 5 user interviews | Identify top 3 unmet needs for segment X |
| Redesign onboarding | Increase day-1 activation rate from 31% to 45% |
| Write strategy doc | Get strategy approved by [exec] by [date] |

---

## 4. Jobs-to-be-Done (JTBD) as Strategic Lens

**When to use:** When building the Opportunity Tree or when user research is available.

**The core question:** "What job is the user hiring this product to do?"

**JTBD format:**
```
When [situation], I want to [motivation], so I can [expected outcome].
```

**Examples:**
- When I need to share a decision with my team, I want to present the context quickly, so I can get alignment without a long meeting.
- When I'm debugging an issue in production, I want to understand the root cause fast, so I can minimize user impact.
- When I'm planning next quarter, I want to see what's working and what's not, so I can make the right bets.

**Using JTBD for strategy:**
1. List the top 5 jobs your users are hiring your product for
2. Rate how well you serve each job today (1-5 satisfaction)
3. Rate how important each job is (1-5 importance)
4. High importance + low satisfaction = highest strategic priority

---

## 5. Positioning Statement (Geoffrey Moore)

**When to use:** When entering a new market, segment, or when differentiation from competitors is a strategic question.

**Format:**
```
For [target customer]
who [have this problem / need],
[Product Name] is a [category]
that [key benefit / differentiation].
Unlike [primary alternative],
our product [key differentiator].
```

**Example:**
```
For senior PMs at mid-size SaaS companies
who struggle to connect user research to product decisions,
Discovery OS is a product management platform
that turns unstructured user insights into prioritized opportunity trees.
Unlike Notion or Confluence,
our product automates the synthesis of interviews into actionable evidence.
```

**Rules:**
- Be specific about the target customer — "anyone who wants to be more productive" is not a positioning statement
- Name the primary alternative — this forces you to articulate real differentiation
- The key differentiator should be something you're uniquely good at, not a generic claim

---

## Further Reading

- Teresa Torres — *Continuous Discovery Habits* (Opportunity Tree source)
- John Doerr — *Measure What Matters* (OKRs)
- Clayton Christensen — *Competing Against Luck* (JTBD)
- Geoffrey Moore — *Crossing the Chasm* (Positioning)
- Shreyas Doshi — North Star Metric framework (Twitter/X thread series)
