#!/usr/bin/env bash

# ┏━━━┳━━┳━┓┏━┳━━━┳┓╋╋┏━━┳━┓┏━┓
# ┗┓┏┓┣┫┣┫┃┗┛┃┃┏━━┫┃╋╋┗┫┣┻┓┗┛┏┛
# ╋┃┃┃┃┃┃┃┏┓┏┓┃┗━━┫┃╋╋╋┃┃╋┗┓┏┛
# ╋┃┃┃┃┃┃┃┃┃┃┃┃┏━━┫┃╋┏┓┃┃╋┏┛┗┓
# ┏┛┗┛┣┫┣┫┃┃┃┃┃┃╋╋┃┗━┛┣┫┣┳┛┏┓┗┓
# ┗━━━┻━━┻┛┗┛┗┻┛╋╋┗━━━┻━━┻━┛┗━┛
# The program was created by DIMFLIX
# Github: https://github.com/DIMFLIX-OFFICIAL

notify="notify-send"
tmp_disturb="/tmp/xmonad/donotdisturb"
log_file="/tmp/toggle_dnd.log"
ENABLED_COLOR="#A3BE8C"
DISABLED_COLOR="#d35f5e"

if [ ! -d "$tmp_disturb" ]; then
    mkdir -p "$tmp_disturb"
fi

toggle_notifications() {
    if [ "$(dunstctl is-paused)" == "true" ]; then
        dunstctl set-paused false
        $notify "Dunst: Active"
    else
        dunstctl set-paused true
    fi
}

get_status() {
    if [ "$(dunstctl is-paused)" == "true" ]; then
        local icon="󱏧 "
        local color=$DISABLED_COLOR
    else
        local icon="󱅫 "
        local color=$ENABLED_COLOR
    fi

    echo "<span color=\"$color\">$icon</span>"
}

# Парсинг аргументов
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --status) status=true ;;
        --enabled-color) ENABLED_COLOR="$2"; shift ;;
        --disabled-color) DISABLED_COLOR="$2"; shift ;;
        *) echo "Unknown option: $1"; exit 1 ;;
    esac
    shift
done

# Проверка аргументов
if [[ "$status" == true ]]; then
    get_status | tee -a "$log_file"
else
    toggle_notifications
fi
