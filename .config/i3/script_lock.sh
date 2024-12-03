#!/bin/bash

systemctl suspend

i3lock -c 181818 -i /home/jonas/.config/i3/wallpaper/lock-screen.png -t -n

DISPLAY_NAME=$(xrandr | grep ' connected' | awk '{print $1}')
xrandr --output $DISPLAY_NAME --off
xrandr --output $DISPLAY_NAME --auto
