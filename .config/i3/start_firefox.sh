#!/bin/sh

firefox &
export I3SOCK=$(i3 --get-socket)

# gaming
while true; do
    id=$(wmctrl -l -x | grep 'Firefox.\+gaming' | grep -v 'Alacritty' | awk '{print $1}')

    if [ -n "$id" ]; then
i3-msg "[id=$id] move container to workspace 󰺷"
        break
    fi

    sleep 1
done


# music
while true; do
    id=$(wmctrl -l -x | grep 'Firefox.\+music' | grep -v 'Alacritty' | awk '{print $1}')

    if [ -n "$id" ]; then
i3-msg "[id=$id] move container to workspace "
        break
    fi

    sleep 1
done


# work_1
while true; do
    id=$(wmctrl -l -x | grep 'Firefox.\+work_1' | grep -v 'Alacritty' | awk '{print $1}')

    if [ -n "$id" ]; then
i3-msg "[id=$id] move container to workspace "
        break
    fi

    sleep 1
done

# work_2
while true; do
    id=$(wmctrl -l -x | grep 'Firefox.\+work_2' | grep -v 'Alacritty' | awk '{print $1}')

    if [ -n "$id" ]; then
i3-msg "[id=$id] move container to workspace "
        break
    fi

    sleep 1
done

# work_3
while true; do
    id=$(wmctrl -l -x | grep 'Firefox.\+work_3' | grep -v 'Alacritty' | awk '{print $1}')

    if [ -n "$id" ]; then
i3-msg "[id=$id] move container to workspace "
        break
    fi

    sleep 1
done
