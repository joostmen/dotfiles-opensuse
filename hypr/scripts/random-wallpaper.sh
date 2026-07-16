#!/bin/bash

WALLPAPER_DIR="$HOME/Images/wallpapers"

WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( \
    -iname '*.jpg'  -o -iname '*.jpeg' -o \
    -iname '*.png'  -o \
    -iname '*.gif'  -o \
    -iname '*.pnm'  -o \
    -iname '*.tga'  -o \
    -iname '*.tiff' -o -iname '*.tif' -o \
    -iname '*.webp' -o \
    -iname '*.bmp'  -o \
    -iname '*.ff'   -o \
    -iname '*.svg'  \
\) | shuf -n1)

# Safety check
[ -z "$WALLPAPER" ] && exit 1

swww img "$WALLPAPER" \
  --transition-type any \
  --transition-duration 1 \
  --transition-fps 60

