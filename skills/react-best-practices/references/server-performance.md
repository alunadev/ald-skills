# Server-Side Performance Rules

Source: Vercel Engineering / vercel-labs agent-skills

These rules apply to React Server Components, Next.js App Router pages, and server actions. Server code runs per-request — inefficiencies here multiply across every user.

---

## server-auth-actions

Authenticate server actions the same way you authenticate API routes. A server action without auth checks is an unprotected endpoint.

```tsx
// In every server action:
export async function updateItem(id: string, data: unknown) {
  const session = await getSession();
  if (!session?.user) throw new Error('Unauthorized');
  // ... proceed
}
```

Why: Next.js server actions are HTTP POST endpoints. Relying on UI-level guards is not sufficient — any client can call them directly.

---

## server-cache-react

Use `React.cache()` to deduplicate identical data fetches within a single render tree. This is per-request memoization — the cache resets between requests.

```tsx
import { cache } from 'react';

export const getUser = cache(async (id: string) => {
  return db.user.findUnique({ where: { id } });
});

// Now calling getUser(id) in Layout and Page fetches once, not twice
```

Why: Without `React.cache()`, two components that both call `getUser(id)` in the same render will make two database queries. `React.cache()` makes the second call a no-op within the same render.

---

## server-cache-lru

Use an LRU (Least Recently Used) cache for data that's stable across requests but too expensive to fetch per-request. Appropriate for config data, CMS content, feature flags with short TTLs.

```tsx
import LRU from 'lru-cache';

const cache = new LRU<string, Config>({ max: 100, ttl: 1000 * 60 * 5 }); // 5 min TTL

export async function getConfig(key: string): Promise<Config> {
  if (cache.has(key)) return cache.get(key)!;
  const config = await fetchConfig(key);
  cache.set(key, config);
  return config;
}
```

Why: `React.cache()` resets per request. For data that rarely changes (e.g., site configuration fetched 1000x/minute), an LRU cache at module level dramatically reduces external calls.

---

## server-dedup-props

Avoid passing the same data from a Server Component to multiple Client Components separately. Serialize once, share via context or by passing to a single parent Client Component.

```tsx
// Instead of:
<ClientA user={user} /> <ClientB user={user} />

// Pass to a single boundary:
<UserProvider user={user}>
  <ClientA /> <ClientB />
</UserProvider>
```

Why: Each prop crossing the Server→Client boundary is serialized to JSON and sent over the wire. Duplicate data means duplicate payload.

---

## server-hoist-static-io

Load static resources (fonts, default images, static configuration) at module level, not inside render functions. Module-level code runs once per server instance, not per request.

```tsx
// Bad — reads file on every request:
async function Page() {
  const defaultAvatar = await readFile('./public/default-avatar.png');
  // ...
}

// Good — reads once at startup:
const defaultAvatar = await readFile('./public/default-avatar.png');

async function Page() {
  // use defaultAvatar directly
}
```

Why: `fs` operations, font loading, and static asset reads inside render functions add latency to every request. Module-level initialization happens once.

---

## server-serialization

Only pass data to Client Components that the client actually renders or needs for interactivity. Large objects with unused fields inflate the HTML payload unnecessarily.

```tsx
// Instead of:
<ClientComponent product={fullProductObject} /> // 50 fields

// Select only what's needed:
<ClientComponent
  name={product.name}
  price={product.price}
  imageUrl={product.imageUrl}
/>
```

Why: Server Component props are embedded in the HTML as serialized JSON (the RSC payload). Unnecessary fields increase page weight and time to hydration.

---

## server-parallel-fetching

Restructure Server Components to initiate multiple fetches in parallel rather than sequentially. Move `await` to the latest possible point — after all fetches have started.

```tsx
// Sequential — 300ms + 200ms = 500ms total:
const user = await getUser(id);
const orders = await getOrders(id);

// Parallel — max(300ms, 200ms) = 300ms total:
const userPromise = getUser(id);
const ordersPromise = getOrders(id);
const [user, orders] = await Promise.all([userPromise, ordersPromise]);
```

Why: I/O operations run independently on the server. Sequential awaits serialize what could run concurrently, adding unnecessary latency.

---

## server-after-nonblocking

Use Next.js `after()` (available in Next.js 15+) for operations that should happen after the response is sent — analytics, logging, cache invalidation — without blocking the response.

```tsx
import { after } from 'next/server';

export async function POST(request: Request) {
  const data = await processRequest(request);

  after(async () => {
    await analytics.track('form_submitted', { data });
    await invalidateCache('dashboard');
  });

  return Response.json({ success: true }); // Returns immediately
}
```

Why: Analytics calls, cache warming, and audit logging don't need to complete before the user gets a response. Blocking on them adds latency without user-visible benefit.
