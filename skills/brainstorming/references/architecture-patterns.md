# Architecture Trade-Off Patterns

Use this reference when proposing options in Step 3 (Optioneering). Each pattern includes when to use it, when not to, and the honest cost of the choice.

---

## Monolith vs. Microservices

| | Monolith | Microservices |
|---|---|---|
| **Best for** | Single team, early-stage, unclear domain boundaries | Multiple teams, proven domain model, independent scaling needs |
| **Honest cost** | Harder to scale individual components; deploy everything for any change | Network latency, distributed transactions, ops complexity, debugging across services |
| **Default recommendation** | Start monolith, extract services when pain is real — not anticipated |

**Key question to ask:** "Do you have a team per service? If not, microservices add complexity without the organizational benefit."

---

## SQL vs. NoSQL

| | SQL (Postgres, MySQL) | Document (MongoDB, DynamoDB) | Key-Value (Redis) |
|---|---|---|---|
| **Best for** | Relational data, complex queries, ACID transactions | Flexible schema, nested documents, high write throughput | Caching, sessions, leaderboards, pub/sub |
| **Honest cost** | Schema migrations; joins slow at extreme scale | No joins; consistency tradeoffs; harder to query across documents | Data loss risk without persistence config; not for complex queries |
| **Default** | Postgres unless you have a specific reason not to |

---

## Synchronous vs. Asynchronous Processing

| | Synchronous | Asynchronous (Queue/Job) |
|---|---|---|
| **Best for** | User needs immediate result; simple linear flow | Long-running tasks; tasks that can fail and retry; decoupling producers from consumers |
| **Honest cost** | Caller blocks; timeout risk for slow operations | Added infrastructure (queue); harder to debug; eventual consistency |
| **When to switch** | If a task regularly takes >2-3s, make it async |

---

## Client-Side vs. Server-Side Rendering

| | CSR (React SPA) | SSR (Next.js, Remix) | SSG (Static) |
|---|---|---|---|
| **Best for** | Highly interactive apps, dashboards, logged-in experiences | SEO-critical pages, personalized content, first load performance | Marketing pages, docs, blogs — content that doesn't change per user |
| **Honest cost** | Poor SEO; slow first paint; JS bundle size | Server cost and complexity; harder caching | Build time increases with scale; stale content risk |

---

## Caching Patterns

**Cache-aside (lazy loading)**
- App checks cache first; on miss, loads from DB and populates cache
- Good for read-heavy data that's expensive to compute
- Risk: cache stampede on cold start; stale data

**Write-through**
- Write to cache and DB simultaneously
- Good for data that's written and read frequently
- Risk: more complex write path

**TTL-based invalidation**
- Set expiry on cache entries (e.g., 5 minutes)
- Good for data where slight staleness is acceptable
- Risk: users see outdated data for the TTL duration

**Event-based invalidation**
- Invalidate cache when source data changes (via event/webhook)
- Good when you need fresh data but can't afford to skip cache entirely
- Risk: events can be missed; complex to implement correctly

---

## Auth Patterns

| Pattern | Best for | Watch out for |
|---|---|---|
| **JWT (stateless)** | Distributed systems, mobile clients | Token revocation is hard; keep expiry short |
| **Session (stateful)** | Traditional web apps, when you need instant revocation | Session store is a single point of failure |
| **OAuth / OIDC** | Third-party auth (sign in with Google) | Complex flow; token refresh logic |
| **API Key** | Server-to-server, developer APIs | Rotation and scoping strategy needed |

---

## Choosing Between Options

When presenting 2-3 options, use this framing:

1. **Option A (Recommended)** — the option that minimizes risk for the current stage
2. **Option B** — the "scale-first" option that pays higher upfront cost for future flexibility
3. **Option C** — the "simplest thing that could work" option (sometimes this wins)

Always name what you're optimizing for: developer velocity, scalability, operational simplicity, cost, or user experience. Different optimization targets produce different right answers.
