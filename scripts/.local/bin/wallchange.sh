#!/usr/bin/env bash
BACKGROUND="$HOME/.config/background"
update(){
  if pgrep Hyprland >/dev/null 2>&1; then 
    hyprctl hyprpaper reload ,$BACKGROUND >/dev/null 2>&1
  fi

  if pgrep hyprlock >/dev/null 2>&1; then 
    pkill -USR2 hyprlock >/dev/null 2>&1
  fi
}
random(){
  WALLPAPER_DIR="$HOME/wallpapers/"
  count=0
  while [[ $count -lt 3 ]]; do
    ((count++))
    WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)
    if checkWalpaper $WALLPAPER; then 
      cp "$WALLPAPER" "$BACKGROUND"
      update
      exit 0 
    else
      echo "Invalid wallpaper: $WALLPAPER"
      exit 1
    fi
  done
}
stable(){
  if systemctl --user is-active wallpaper.timer &>/dev/null;then
    systemctl --user stop wallpaper.timer &>/dev/null
  else
    systemctl --user start wallpaper.timer &>/dev/null
  fi
}
checkWalpaper(){
  if ! echo $1 | grep -qE ".*\.(jpg|png)$";then
    echo "not supported wallpaper format"
    return 1
  fi
  return 0
}
help(){
cat <<EOF
Usage: wallchange.sh [options]
Options:
-s, --set-wallpaper PATH  Set custom wallpaper
-c, --constant stop the wallpaper from changing every 5 min
-h, --help               Show this help
EOF
}
random=0
while [ $# -gt 0 ]; do
  case "${1}" in
    -s|--set-wallpaper)
      if [[ -z $2 ]]; then
        echo "missing wallpaper path"
        exit 1
      fi
      if ! checkWalpaper $2;then
        exit 1
      fi
      random=1
      cp "${2}" "$BACKGROUND"
      update
      shift 2
      ;;
    -c|--constant)
      random=1
      stable
      shift 1
      ;;
    -h|--help)
      help
      exit 0
      ;;
    *) echo try wallchange.sh -h;exit 1 
    ;;
  esac
done
if [[ $random == 1 ]]; then
  exit 0
else
  random
fi
