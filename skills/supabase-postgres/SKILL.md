---
name: following-supabase-postgres-best-practices
description: Applies Supabase and PostgreSQL best practices for query performance, schema design, Row Level Security, and connection management. Use this skill when creating SQL queries, designing database schemas, implementing RLS policies, setting up real-time subscriptions, optimizing Postgres performance, writing Supabase Edge Functions, or reviewing any database-related code. Apply proactively — missing indexes and incorrect RLS policies are common and expensive to fix after data grows.
---

# Supabase + PostgreSQL Best Practices

A database schema is the most expensive thing to change later. Indexes can be added after the fact, but schema design, RLS policies, and connection architecture decisions have cascading effects on everything built on top. These 34 rules from Supabase Engineering cover the 8 categories most likely to cause production issues.

## Workflow

1. **Design the schema** — tables, types, constraints, naming before writing queries
2. **Set up RLS** — enable RLS on every table before exposing it to clients
3. **Add indexes** — identify query patterns and add indexes at schema creation time
4. **Configure connections** — set up Supabase's connection pooler (pgBouncer) from day one
5. **Review queries** — use `EXPLAIN ANALYZE` before adding to production

Output schema decisions to `docs/db/YYYY-MM-DD-[feature]-schema.md`.

---

## 1. Query Performance — CRITICAL

### Add Missing Indexes

Every column used in `WHERE`, `JOIN`, or `ORDER BY` clauses without an index causes a sequential scan — reading every row in the table.

```sql
-- Find queries without index support:
EXPLAIN ANALYZE
SELECT * FROM orders WHERE user_id = '123' AND status = 'active';
-- If you see "Seq Scan", add an index.

-- Add the index:
CREATE INDEX idx_orders_user_status ON orders(user_id, status);
```

### Composite Indexes (Correct Column Order)

In a composite index, column order matters. Put the highest-selectivity (most unique) columns first, then the filtering columns used in `WHERE`.

```sql
-- For query: WHERE status = 'active' AND created_at > '2024-01-01'
-- status has few distinct values; created_at has many.
-- created_at first is more selective:
CREATE INDEX idx_orders_created_status ON orders(created_at, status);
```

### Covering Indexes

A covering index includes all columns a query needs — the query can be satisfied from the index without reading the table (index-only scan).

```sql
-- For: SELECT user_id, total FROM orders WHERE status = 'active'
CREATE INDEX idx_orders_status_covering ON orders(status) INCLUDE (user_id, total);
```

### Partial Indexes

Index only the rows you actually query. A partial index on a subset of rows is smaller and faster than a full-table index.

```sql
-- If most queries only care about active orders:
CREATE INDEX idx_active_orders ON orders(created_at)
WHERE status = 'active';
-- Much smaller than indexing all orders
```

### Appropriate Index Types

PostgreSQL has multiple index types. B-tree (default) works for most cases, but specialized types are better for specific patterns.

```sql
-- B-tree (default): equality, range, ORDER BY
CREATE INDEX idx_orders_date ON orders(created_at);

-- GIN: array containment, JSONB, full-text search
CREATE INDEX idx_products_tags ON products USING GIN(tags);

-- BRIN: very large tables with naturally ordered data (logs, events)
CREATE INDEX idx_events_timestamp ON events USING BRIN(created_at);
```

### Full-Text Search

Use PostgreSQL's built-in full-text search with `tsvector` for text search. Don't use `LIKE '%query%'` — it can't use indexes.

```sql
-- Add a tsvector column:
ALTER TABLE articles ADD COLUMN fts tsvector
  GENERATED ALWAYS AS (
    to_tsvector('english', coalesce(title, '') || ' ' || coalesce(body, ''))
  ) STORED;

-- Create GIN index on it:
CREATE INDEX idx_articles_fts ON articles USING GIN(fts);

-- Query:
SELECT * FROM articles
WHERE fts @@ plainto_tsquery('english', 'postgres performance');
```

### JSONB Indexing

Index specific paths inside JSONB columns that appear in queries. Full-column GIN indexes are broad; expression indexes are precise.

```sql
-- For queries on metadata->>'status':
CREATE INDEX idx_products_metadata_status
  ON products ((metadata->>'status'));

-- For containment queries (@>):
CREATE INDEX idx_products_metadata_gin ON products USING GIN(metadata);
```

---

## 2. Connection Management — CRITICAL

### Use Connection Pooling

Every direct PostgreSQL connection uses ~5-10MB of memory on the server. In serverless environments (Next.js API routes, Vercel Functions), each invocation opens a new connection without pooling.

Use Supabase's Transaction Pooler (port 6543) for serverless:

```ts
// In Next.js / serverless — use the POOLED connection string
const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY!,
);
// Supabase JS client uses the REST API (not direct PG) by default — pooling is automatic
```

For direct Postgres access with Prisma or postgres.js:

