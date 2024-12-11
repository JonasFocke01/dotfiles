#!/bin/bash

i3lock -c 181818 -i /tmp/lockscreen.png -t -n

# TODO: this needs to happen in some sort of a systemd script
DISPLAY_NAME=$(xrandr | grep ' connected' | awk '{print $1}')
xrandr --output $DISPLAY_NAME --off
xrandr --output $DISPLAY_NAME --auto
