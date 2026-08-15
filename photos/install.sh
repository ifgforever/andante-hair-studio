#!/usr/bin/env bash
# Install photos into the site.
#
# Usage:  ./photos/install.sh <slot> <file>
#   slot: hero | salon-1 | salon-2 | salon-3 | salon-4
#
#   ./photos/install.sh salon-4 ~/Downloads/storefront.jpg
#   ./photos/install.sh salon-3 ~/Downloads/red-curls.jpg
#
# Strips EXIF (phone photos carry GPS), resizes to 2400px, and drops the file
# where styles.css already expects it. Nothing else to change.

set -euo pipefail

slot="${1:-}"; src="${2:-}"
here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

case "$slot" in
  hero|salon-1|salon-2|salon-3|salon-4) ;;
  *) echo "slot must be one of: hero salon-1 salon-2 salon-3 salon-4" >&2; exit 1 ;;
esac
[ -f "$src" ] || { echo "no such file: $src" >&2; exit 1; }

dest="$here/$slot.jpg"
cp "$src" "$dest"

# Re-encode as JPEG and cap the long edge.
sips -s format jpeg -Z 2400 "$dest" --out "$dest" >/dev/null

# Strip metadata. exiftool if present, otherwise sips has already dropped most
# of it on re-encode; warn so it gets checked.
if command -v exiftool >/dev/null 2>&1; then
  exiftool -overwrite_original -all= "$dest" >/dev/null
  echo "EXIF stripped with exiftool"
else
  echo "NOTE: exiftool not installed — sips re-encode drops most metadata, but"
  echo "      run 'brew install exiftool' and re-run to be certain about GPS."
fi

echo "installed $slot -> $dest ($(du -h "$dest" | cut -f1))"
