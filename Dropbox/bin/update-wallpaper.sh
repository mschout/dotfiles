#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 ]]; then
    echo "Usage: $0 <image-url>"
    exit 1
fi

URL="$1"

IMG="$HOME/.local/share/daily-wallpaper.jpg"
TMP_IMG="$HOME/.local/share/daily-wallpaper.tmp.jpg"

# Try to download the image
if ! curl -L --fail --silent --show-error "$URL" -o "$TMP_IMG"; then
    echo "[$(date)] Wallpaper download failed; keeping existing image." >&2
    rm -f "$TMP_IMG" 2>/dev/null || true
    exit 1
fi

# Replace only after successful download
mv "$TMP_IMG" "$IMG"

# Update GNOME wallpaper
gsettings set org.gnome.desktop.background picture-uri "file://$IMG"
gsettings set org.gnome.desktop.background picture-uri-dark "file://$IMG"

exit 0
