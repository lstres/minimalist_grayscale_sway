#!/usr/bin/env bash

# Directory containing your wallpapers
WALL_DIR="$HOME/Pictures/wallpapers"

# Check if directory exists
if [ ! -d "$WALL_DIR" ]; then
    notify-send "Wallpaper Picker" "Directory $WALL_DIR not found."
    exit 1
fi

# Find images and format them with icons for rofi
# We pass the full path as the value and the filename as the display text
SELECTED=$(find "$WALL_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) | while read -r img; do
    echo -en "$(basename "$img")\0icon\x1f$img\n"
done | rofi -dmenu -i -p "󰸉 Wallpapers" -theme-str 'configuration { show-icons: true; } listview { columns: 3; lines: 3; } element { orientation: vertical; } element-icon { size: 120px; }')

# If an image was picked, kill the old swaybg and launch a new one
if [ -n "$SELECTED" ]; then
    FULL_PATH="$WALL_DIR/$SELECTED"
    pkill swaybg
    swaybg -m fill -i "$FULL_PATH" &
fi
