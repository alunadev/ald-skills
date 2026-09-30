#!/usr/bin/env python3
"""Real UI references from the App Store, for free, via Apple's public iTunes API.

  search  "<term>" [--country es] [--limit 5]
      Candidate apps with rating, rating count, screenshot count and id.

  sheet   <id> [<id> ...] [--out DIR] [--country es] [--max 8] [--height 820] [--ipad]
      One contact sheet per app (<slug>.jpg): its official screenshots side by side.
      --ipad uses the iPad screenshots instead (useful for tablet/desktop layouts).

No account, no key. Needs Pillow (`pip install pillow`) for `sheet`.
"""
import argparse
import io
import json
import re
import sys
import unicodedata
import urllib.parse
import urllib.request

API = 'https://itunes.apple.com'


def get_json(url):
    with urllib.request.urlopen(url, timeout=20) as r:
        return json.load(r)


def search(term, country, limit):
    q = urllib.parse.urlencode({'term': term, 'entity': 'software', 'country': country, 'limit': limit})
    for r in get_json(f'{API}/search?{q}')['results']:
        print(
            f"{r['trackId']:>11}  {r.get('averageUserRating', 0):.2f}★ "
            f"{r.get('userRatingCount', 0):>7} ratings  "
            f"{len(r.get('screenshotUrls', [])):>2} shots  {r['trackName']}"
        )


def slug(name):
    # "FotMob - Resultados de Fútbol" -> "fotmob-resultados-de-futbol"
    ascii_name = unicodedata.normalize('NFKD', name).encode('ascii', 'ignore').decode()
    return re.sub(r'[^a-z0-9]+', '-', ascii_name.lower()).strip('-')[:40] or 'app'


def sheet(ids, out, country, max_shots, height, ipad):
    try:
        from PIL import Image
    except ImportError:
        sys.exit('Pillow missing: pip install pillow')
    import os

    os.makedirs(out, exist_ok=True)
    for app_id in ids:
        results = get_json(f'{API}/lookup?id={app_id}&country={country}')['results']
        if not results:
            print(f'{app_id}: not found in store "{country}"')
            continue
        app = results[0]
        urls = app.get('ipadScreenshotUrls' if ipad else 'screenshotUrls', [])[:max_shots]
        if not urls:
            print(f"{app['trackName']}: no {'iPad ' if ipad else ''}screenshots")
            continue
        images = []
        for u in urls:
            # Ask the CDN for a sensible size instead of the page thumbnail.
            u = u.rsplit('/', 1)[0] + ('/800x0w.jpg' if ipad else '/400x0w.jpg')
            try:
                with urllib.request.urlopen(u, timeout=20) as r:
                    im = Image.open(io.BytesIO(r.read())).convert('RGB')
                images.append(im.resize((int(im.width * height / im.height), height)))
            except Exception as e:  # one broken shot shouldn't lose the sheet
                print(f'  skip {u}: {e}')
        gap = 10
        sheet_img = Image.new('RGB', (sum(i.width for i in images) + gap * (len(images) - 1), height), 'white')
        x = 0
        for im in images:
            sheet_img.paste(im, (x, 0))
            x += im.width + gap
        path = os.path.join(out, f"{slug(app['trackName'])}{'-ipad' if ipad else ''}.jpg")
        sheet_img.save(path, quality=85)
        print(f"{path}  ({len(images)} shots, {app.get('averageUserRating', 0):.2f}★, {app.get('userRatingCount', 0)} ratings)")


def main():
    p = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    sub = p.add_subparsers(dest='cmd', required=True)
    s = sub.add_parser('search')
    s.add_argument('term')
    s.add_argument('--country', default='es')
    s.add_argument('--limit', type=int, default=5)
    h = sub.add_parser('sheet')
    h.add_argument('ids', nargs='+')
    h.add_argument('--out', default='references')
    h.add_argument('--country', default='es')
    h.add_argument('--max', type=int, default=8)
    h.add_argument('--height', type=int, default=820)
    h.add_argument('--ipad', action='store_true')
    a = p.parse_args()
    if a.cmd == 'search':
        search(a.term, a.country, a.limit)
    else:
        sheet(a.ids, a.out, a.country, a.max, a.height, a.ipad)


if __name__ == '__main__':
    main()
