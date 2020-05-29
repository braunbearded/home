#!/bin/sh
# Discription:
# Autolocking script, which first turns off the monitor and then suspends the
# computer after some time (triggers lock)
#
# Dependencies:
# - xidlehook
# - xset (packman package: xorg-xset)
# - systemd suspend mode

display_off_time=120
energy_saving_time=600

xidlehook --not-when-audio \
    --timer "$display_off_time" 'xset dpms force off' '' \
    --timer "$energy_saving_time" 'systemctl suspend' '' &
