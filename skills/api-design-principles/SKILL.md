---
name: designing-api-principles
description: Designs REST and GraphQL APIs following production best practices for resource naming, error handling, versioning, authentication, and documentation. Use this skill when designing new API endpoints, reviewing API contracts, implementing GraphQL schemas, establishing API conventions for a project, or writing API documentation. Apply when creating any route in Next.js API routes or route handlers, any Supabase Edge Function, or any backend endpoint — even if it starts small, these patterns prevent painful rewrites later.
---

# API Design Principles

An API is a contract. Once external clients depend on it, changing it is expensive. Getting the contract right from the start — consistent naming, predictable errors, proper versioning, and accurate documentation — saves far more time than writing the code itself.

## Workflow

1. **Define the resource** — what noun does this API expose?
2. **Map operations to HTTP verbs** — what actions do clients need?
3. **Design the request/response shapes** — agree on the contract before writing code
4. **Define error cases** — what can go wrong and how will it be communicated?
5. **Document with OpenAPI** — the spec is the source of truth
6. **Implement** — the code follows the spec, not the other way around

Output the API design to `docs/api/YYYY-MM-DD-[resource]-api.md` before implementation.

---

## REST Design

### Resource Naming

Resources are nouns, always plural. URLs identify resources; HTTP verbs describe actions on them.

```
GET    /users          — list users
GET    /users/:id      — get one user
POST   /users          — create a user
PUT    /users/:id      — replace a user
PATCH  /users/:id      — partial update
DELETE /users/:id      — delete a user
```

Nested resources for belongsTo relationships:

```
GET  /users/:userId/orders         — user's orders
POST /users/:userId/orders         — create order for user
GET  /users/:userId/orders/:id     — specific order
```

Avoid verbs in URLs: `/getUser`, `/createOrder`, `/deleteAccount` are wrong. The verb is the HTTP method.

### HTTP Status Codes

Use the right status code — don't always return 200.

| Code | Meaning | When to use |
|------|---------|-------------|
| 200 | OK | Successful GET, PATCH |
| 201 | Created | Successful POST that created a resource |
| 204 | No Content | Successful DELETE or action with no body |
| 400 | Bad Request | Validation error, malformed request |
| 401 | Unauthorized | Not authenticated |
| 403 | Forbidden | Authenticated but not permitted |
| 404 | Not Found | Resource doesn't exist |
| 409 | Conflict | Duplicate, stale optimistic lock |
| 422 | Unprocessable Entity | Business logic validation failure |
| 429 | Too Many Requests | Rate limit exceeded |
| 500 | Internal Server Error | Unexpected server error |

### Consistent Error Format

All errors return a consistent JSON shape. Clients can rely on a single error parsing pattern.

```ts
interface ApiError {
  error: string;        // machine-readable code: "VALIDATION_ERROR"
  message: string;      // human-readable: "Email is required"
  details?: Record<string, string[]>; // field-level errors for validation
  requestId?: string;   // for support correlation
}
```

```json
// 422 response:
{
  "error": "VALIDATION_ERROR",
  "message": "Request validation failed",
  "details": {
    "email": ["Email is required", "Must be a valid email address"],
    "name": ["Name must be at least 2 characters"]
  }
}
```

### Pagination

Use cursor-based pagination for large, frequently-updated datasets. Offset-based pagination (`?page=2&limit=10`) is unreliable when items are added or removed between requests.

```ts
// Request:
GET /api/users?cursor=eyJpZCI6MTAwfQ&limit=20

// Response:
{
  "data": [...],
  "pagination": {
    "cursor": "eyJpZCI6MTIwfQ",  // opaque cursor for next page
    "hasMore": true,
    "total": 847                  // optional, expensive to compute
  }
}
```