```ts
// Use DIRECT_URL for migrations, DATABASE_URL for queries (pooled)
const client = postgres(process.env.DATABASE_URL!); // pgBouncer endpoint
```

### Respect Connection Limits

Default Supabase instances have 60-100 direct connections. Each concurrent request using a direct connection consumes one. Check your plan's limits and set `max_connections` accordingly in your pooler config.

### Idle Connection Timeouts

Set `statement_timeout` and `idle_in_transaction_session_timeout` to prevent runaway queries from holding connections.

```sql
-- In Supabase Dashboard → Database → Configuration:
-- statement_timeout: 30s (max query execution time)
-- idle_in_transaction_session_timeout: 30s (max time in idle transaction)
```

### Prepared Statements

Use prepared statements for frequently-executed queries to skip the parsing and planning phase.

```ts
import postgres from 'postgres';
const sql = postgres(process.env.DATABASE_URL!);

// Prepared statement (compiled once, executed many times):
const getUserById = sql`SELECT * FROM users WHERE id = ${userId}`;
```

---

## 3. Security & Row Level Security — CRITICAL

### Enable RLS on Every Table

Enable Row Level Security on every table before exposing it to client-side Supabase queries. Without RLS, any authenticated user can read/write any row.

```sql
-- Always enable RLS:
ALTER TABLE orders ENABLE ROW LEVEL SECURITY;

-- Then create policies:
CREATE POLICY "Users see own orders" ON orders
  FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users create own orders" ON orders
  FOR INSERT WITH CHECK (auth.uid() = user_id);
```

### RLS Performance

RLS policies are evaluated per-row. Expensive policies (subqueries, function calls) are evaluated for every row in a scan. Keep policies simple.

```sql
-- Expensive — subquery per row:
CREATE POLICY "Team members" ON documents
  FOR SELECT USING (
    EXISTS (SELECT 1 FROM team_members WHERE team_id = documents.team_id AND user_id = auth.uid())
  );

-- Better — join on pre-computed membership:
CREATE POLICY "Team members" ON documents
  FOR SELECT USING (
    team_id IN (SELECT team_id FROM team_members WHERE user_id = auth.uid())
  );
```

### Principle of Least Privilege

Grant only the permissions each role needs. Don't use the `service_role` key in client-side code — it bypasses RLS entirely.

```ts
// Client-side (respects RLS):
const supabase = createBrowserClient(url, anonKey);

// Server-side only (bypasses RLS — for admin operations):
const supabase = createClient(url, serviceRoleKey);
```

---

## 4. Schema Design — HIGH

### Primary Keys

Use UUIDs for primary keys in distributed systems. Use `gen_random_uuid()` as the default.

```sql
CREATE TABLE users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email TEXT UNIQUE NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
```

### Correct Data Types

Use the most specific type for each column. Wrong types prevent indexes, allow invalid data, and waste storage.

```sql
-- Use TIMESTAMPTZ (timezone-aware), not TIMESTAMP:
created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()

-- Use BOOLEAN, not VARCHAR:
is_active BOOLEAN NOT NULL DEFAULT true

-- Use appropriate numeric types:
price NUMERIC(10, 2) NOT NULL  -- for money
quantity INTEGER NOT NULL       -- for counts
```

### Constraints

Add `NOT NULL`, `UNIQUE`, `CHECK`, and foreign key constraints. They enforce data integrity at the database level — never rely on application code alone.

```sql
CREATE TABLE products (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL CHECK (char_length(name) > 0),
  price NUMERIC(10, 2) NOT NULL CHECK (price >= 0),
  status TEXT NOT NULL DEFAULT 'draft' CHECK (status IN ('draft', 'active', 'archived')),
  category_id UUID NOT NULL REFERENCES categories(id) ON DELETE RESTRICT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
```

### Lowercase Identifiers

Use `snake_case` for all table and column names. PostgreSQL lowercases unquoted identifiers — mixing cases causes surprises.

```sql
-- Good:
CREATE TABLE user_profiles (user_id UUID, display_name TEXT);

-- Bad — requires quoting everywhere:
CREATE TABLE "UserProfiles" ("userId" UUID, "displayName" TEXT);
```

### Foreign Key Indexes

Every foreign key column needs an index. PostgreSQL doesn't create them automatically, and joins on foreign keys without indexes cause sequential scans.

```sql
-- When you create a FK:
ALTER TABLE orders ADD CONSTRAINT fk_orders_user
  FOREIGN KEY (user_id) REFERENCES users(id);

-- Always add an index on the FK column:
CREATE INDEX idx_orders_user_id ON orders(user_id);
```

---

## 5. Concurrency & Locking — MEDIUM-HIGH

### Keep Transactions Short

Long-running transactions hold locks that block other operations. Minimize work inside transactions.

