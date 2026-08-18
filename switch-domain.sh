#!/usr/bin/env bash
# Point the site at its real domain. Run AFTER the custom domain is attached
# to the Pages project and resolving, otherwise the canonicals name a host
# that does not answer yet.
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")"

OLD="https://andante-hair-studio.pages.dev"
NEW="https://andantehairchicago.com"

if ! curl -sf -o /dev/null --max-time 10 "$NEW/"; then
  echo "REFUSING: $NEW does not answer yet."
  echo "Attach the custom domain to the Pages project first, then re-run."
  exit 1
fi

for f in *.html sitemap.xml robots.txt; do
  [ -f "$f" ] || continue
  sed -i '' "s|$OLD|$NEW|g" "$f"
done

echo "Rewrote canonicals, og:url, JSON-LD, sitemap and robots to $NEW"
grep -rl "andante-hair-studio.pages.dev" *.html sitemap.xml robots.txt 2>/dev/null \
  && echo "WARNING: leftovers above" || echo "No pages.dev references left."
