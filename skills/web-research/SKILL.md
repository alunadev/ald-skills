---
name: web-research
description: >
  Correct protocol for crawling and researching external websites. Use this skill — always — before
  fetching any sub-page of a website you haven't visited before. Triggers on: "research this site",
  "check their website", "find out what X does", "scrape this competitor", "look at their features",
  "crawl this URL", "fetch pages from", "browse this site", "check what pages exist at", or any time
  you need information from multiple pages of the same domain. The rule is absolute: never guess or
  construct URL paths — always extract real hrefs from the homepage first.
---

# Web Research — Correct Crawling Protocol

## The Core Rule

**Never construct or guess URL paths. Always extract real hrefs first.**

This is not a preference — it is a hard rule with zero exceptions. URLs that look logical (`/gestion-academica/`, `/facturacion-ventas/`, `/soluciones/`) return 404 when the real paths are `/gestion/`, `/facturacion/`, `/productos/`. The site owns its URL structure, not you.

---

## The Correct Protocol (always follow this order)

### Step 1 — Fetch the root/homepage first
```
WebFetch(url: "https://domain.com/", prompt: "Extract EVERY href link on this page — all navigation links, footer links, button links, and any internal URL. I need the exact full URLs as they appear in the HTML so I can crawl them. List them all.")
```

This gives you the real URL structure of the site. Never skip this step.

### Step 2 — Read the extracted URLs
From the homepage fetch, you now have a list of real paths. Use these — only these — for subsequent fetches.

### Step 3 — Fetch the real pages in parallel
Now that you have confirmed URLs, fetch multiple pages simultaneously:
```
WebFetch(url: "https://domain.com/real-path-1/", prompt: "...")
WebFetch(url: "https://domain.com/real-path-2/", prompt: "...")
WebFetch(url: "https://domain.com/real-path-3/", prompt: "...")
```

### Step 4 — If a page 404s
Check the homepage href list again. Do not guess an alternative path. If the information isn't at a known URL, it may not exist as a separate page — look for it on the pages that did return 200.

---

## Red Flags — Stop immediately if you catch yourself doing any of these

| Thought | What's actually happening |
|---|---|
| "The module is called X so the URL is probably /X/" | Guessing. Stop. Fetch homepage first. |
| "I'll try /about/, /about-us/, /quienes-somos/" | Still guessing — just with more attempts. |
| "It's a Spanish site so it must be /gestion-academica/" | Name ≠ URL. Stop. |
| "The nav said 'Soluciones' so the URL is /soluciones/" | Nav labels ≠ URL paths. Stop. |
| "Let me try a few variations until one works" | This is URL brute-forcing. Stop. |

---

## Why This Happens (root cause)

The instinct to construct URLs from topic names is a pattern-matching shortcut that works for well-known sites (GitHub, MDN, npm) where the URL structure is canonical and documented. For arbitrary company websites, CMS-built sites, or any site you haven't studied, this shortcut fails — often silently, returning 404s that waste tool calls and miss real content.

**The fix is mechanical: homepage → extract hrefs → use only real URLs.**

---

## Bonus: When the homepage itself is content-sparse

Some sites load navigation via JavaScript (SPAs). If the homepage fetch returns very few links:
1. Try `/sitemap.xml` — many sites have this and it lists all pages
2. Try `/sitemap_index.xml`
3. Try the robots.txt: `GET /robots.txt` often references the sitemap URL
4. Look for a footer or nav section in what was returned — even partial HTML may have hrefs

```
WebFetch(url: "https://domain.com/sitemap.xml", prompt: "List all URLs in this sitemap.")
WebFetch(url: "https://domain.com/robots.txt", prompt: "Extract any sitemap URLs or disallowed paths listed here.")
```

---

## Example — Correct execution

```
# WRONG ❌
WebFetch("https://alexiaeducaria.com/gestion-academica/")  → 404
WebFetch("https://alexiaeducaria.com/facturacion-ventas/") → 404
WebFetch("https://alexiaeducaria.com/que-es-alexia/")      → 404

# CORRECT ✅
Step 1: WebFetch("https://alexiaeducaria.com/", "Extract every href")
→ Returns real URLs: /gestion/, /aprendizaje/, /alex-ia/, /entorno-unico/, ...

Step 2: Fetch in parallel using ONLY those real URLs:
WebFetch("https://alexiaeducaria.com/gestion/")      → 200 ✅
WebFetch("https://alexiaeducaria.com/aprendizaje/")  → 200 ✅
WebFetch("https://alexiaeducaria.com/alex-ia/")      → 200 ✅
```

---

## One-line summary

> Homepage first. Extract hrefs. Visit only real URLs. Never guess.
