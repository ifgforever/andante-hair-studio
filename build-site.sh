#!/usr/bin/env bash
# Stage only what belongs on the public site into _site/.
#
# Pages ignores .assetsignore (that is a Workers-assets feature), so the only
# reliable way to keep repo files off the website is to deploy a directory
# that contains nothing else. Deploying the repo root published README.md,
# the shell scripts and photos/README.md at 200.
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")"

rm -rf _site
mkdir -p _site/photos

cp ./*.html _site/
cp styles.css sitemap.xml robots.txt _redirects _site/
# Images only — not the folder's README or installer.
find photos -maxdepth 1 -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) \
  -exec cp {} _site/photos/ \;

echo "staged $(find _site -type f | wc -l | tr -d ' ') files:"
find _site -type f | sort | sed 's/^/  /'
