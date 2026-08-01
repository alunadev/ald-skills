---
title: "Backend Structure — [FILL IN: Product Name]"
status: draft  # options: draft | approved
date: YYYY-MM-DD
---

# Backend Structure

> Database schema, auth logic, API contracts, and storage rules — the blueprint the agent
> builds the backend against instead of inventing its own. Keep this file exact: table names,
> column types, and endpoint shapes should be copy-pasteable into a migration or route handler.

## Database Schema

[FILL IN: every table, column, type, and relationship. If using Postgres/Supabase, paste the
exact SQL. If using a document DB, describe collections and document shape instead.]

```sql
-- Example — replace with real schema
create table [FILL IN table_name] (
  id uuid primary key default gen_random_uuid(),
  [FILL IN column] [FILL IN type] [FILL IN constraints],
  created_at timestamptz default now()
);
```

### Relationships

[FILL IN: foreign keys and how tables relate — one-to-many, many-to-many join tables, etc.]

## Authentication & Authorization

- **Auth method:** [FILL IN: email/password, magic link, OAuth providers, etc.]
- **Session strategy:** [FILL IN: JWT, httpOnly cookies, server sessions]
- **Roles / permissions:** [FILL IN: e.g., owner, member, admin — or "single-user, no roles"]
- **Row-level security / access rules:** [FILL IN: who can read/write which rows]

## API Endpoint Contracts

[FILL IN: every endpoint the frontend depends on. One block per endpoint.]

### `[FILL IN: METHOD /path]`

**Purpose:** [FILL IN]
**Auth required:** [Yes/No — role if applicable]
**Request:**
```json
{ "[FILL IN]": "[FILL IN]" }
```
**Response (success):**
```json
{ "[FILL IN]": "[FILL IN]" }
```
**Response (error):** [FILL IN: status codes and error shape]

---

### `[FILL IN: METHOD /path]`

[FILL IN — repeat per endpoint]

## Storage Rules

[FILL IN: file uploads — where stored, size/type limits, public vs private buckets, signed URLs.]

- **Provider:** [FILL IN]
- **Buckets/paths:** [FILL IN]
- **Access rules:** [FILL IN]

## Edge Cases & Data Integrity

| Scenario | Expected backend behavior |
|----------|---------------------------|
| [FILL IN: e.g., duplicate submission] | [FILL IN] |
| Concurrent writes to same row | [FILL IN] |
| Soft delete vs hard delete | [FILL IN] |

## Background Jobs / Webhooks

[FILL IN: any scheduled jobs, queues, or third-party webhooks the backend must handle, or "none".]
