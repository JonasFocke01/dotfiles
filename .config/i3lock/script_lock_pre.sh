#!/bin/bash

# Until i have no way of delaying the suspend action until this commands finish, i need to use a static image as my lockscreen
#
# flameshot full -c -p /tmp/raw_screen.png
# convert /tmp/raw_screen.png -blur 0x20 /tmp/blured_screen.png
# convert /tmp/blured_screen.png $HOME/.config/i3lock/lock.png -gravity NorthWest -composite -matte /tmp/lockscreen.png
