#!/usr/bin/env bash
WALLPAPER_DIR="$HOME/wallpapers/"
WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)
BACKGROUND="$HOME/.config/background"
# rm $BACKGROUND
cp $WALLPAPER $BACKGROUND
if pgrep Hyprland >/dev/null 2>&1; then 
  hyprctl hyprpaper reload ,$BACKGROUND >/dev/null 2>&1
fi

if pgrep hyprlock >/dev/null 2>&1; then 
  pkill -USR2 hyprlock >/dev/null 2>&1
fi
