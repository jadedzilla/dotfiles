#!/bin/bash


updateWallpaper() {
    wallpaperPath=~/Pictures/Wallpapers/Winter

    # Set a random wallpaper from the specified folder
    feh --bg-fill $wallpaperPath/$(ls -Rp $wallpaperPath | grep -v / | shuf -n 1)

    # Get the current wallpaper from .fehbg
    wallpaper="$(cat "${HOME}/.fehbg" | awk -F "'" '{print $2}')"

    # Apply pywal color scheme to desktop
    wal -i $wallpaper
    
    # Refresh xrdb in DWM
    ln -sf ~/.cache/wal/colors.Xresources ~/.Xresources
    xdotool key Super+F5

    # Restart dunst
    pkill dunst
    exec dunst

    # Update pywalfox theme
    pywalfox update

    # Update discord theme
    pywal-discord -p ~/.config/vesktop/themes/
}

updateWallpaper