Cursor is a base64-encoded pointer (e.g., the last item's ID or timestamp).

### Filtering and Sorting

Accept filters and sort via query parameters. Keep it consistent.

```
GET /api/products?status=active&category=electronics
GET /api/orders?sort=createdAt:desc&sort=total:asc
GET /api/users?search=john&role=admin
```

Validate filter values server-side — never pass raw query params to database queries.

### Versioning

Choose one versioning strategy and apply it consistently. URL-based is most explicit and easiest to debug.

**URL-based (recommended for REST):**
```
/api/v1/users
/api/v2/users
```

**Header-based:**
```
API-Version: 2024-01
```

**Query parameter:**
```
/api/users?version=2
```

Maintain old versions for at least 6 months after deprecation. Communicate deprecations via response headers: `Deprecation: Sun, 01 Jan 2025 00:00:00 GMT`.

### Authentication

Use Bearer tokens in the Authorization header. Never put tokens in URLs (they appear in server logs).

```
Authorization: Bearer eyJhbGciOiJIUzI1NiJ9...
```

For Next.js route handlers with Supabase:

```ts
export async function GET(request: Request) {
  const supabase = createRouteHandlerClient({ cookies });
  const { data: { session } } = await supabase.auth.getSession();

  if (!session) {
    return Response.json({ error: 'UNAUTHORIZED', message: 'Authentication required' }, { status: 401 });
  }

  // ... handle request
}
```

---

## GraphQL Design

### Schema-First Development

Write the GraphQL schema before writing resolvers. The schema is the contract — review it before writing any code.

```graphql
type User {
  id: ID!
  email: String!
  name: String!
  createdAt: DateTime!
  orders(first: Int, after: String): OrderConnection!
}

type Query {
  user(id: ID!): User
  users(first: Int, after: String, filter: UserFilter): UserConnection!
}

type Mutation {
  createUser(input: CreateUserInput!): CreateUserPayload!
  updateUser(id: ID!, input: UpdateUserInput!): UpdateUserPayload!
}
```

### Cursor-Based Pagination (Relay Spec)

Follow the Relay Cursor Connections specification for consistency with GraphQL tooling.

```graphql
type UserConnection {
  edges: [UserEdge!]!
  pageInfo: PageInfo!
}

type UserEdge {
  node: User!
  cursor: String!
}

type PageInfo {
  hasNextPage: Boolean!
  hasPreviousPage: Boolean!
  startCursor: String
  endCursor: String
}
```

### DataLoader for N+1 Prevention

Batch and cache per-request data fetching with DataLoader. Without it, fetching 100 users' orders fires 100 separate queries.

```ts
import DataLoader from 'dataloader';

const orderLoader = new DataLoader(async (userIds: readonly string[]) => {
  const orders = await db.order.findMany({
    where: { userId: { in: [...userIds] } },
  });
  // Return orders grouped by userId, in the same order as userIds:
  return userIds.map(id => orders.filter(o => o.userId === id));
});

// In User resolver:
const User = {
  orders: (user: User) => orderLoader.load(user.id), // batched automatically
};
```

### Error Handling in GraphQL

Use GraphQL errors for field-level failures; use HTTP 200 with `errors` array for partial failures; reserve non-200 HTTP responses for transport-level errors.

```json
{
  "data": { "user": null },
  "errors": [
    {
      "message": "User not found",
      "extensions": { "code": "NOT_FOUND", "userId": "123" },
      "path": ["user"]
    }
  ]
}
```

---

## Validation and Security

### Zod Schema Validation

Validate all request bodies and query parameters with Zod before processing. Never trust input.

```ts
import { z } from 'zod';

const CreateUserSchema = z.object({
  email: z.string().email(),
  name: z.string().min(2).max(100),
  role: z.enum(['admin', 'user']).default('user'),
});

export async function POST(request: Request) {
  const body = await request.json();
  const result = CreateUserSchema.safeParse(body);

  if (!result.success) {
    return Response.json({
      error: 'VALIDATION_ERROR',
      message: 'Invalid request body',
      details: result.error.flatten().fieldErrors,
    }, { status: 422 });
  }

  const user = await createUser(result.data);
  return Response.json(user, { status: 201 });
}
```

### Rate Limiting

Apply rate limiting to all public endpoints. For Next.js, use Upstash Rate Limit or a middleware-level solution.

```ts
import { Ratelimit } from '@upstash/ratelimit';
import { Redis } from '@upstash/redis';

const ratelimit = new Ratelimit({
  redis: Redis.fromEnv(),
  limiter: Ratelimit.slidingWindow(10, '10 s'), // 10 requests per 10 seconds
});

// In route handler:
const ip = request.headers.get('x-forwarded-for') ?? 'anonymous';
const { success } = await ratelimit.limit(ip);

if (!success) {
  return Response.json({ error: 'RATE_LIMIT_EXCEEDED' }, { status: 429 });
}
```

### CORS Configuration

Configure CORS restrictively — only allow origins that need access. Wildcard CORS (`Access-Control-Allow-Origin: *`) is appropriate only for truly public APIs.

```ts
const ALLOWED_ORIGINS = [
  'https://myapp.com',
  'https://www.myapp.com',
  process.env.NODE_ENV === 'development' ? 'http://localhost:3000' : null,
].filter(Boolean);

function setCorsHeaders(request: Request, response: Response) {
  const origin = request.headers.get('origin');
  if (ALLOWED_ORIGINS.includes(origin)) {
    response.headers.set('Access-Control-Allow-Origin', origin!);
  }
}
```

---

## Documentation

Document APIs with OpenAPI 3.1 before implementation. The spec is the contract — store in `docs/api/openapi.yaml`.

```yaml
openapi: 3.1.0
info:
  title: My App API
  version: 1.0.0

paths:
  /api/users:
    get:
      summary: List users
      parameters:
        - name: cursor
          in: query
          schema: { type: string }
        - name: limit
          in: query
          schema: { type: integer, default: 20, maximum: 100 }
      responses:
        '200':
          description: Paginated list of users
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/UserListResponse'
```

## Output Format

Save API design decisions to `docs/api/YYYY-MM-DD-[resource]-api.md`:

```markdown
# [Resource] API Design

## Resources
- `GET /api/[resource]` — [description]

## Request Schema
[Zod schema or TypeScript type]

## Response Schema
[TypeScript interface]

## Error Cases
| Status | Code | Condition |
|--------|------|-----------|
| 422 | VALIDATION_ERROR | ... |

## Open Questions
- [ ] Question 1
```

## Quality Checklist

- [ ] Resource names are plural nouns, no verbs in URLs
- [ ] Consistent error format with `error` + `message` + `details`
- [ ] Correct HTTP status codes (201 for creates, 204 for deletes)
- [ ] All inputs validated with Zod before processing
- [ ] Authentication checked before business logic
- [ ] Pagination uses cursor-based approach
- [ ] OpenAPI spec written before implementation

## Common Antipatterns

- Verbs in URLs: `/api/getUser`, `/api/createOrder`
- Always returning 200 even for errors
- Raw database errors exposed in 500 responses (leak schema info)
- No validation — trusting client-provided data
- Offset-based pagination for frequently-updated data
- `any` type for request bodies in TypeScript
