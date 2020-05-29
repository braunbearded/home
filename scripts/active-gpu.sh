#!/bin/sh
# Discription:
# Echos the vendor for the currently used gpu
#
# Dependencies:
# - glxinfo

gpu=$(glxinfo | grep "server glx vendor string")

case $gpu in
    *"NVIDIA"* ) outp="nvidia";;
    * ) outp="intel";;
esac

echo "$outp"
