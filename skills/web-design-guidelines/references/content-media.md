# Content Handling & Images

Source: Vercel Engineering / vercel-labs web-interface-guidelines

---

## Content Handling

### Text Truncation

Text that overflows its container without truncation breaks layouts. Apply truncation styles explicitly for text that might exceed its container.

```css
/* Single line truncation: */
.truncate {
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

/* Multi-line clamp (modern): */
.line-clamp-3 {
  display: -webkit-box;
  -webkit-line-clamp: 3;
  -webkit-box-orient: vertical;
  overflow: hidden;
}
```

In Tailwind: `truncate` for single-line, `line-clamp-{n}` for multi-line.

### min-width: 0 on Flex Children

Flex children don't shrink below their content size by default, which causes text overflow in flex layouts. Add `min-width: 0` to allow truncation to work inside flex containers.

```css
/* Without min-width: 0, text overflows the flex container: */
.flex-container {
  display: flex;
}
.flex-child {
  min-width: 0; /* Required for truncation to work */
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}
```

This is one of the most common CSS bugs in flex layouts.

### Empty States

Design explicit empty states for every list, table, or data view. An empty `<div>` reads as a broken page to users.

```tsx
function UserList({ users }: { users: User[] }) {
  if (users.length === 0) {
    return (
      <div className="empty-state">
        <Icon name="users" />
        <h3>No users yet</h3>
        <p>Invite your first team member to get started.</p>
        <Button>Invite someone</Button>
      </div>
    );
  }
  return <ul>{users.map(u => <UserRow key={u.id} user={u} />)}</ul>;
}
```

Empty states should: explain why it's empty, suggest what to do next, and ideally provide an action.

### Long Unbroken Strings

URLs, email addresses, file paths, and UUIDs are long strings without natural break points. Without explicit handling, they overflow their containers.

```css
.user-content {
  overflow-wrap: break-word; /* breaks at any character if needed */
  word-break: break-word;    /* legacy support */
}

/* For URLs specifically, allow breaks at / and . */
.url-display {
  word-break: break-all;
}
```

### Loading States

Every async data fetch needs a loading state. Render a skeleton or spinner while data loads; don't leave the area blank or render stale data without indication.

```tsx
function Dashboard() {
  const { data, isLoading } = useSWR('/api/stats', fetcher);

  if (isLoading) return <DashboardSkeleton />;
  return <DashboardContent data={data} />;
}
```

Use skeleton placeholders over spinners for content that has a predictable layout — they reduce perceived loading time.

### Error States

Every data fetch also needs an error state. Silent failures confuse users; make errors visible and actionable.

```tsx
function Dashboard() {
  const { data, error } = useSWR('/api/stats', fetcher);

  if (error) return (
    <ErrorState
      message="Failed to load dashboard"
      action={<Button onClick={() => mutate()}>Try again</Button>}
    />
  );
  return <DashboardContent data={data} />;
}
```

---

## Images

### Explicit Width and Height

Every `<img>` element needs explicit `width` and `height` attributes matching the image's intrinsic dimensions. Without them, the browser can't reserve space before the image loads, causing Cumulative Layout Shift (CLS).

```html
<!-- Bad — causes layout shift: -->
<img src="/hero.jpg" alt="Hero image" />

<!-- Good — browser reserves space immediately: -->
<img src="/hero.jpg" alt="Hero image" width="1200" height="600" />
```

In Next.js, use the `<Image>` component — it handles this automatically.

### loading="lazy" for Below-Fold Images

Images below the fold don't need to load immediately. `loading="lazy"` defers their loading until they approach the viewport, reducing initial page weight.

```html
<!-- Hero image — load immediately: -->
<img src="/hero.jpg" alt="Hero" width="1200" height="600" />

<!-- Below-fold content — defer: -->
<img src="/product-1.jpg" alt="Product" width="400" height="300" loading="lazy" />
```

Don't lazy-load images that are visible on initial load — it delays LCP (Largest Contentful Paint).

### fetchpriority="high" on Hero Image

The hero image is typically the Largest Contentful Paint (LCP) element. Signal to the browser that it's high priority so it starts loading before other resources.

```html
<img
  src="/hero.jpg"
  alt="Hero"
  width="1200"
  height="600"
  fetchpriority="high"
/>
```

Use this for exactly one image per page — the one that's visible above the fold immediately. Using it on multiple images defeats the purpose.

### Responsive Images

Use `srcset` and `sizes` to serve appropriately sized images to different viewports. Sending a 2400px image to a 375px mobile device wastes bandwidth.

```html
<img
  src="/hero-800.jpg"
  srcset="/hero-400.jpg 400w, /hero-800.jpg 800w, /hero-1600.jpg 1600w"
  sizes="(max-width: 768px) 100vw, 50vw"
  alt="Hero"
  width="800"
  height="400"
/>
```

In Next.js, the `<Image>` component handles `srcset` generation automatically.

### Object-fit for Constrained Images

When displaying images in fixed-size containers, use `object-fit` to prevent distortion.

```css
.avatar {
  width: 48px;
  height: 48px;
  object-fit: cover;      /* crop to fill */
  border-radius: 50%;
}

.product-image {
  width: 100%;
  height: 300px;
  object-fit: contain;    /* letterbox — show full image */
}
```

### Image Formats

Prefer modern formats for better compression at equivalent quality:
- WebP: 25-35% smaller than JPEG, broad support
- AVIF: 50% smaller than JPEG, growing support
- Use `<picture>` with fallback for maximum compatibility

```html
<picture>
  <source type="image/avif" srcset="/hero.avif" />
  <source type="image/webp" srcset="/hero.webp" />
  <img src="/hero.jpg" alt="Hero" width="1200" height="600" />
</picture>
```

Next.js `<Image>` automatically serves WebP/AVIF based on browser support.
