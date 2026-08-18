#!/usr/bin/env bash
# Regenerate sitemap.xml with lastmod taken from each page's last commit.
# Run at deploy time so the dates cannot drift away from the content.
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")"

BASE="$(grep -o 'https://[^/]*' robots.txt | head -1)"

# path<TAB>file<TAB>priority
ROUTES=$(printf '%s\n' \
  "/	index.html	1.0" \
  "/services	services.html	0.9" \
  "/perms	perms.html	0.9" \
  "/contact	contact.html	0.8" \
  "/about	about.html	0.7")

{
  echo '<?xml version="1.0" encoding="UTF-8"?>'
  echo '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">'
  while IFS=$'\t' read -r path file prio; do
    [ -f "$file" ] || continue
    d=$(git log -1 --format=%cs -- "$file" 2>/dev/null || true)
    [ -n "$d" ] || d=$(date +%F)
    printf '  <url>\n    <loc>%s%s</loc>\n    <lastmod>%s</lastmod>\n    <priority>%s</priority>\n  </url>\n' \
      "$BASE" "$path" "$d" "$prio"
  done <<< "$ROUTES"
  echo '</urlset>'
} > sitemap.xml

echo "sitemap.xml rebuilt against $BASE"
