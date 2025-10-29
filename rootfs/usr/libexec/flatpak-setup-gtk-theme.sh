#!/usr/bin/env bash
set -euo pipefail

file="$HOME/.local/share/flatpak/overrides/global"

[[ ! -f "$file" ]] && exit 0

for p in \
    "xdg-config/gtk-4.0:ro" \
    "xdg-config/gtk-3.0:ro" \
    "xdg-config/gtkrc-2.0:ro" \
    "unset-environment=GTK_THEME"
do
    if ! grep -qF "$p" "$file"; then
        exit 0
    fi
done
exit 1

