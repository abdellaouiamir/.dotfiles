#!/usr/bin/env bash

# ┏━━━┳━━┳━┓┏━┳━━━┳┓╋╋┏━━┳━┓┏━┓
# ┗┓┏┓┣┫┣┫┃┗┛┃┃┏━━┫┃╋╋┗┫┣┻┓┗┛┏┛
# ╋┃┃┃┃┃┃┃┏┓┏┓┃┗━━┫┃╋╋╋┃┃╋┗┓┏┛
# ╋┃┃┃┃┃┃┃┃┃┃┃┃┏━━┫┃╋┏┓┃┃╋┏┛┗┓
# ┏┛┗┛┣┫┣┫┃┃┃┃┃┃╋╋┃┗━┛┣┫┣┳┛┏┓┗┓
# ┗━━━┻━━┻┛┗┛┗┻┛╋╋┗━━━┻━━┻━┛┗━┛
# The program was created by DIMFLIX
# Github: https://github.com/DIMFLIX-OFFICIAL
#!/usr/bin/env bash

ENABLED_COLOR="#A3BE8C"
DISABLED_COLOR="#D35F5E"

print_error() {
    echo "Usage: $0 --device <input|output> --action <increase|decrease|toggle> [--status] [--enabled-color] [--disabled-color]"
    exit 1
}

# Get sink/source names dynamically
get_default_sink() {
    pactl get-default-sink
}

get_default_source() {
    pactl get-default-source
}

# Query volume (sink or source)
get_volume() {
    if [[ "$device" == "output" ]]; then
        pactl get-sink-volume "$(get_default_sink)" | awk '{print $5}' | tr -d '%'
    else
        pactl get-source-volume "$(get_default_source)" | awk '{print $5}' | tr -d '%'
    fi
}

# Query mute state (sink or source)
get_mute() {
    if [[ "$device" == "output" ]]; then
        pactl get-sink-mute "$(get_default_sink)" | awk '{print $2}'
    else
        pactl get-source-mute "$(get_default_source)" | awk '{print $2}'
    fi
}

notify_vol() {
    vol=$(get_volume)
    notify-send -h string:x-canonical-private-synchronous:volume_notif -u low "Volume" "${vol}%"
}

notify_mute() {
    if [[ "$(get_mute)" == "yes" ]]; then
        notify-send -h string:x-canonical-private-synchronous:volume_notif -u low "Muted"
    else
        notify-send -h string:x-canonical-private-synchronous:volume_notif -u low "Unmuted"
    fi
}

print_status() {
    local vol=$(get_volume)
    local mute=$(get_mute)

    if [[ "$device" == "output" ]]; then
        if [[ "$mute" == "yes" ]]; then
            local icon="  $vol%"
            local color=$DISABLED_COLOR
        elif [[ "$vol" -le 30 ]]; then
            local icon=" $vol%"
            local color=$ENABLED_COLOR
        elif [[ "$vol" -le 60 ]]; then
            local icon=" $vol%"
            local color=$ENABLED_COLOR
        else
            local icon="  $vol%"
            local color=$ENABLED_COLOR
        fi
    else # input
        if [[ "$mute" == "yes" ]]; then
            local icon="  $vol%"
            local color=$DISABLED_COLOR
        else
            local icon=" $vol%"
            local color=$ENABLED_COLOR
        fi
    fi

    echo "<span color=\"$color\">$icon</span>"
}

action_volume() {
    local step="2%"

    case "$action" in
        increase)
            if [[ "$device" == "output" ]]; then
                pactl set-sink-volume "$(get_default_sink)" "+$step"
            else
                pactl set-source-volume "$(get_default_source)" "+$step"
            fi
            notify_vol
            ;;
        decrease)
            if [[ "$device" == "output" ]]; then
                pactl set-sink-volume "$(get_default_sink)" "-$step"
            else
                pactl set-source-volume "$(get_default_source)" "-$step"
            fi
            notify_vol
            ;;
        toggle)
            if [[ "$device" == "output" ]]; then
                pactl set-sink-mute "$(get_default_sink)" toggle
            else
                pactl set-source-mute "$(get_default_source)" toggle
            fi
            notify_mute
            exit 0
            ;;
        *)
            print_error
            ;;
    esac
}

# Parse arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --device) device="$2"; shift ;;
        --action) action="$2"; shift ;;
        --enabled-color) ENABLED_COLOR="$2"; shift ;;
        --disabled-color) DISABLED_COLOR="$2"; shift ;;
        --status) status=true ;;
        *) print_error ;;
    esac
    shift
done

# Validate device
case "$device" in
    input|output) ;;
    *) print_error ;;
esac

# Status mode
if [[ "$status" == true ]]; then
    print_status
    exit 0
fi

# Ensure action exists
[[ -z "$action" ]] && print_error

# Perform action
action_volume
