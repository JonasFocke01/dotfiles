#!/bin/bash
# This script is currently invoked by zzz -> resume (symlinked into `/etc/zzz.d/resume/`)

i3lock -c 181818 -i /tmp/lockscreen.png -t -n

DISPLAY_NAME=$(xrandr | grep ' connected' | awk '{print $1}')
xrandr --output $DISPLAY_NAME --off
xrandr --output $DISPLAY_NAME --auto
