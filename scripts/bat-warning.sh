#!/bin/sh
# Discription:
# Notification when battery capacity drops below a certain value
#
# Dependencies:
# - bc
# - dunst (dunstify)
# - Papirus-Dark icon set

id=999005
bat_charge="$(cat /sys/class/power_supply/BAT0/capacity)"
bat_status="$(cat /sys/class/power_supply/BAT0/status)"
icon="battery-level-"
threshold=30

# echo "$(date +%s):$bat_charge" >> "$TMPDIR/bat_log"

if [ "$bat_charge" -le "$threshold" ]; then
    rounded="$(echo "(($bat_charge + 5) / 10) * 10" | bc)"
    icon="$icon$rounded"
    if [ "$bat_status" = "Charging" ]; then
        icon="$icon-charging"
    fi
    dunstify -r "$id" -i "$icon-symbolic" "Battery" "Charge is $bat_charge%"
fi

