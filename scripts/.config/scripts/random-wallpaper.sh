#!/bin/bash

# Set a random wallpaper from the specified folder
feh --randomize --bg-fill ~/Pictures/Wallpapers/Winter/*

# Get the current wallpaper from .fehbg
wallpaper="$(cat "${HOME}/.fehbg" | awk -F "'" '{print $2}')"

# Apply pywal color scheme to desktop
wal -i $wallpaper
  
# Refresh xrdb in DWM
xdotool key Super+F5

# Restart dunst
pkill dunst
exec dunst &

# Update pywalfox theme
pywalfox update &

exit 0
