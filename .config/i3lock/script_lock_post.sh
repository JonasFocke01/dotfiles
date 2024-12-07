#!/bin/bash

i3lock -c 181818 -i $HOME/.config/i3lock/lockscreen.png -t -n

rm /tmp/raw_screen.png /tmp/raw_screen.png /tmp/lockscreen.png

# TODO: this needs to happen in some sort of a systemd script
DISPLAY_NAME=$(xrandr | grep ' connected' | awk '{print $1}')
xrandr --output $DISPLAY_NAME --off
xrandr --output $DISPLAY_NAME --auto
