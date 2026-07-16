#!/usr/bin/env bash
set -euo pipefail

hyprctl -j binds \
| jq -r '.[] | "\(.modmask),\(.key)@\(.keycode),\(.description),\(.dispatcher),\(.arg)"' \
| sed -r \
  -e 's/null//g' \
  -e 's/@0//g' \
  -e 's/,@/,code:/g' \
  -e 's/^0,/,/g' \
  -e 's/^1,/SHIFT,/g' \
  -e 's/^4,/CTRL,/g' \
  -e 's/^5,/SHIFT CTRL,/g' \
  -e 's/^8,/ALT,/g' \
  -e 's/^9,/SHIFT ALT,/g' \
  -e 's/^12,/CTRL ALT,/g' \
  -e 's/^13,/SHIFT CTRL ALT,/g' \
  -e 's/^64,/SUPER,/g' \
  -e 's/^65,/SUPER SHIFT,/g' \
  -e 's/^68,/SUPER CTRL,/g' \
  -e 's/^69,/SUPER SHIFT CTRL,/g' \
  -e 's/^72,/SUPER ALT,/g' \
  -e 's/^73,/SUPER SHIFT ALT,/g' \
  -e 's/^76,/SUPER CTRL ALT,/g' \
  -e 's/^77,/SUPER SHIFT CTRL ALT,/g' \
| awk -F, '
  {
    combo = $1 " + " $2;
    gsub(/^[ \t]*\+?[ \t]*/, "", combo);
    gsub(/[ \t]+$/, "", combo);

    desc = $3;
    gsub(/^[ \t]+|[ \t]+$/, "", desc);

    if (desc != "") printf "%-35s  %s\n", combo, desc;
  }
' \
| sort -u \
| wofi --dmenu --prompt "Keybindings" --width 900 --height 520

