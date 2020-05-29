#!/bin/sh
# Discription:
# Rotate (touch)screen/touchpac/digitizer based on orientation
#
# Installation:
# To get the name of your hardware run `xinput -list` then set TOUCHSCREEN,
# DIGITIZER and TOUCHPAD accordingly
#
# Dependencies:
# - monitor-sensor (packman package: lm_sensors)
# - xrander
# - xinput (pacman package: xorg-xinput)
# - optional: polybar
#
# Credits:
# based on https://gist.github.com/Migacz85/3f544933ce5add438555ba7cd33f0413

transform="Coordinate Transformation Matrix"

monitor-sensor | while read -r line
do
    orientation="$(echo "$line" | cut -d " " -f 4)"
    if [ "$orientation" = "left-up" ]
    then
        polybar.sh -s &
        xrandr -o left;
        [ "$TOUCHSCREEN" != "" ] && xinput set-prop "$TOUCHSCREEN" \
            "$transform" 0 -1 1 1 0 0 0 0 1;
        [ "$DIGITIZER" != "" ] && xinput set-prop "$DIGITIZER" \
            "$transform" 0 -1 1 1 0 0 0 0 1;
        [ "$TOUCHPAD" != "" ] && xinput set-prop "$TOUCHPAD"  \
            "$transform" 0 -1 1 1 0 0 0 0 1;
    fi
    if [ "$orientation" = "right-up" ]
    then
        polybar.sh -s &
        xrandr -o right;
        [ "$TOUCHSCREEN" != "" ] && xinput set-prop "$TOUCHSCREEN" "$transform" 0 1 0 -1 0 1 0 0 1;
        [ "$DIGITIZER" != "" ] && xinput set-prop "$DIGITIZER" "$transform" 0 1 0 -1 0 1 0 0 1;
        [ "$TOUCHPAD" != "" ] && xinput set-prop "$TOUCHPAD" "$transform" 0 1 0 -1 0 1 0 0 1;
    fi
    if [ "$orientation" = "bottom-up" ]
    then
        polybar.sh -l &
        xrandr -o inverted;
        [ "$TOUCHSCREEN" != "" ] && xinput set-prop "$TOUCHSCREEN" "$transform" -1 0 1 0 -1 1 0 0 1;
        [ "$DIGITIZER" != "" ] && xinput set-prop "$DIGITIZER" "$transform" -1 0 1 0 -1 1 0 0 1;
        [ "$TOUCHPAD" != "" ] && xinput set-prop "$TOUCHPAD" "$transform" -1 0 1 0 -1 1 0 0 1;
    fi
    if [ "$orientation" = "normal" ]
    then
        polybar.sh -l &
        xrandr -o normal;
        [ "$TOUCHSCREEN" != "" ] && xinput set-prop "$TOUCHSCREEN" "$transform" 1 0 0 0 1 0 0 0 1;
        [ "$DIGITIZER" != "" ] && xinput set-prop "$DIGITIZER" "$transform" 1 0 0 0 1 0 0 0 1;
        [ "$TOUCHPAD" != "" ] && xinput set-prop "$TOUCHPAD" "$transform" 1 0 0 0 1 0 0 0 1;
    fi
done

