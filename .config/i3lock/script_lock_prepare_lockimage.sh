#!/bin/bash

# This is a temporary replacement for `script-lock-pre.sh`.
#
rm /tmp/raw_screen.png
flameshot full -c -p /tmp/raw_screen.png
convert /tmp/raw_screen.png -blur 0x20 /tmp/blured_screen.png
convert /tmp/blured_screen.png $HOME/.config/i3lock/lock.png -gravity NorthWest -composite -matte /tmp/lockscreen.png
