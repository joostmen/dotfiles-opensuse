WALLPAPER_DIR="$HOME/Images/wallpapers"
CONFIG_FILE="$HOME/.config/hypr/hyprpaper.conf"

# Optional: clear previous preload lines
sed -i '/^preload =/d' "$CONFIG_FILE"

# Add a preload line for each image file
find "$WALLPAPER_DIR" -type f \( -iname '*.jpg' -o -iname '*.png' -o -iname '*.jpeg' \) | while read -r file; do
    echo "preload = $file" >> "$CONFIG_FILE"
done

