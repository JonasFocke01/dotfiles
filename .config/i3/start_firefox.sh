#!/bin/bash

firefox &

# gaming
while true; do
    id=$(wmctrl -l -x | grep -E 'firefox.\+gaming' | grep -v 'Alacritty' | awk '{print $1}')

    if [ -n "$id" ]; then
i3-msg "[id=$id] move container to workspace 󰺷"
        break
    fi

    sleep 1
done


# music
while true; do
    id=$(wmctrl -l -x | grep -E 'firefox.\+music' | grep -v 'Alacritty' | awk '{print $1}')

    if [ -n "$id" ]; then
i3-msg "[id=$id] move container to workspace "
        break
    fi

    sleep 1
done


# work_1
while true; do
    id=$(wmctrl -l -x | grep -E 'firefox.\+work_1' | grep -v 'Alacritty' | awk '{print $1}')

    if [ -n "$id" ]; then
i3-msg "[id=$id] move container to workspace "
        break
    fi

    sleep 1
done

# work_2
while true; do
    id=$(wmctrl -l -x | grep -E 'firefox.\+work_2' | grep -v 'Alacritty' | awk '{print $1}')

    if [ -n "$id" ]; then
i3-msg "[id=$id] move container to workspace "
        break
    fi

    sleep 1
done

# work_3
while true; do
    id=$(wmctrl -l -x | grep -E 'firefox.\+work_3' | grep -v 'Alacritty' | awk '{print $1}')

    if [ -n "$id" ]; then
i3-msg "[id=$id] move container to workspace "
        break
    fi

    sleep 1
done
