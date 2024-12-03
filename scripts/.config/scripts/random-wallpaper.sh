#!/bin/sh

wallpaperPath=~/Pictures/Wallpapers/Winter
wallpaper=$wallpaperPath/$(ls -Rp $wallpaperPath | grep -v / | shuf -n 1)

# Apply pywal color scheme to desktop
wal -i $wallpaper -n

# Set a random wallpaper from the specified folder
feh --bg-fill $wallpaper

# Refresh xrdb in DWM
ln -sf ~/.cache/wal/colors.Xresources ~/.Xresources
xdotool key Super+F5

# Update pywalfox theme
pywalfox update

# Update discord theme
pywal-discord -p ${HOME}/.config/vesktop/themes/

# Update spicetify colors
pywal-spicetify marketplace

echo "Updated to $wallpaper"

# Restart dunst
pkill dunst
dunst