```ts
// Bad — external API call inside transaction:
await supabase.rpc('begin');
await fetchExternalAPI();   // blocks the transaction while waiting
await supabase.rpc('commit');

// Good — external call outside transaction:
const externalData = await fetchExternalAPI();
await supabase.from('records').insert({ ...externalData });
```

### Deadlock Prevention

When multiple transactions update the same rows, always acquire locks in a consistent order.

```sql
-- Both transactions must update user_id=1 first, then user_id=2:
UPDATE accounts SET balance = balance - 100 WHERE id = 1;
UPDATE accounts SET balance = balance + 100 WHERE id = 2;
```

### SKIP LOCKED for Queue Processing

For job queues, use `SKIP LOCKED` to allow parallel workers to process different jobs simultaneously without blocking each other.

```sql
-- Worker picks up next unprocessed job, skips locked ones:
WITH next_job AS (
  SELECT id FROM jobs
  WHERE status = 'pending'
  ORDER BY created_at
  FOR UPDATE SKIP LOCKED
  LIMIT 1
)
UPDATE jobs SET status = 'processing'
WHERE id = (SELECT id FROM next_job)
RETURNING *;
```

---

## 6. Data Access — MEDIUM

### Cursor-Based Pagination

Use cursor-based pagination for large tables. Offset-based (`OFFSET 1000 LIMIT 10`) reads and discards 1000 rows on every page beyond the first.

```sql
-- Cursor-based (efficient):
SELECT * FROM orders
WHERE created_at < $cursor_timestamp
ORDER BY created_at DESC
LIMIT 20;

-- Return the last item's created_at as the next cursor
```

### N+1 Prevention

Never run a query inside a loop. Fetch all related data in a single query with a join or `IN` clause.

```ts
// Bad — N+1 queries:
const orders = await supabase.from('orders').select('*');
for (const order of orders.data!) {
  const user = await supabase.from('users').select('*').eq('id', order.user_id).single();
}

// Good — single query with join:
const { data } = await supabase
  .from('orders')
  .select('*, users(id, name, email)');
```

### Batch Inserts

Insert multiple rows in a single statement. Each individual insert has round-trip overhead.

```ts
// Good — single round trip for all rows:
const { error } = await supabase
  .from('events')
  .insert([
    { type: 'click', metadata: { element: 'button' } },
    { type: 'view', metadata: { page: '/home' } },
    { type: 'submit', metadata: { form: 'signup' } },
  ]);
```

---

## 7. Monitoring — LOW-MEDIUM

### EXPLAIN ANALYZE

Before adding a query to production, run `EXPLAIN ANALYZE` to understand its execution plan. Look for Seq Scan on large tables and nested loop joins on large datasets.

```sql
EXPLAIN ANALYZE
SELECT o.*, u.email
FROM orders o
JOIN users u ON u.id = o.user_id
WHERE o.status = 'active'
ORDER BY o.created_at DESC
LIMIT 20;
```

In Supabase Dashboard: SQL Editor → run the query with `EXPLAIN ANALYZE` prepended.

### pg_stat_statements

Enable `pg_stat_statements` to track which queries run most frequently and take the most time.

```sql
-- In Supabase: already enabled by default
SELECT query, calls, mean_exec_time, total_exec_time
FROM pg_stat_statements
ORDER BY total_exec_time DESC
LIMIT 20;
```

### Regular VACUUM

PostgreSQL needs VACUUM to reclaim space from dead tuples (rows updated or deleted). Supabase runs autovacuum by default, but monitor tables with high update/delete rates.

```sql
-- Check tables that need manual attention:
SELECT schemaname, tablename, n_dead_tup, last_vacuum
FROM pg_stat_user_tables
WHERE n_dead_tup > 10000
ORDER BY n_dead_tup DESC;
```

---

## Output Format

Save schema decisions to `docs/db/YYYY-MM-DD-[feature]-schema.md`:

```markdown
# [Feature] Schema

## Tables
- `table_name` — [purpose]

## SQL
[CREATE TABLE statements]

## RLS Policies
[Policy definitions]

## Indexes
[Index definitions]

## Migration
[Steps to apply without downtime]
```

## Quality Checklist

- [ ] RLS enabled on every table accessible from client
- [ ] Every FK column has a corresponding index
- [ ] `created_at` and `updated_at` use `TIMESTAMPTZ NOT NULL DEFAULT NOW()`
- [ ] UUID primary keys using `gen_random_uuid()`
- [ ] No sequential scans on tables over 10k rows (verified with EXPLAIN ANALYZE)
- [ ] Batch inserts where inserting multiple rows
- [ ] `service_role` key not used in client-side code

## Common Antipatterns

- No index on foreign key columns
- Using OFFSET for pagination on large tables
- Selecting `*` when only a few columns are needed
- Running queries inside loops (N+1)
- `service_role` key in frontend code (bypasses RLS)
- Storing passwords, API keys, or secrets in database columns (use Supabase Vault)
- Missing `CHECK` constraints — relying on app code for data integrity
