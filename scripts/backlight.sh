#!/bin/sh
# Discription:
# Adjust (laptop)monitor brightness. Option "-P" (power) and "-B" (battery)
# saves or restore last brightness settings. I use it  on laptops when
# power is plugged in or not.
#
# Dependencies:
# - light
# - bc
# - dunst (dunstify)
# - Papirus-Dark icon set
#
# Usage:
# $ backlight.sh -A 0.5  # increase brightness constant step size 0.5
# $ backlight.sh -U 5 %c # decrease brightness by 5% based on current brightness (not linear)
# $ backlight.sh -P # save current brightness and set brightness to 100%
# $ backlight.sh -B # restore saved brightness

id=999001
min_step=0.2

notification() {
    curr="$(light | awk '{print substr($1, 0, length($1)-3)}')"
    if [ "$curr" -le 1 ]; then
        icon="display-brightness-off-symbolic"
    elif [ "$curr" -le "10" ]; then
        icon="display-brightness-low-symbolic"
    elif [ "$curr" -le "30" ]; then
        icon="display-brightness-medium-symbolic"
    else
        icon="display-brightness-high-symbolic"
    fi
    calc=$(echo "(l($curr+1)/l(10))*10"  | bc -l)
    bar=$(seq -s "─" "$calc" | sed 's/[0-9]//g')
    dunstify -i "$icon" -u "low" -r "$id" "$bar"
}

case "$1" in
    "-B")
        light -I # restore brightness
        notification
        exit;;
    "-P")
        light -O # save current brightness
        light -S 100
        notification
        exit;;
esac

step=$2
if [ "$3" = "%c" ]; then
    step=$(echo "(($(light) / 100 ) * $2)" | bc -l)
    [ "$(echo "$step < $min_step" | bc)" = 0 ] || step=$min_step
fi

light "$1" "$step"
notification

