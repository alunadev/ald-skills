# Performance & Navigation

Source: Vercel Engineering / vercel-labs web-interface-guidelines

---

## Performance

### Virtualize Long Lists

Lists with more than 50 items should be virtualized — only render the items visible in the viewport. Rendering 1000 DOM nodes for a list the user can only see 10 items of at a time wastes memory and slows scrolling.

```tsx
import { useVirtualizer } from '@tanstack/react-virtual';

function VirtualList({ items }: { items: Item[] }) {
  const parentRef = useRef<HTMLDivElement>(null);

  const virtualizer = useVirtualizer({
    count: items.length,
    getScrollElement: () => parentRef.current,
    estimateSize: () => 56, // estimated item height in px
  });

  return (
    <div ref={parentRef} style={{ height: '400px', overflow: 'auto' }}>
      <div style={{ height: virtualizer.getTotalSize() }}>
        {virtualizer.getVirtualItems().map(vItem => (
          <div
            key={vItem.key}
            style={{
              position: 'absolute',
              top: vItem.start,
              height: vItem.size,
              width: '100%',
            }}
          >
            <ItemRow item={items[vItem.index]} />
          </div>
        ))}
      </div>
    </div>
  );
}
```

Libraries: `@tanstack/react-virtual`, `react-window`, `react-virtual`.

### preconnect for Third-Party Origins

Add `<link rel="preconnect">` for third-party origins used on the page (analytics, fonts, CDNs). This establishes the TCP connection before the browser needs it, reducing request latency.

```html
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link rel="preconnect" href="https://api.segment.io" />
```

In Next.js, add to the `<Head>` component or in `app/layout.tsx`.

### preload Critical Fonts

Preload the font files used in the above-the-fold content. Without preloading, the browser discovers the font after parsing CSS, causing FOUT (Flash of Unstyled Text).

```html
<link
  rel="preload"
  href="/fonts/Inter-Regular.woff2"
  as="font"
  type="font/woff2"
  crossorigin
/>
```

Only preload fonts actually used in the initial viewport. Preloading everything defeats the purpose.

In Next.js with `next/font`, this is handled automatically.

### Code Splitting

Split your bundle by route automatically (Next.js does this by default in the App Router) and by feature for heavy components.

```tsx
// Load the PDF viewer only when the user requests it:
const PDFViewer = dynamic(() => import('@/components/PDFViewer'), {
  loading: () => <Skeleton height={600} />,
  ssr: false,
});

function Page() {
  const [showPDF, setShowPDF] = useState(false);
  return (
    <>
      <button onClick={() => setShowPDF(true)}>View PDF</button>
      {showPDF && <PDFViewer />}
    </>
  );
}
```

### Resource Hints for Navigation

Preload data for likely next navigations using `<link rel="prefetch">` or Next.js's `<Link prefetch>`. This loads the resource in the background while the user is still reading the current page.

```tsx
// Next.js Link prefetches automatically on hover in production.
// For manual control:
<Link href="/dashboard" prefetch={true}>Dashboard</Link>
```

---

## Navigation & State

### URL Reflects State

Filter state, search queries, active tabs, pagination, and sort order should be reflected in the URL. If a user copies and shares the URL, the recipient should see the same view.

```tsx
// Bad — state only in component, not shareable:
const [filter, setFilter] = useState('active');

// Good — state in URL:
const searchParams = useSearchParams();
const filter = searchParams.get('filter') ?? 'active';

function setFilter(value: string) {
  const params = new URLSearchParams(searchParams);
  params.set('filter', value);
  router.push(`?${params.toString()}`);
}
```

### Deep-Link Stateful UI

Modals, drawers, and expanded accordions that contain meaningful content should be deep-linkable via URL params. A user should be able to share a link to an open modal.

```tsx
// Track modal state in URL:
const isOpen = searchParams.get('modal') === 'edit-user';

function openModal() {
  router.push(`?modal=edit-user&userId=${userId}`);
}
function closeModal() {
  router.push(pathname); // clear params
}
```

### Browser Back Button

The back button should take the user to their previous view, not exit the app. Single-page apps often break this by replacing history instead of pushing.

```tsx
// Bad — replaces history, breaks back:
router.replace('/dashboard?tab=analytics');

// Good — pushes history, back works:
router.push('/dashboard?tab=analytics');
```

Use `router.replace` only for redirects and initial load normalizations where you don't want an extra history entry.

### Loading State During Navigation

Show a visual indicator during page transitions that take over 100ms. Next.js provides `loading.tsx` files in the App Router for this.

```tsx
// app/dashboard/loading.tsx
export default function Loading() {
  return <DashboardSkeleton />;
}
```

For client-side navigation indicators, use NProgress or a custom `useNProgress` hook.

### Handle 404s Gracefully

Every dynamic route needs a not-found state. If a user navigates to `/users/nonexistent-id`, show a helpful page — not a blank screen or a 500 error.

```tsx
// app/users/[id]/page.tsx
export default async function UserPage({ params }: { params: { id: string } }) {
  const user = await getUser(params.id);

  if (!user) {
    notFound(); // triggers not-found.tsx
  }

  return <UserProfile user={user} />;
}
```
