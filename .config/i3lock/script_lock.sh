#!/bin/bash

flameshot full -c -p /tmp/raw_screen.png
convert /tmp/raw_screen.png -blur 0x20 /tmp/blured_screen.png
convert /tmp/blured_screen.png $HOME/.config/i3lock/lock.png -gravity NorthWest -composite -matte /tmp/lockscreen.png

i3lock -c 181818 -i /tmp/lockscreen.png -t -n

rm /tmp/raw_screen.png /tmp/blured_screen.png /tmp/lockscreen.png

DISPLAY_NAME=$(xrandr | grep ' connected' | awk '{print $1}')
xrandr --output $DISPLAY_NAME --off
xrandr --output $DISPLAY_NAME --auto
