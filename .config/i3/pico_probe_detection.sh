#!/bin/bash

LOCKFILE="/tmp/pico_probe_detection.lock"

if [ -e "$LOCKFILE" ]; then
    echo "The script is already running."
    exit 1
fi

touch "$LOCKFILE"

trap 'rm -f "$LOCKFILE"; exit' INT TERM EXIT

trigger_engaged=0
is_plugging_in=0
is_probe=0
waiting_for=1

udevadm monitor --udev --property | while read -r line; do
    if echo "$line" | grep --quiet "Debugprobe_on_Pico"; then
        is_probe=1
    fi

    if echo "$line" | grep --quiet "ACTION=add"; then
        is_plugging_in=1
        trigger_engaged=1
    elif echo "$line" | grep --quiet "ACTION=remove"; then
        is_plugging_in=0
        trigger_engaged=1
    fi

    if [[ $trigger_engaged -eq 1 && $is_probe -eq 1 ]]; then
        if [[ $is_plugging_in -eq 1 && $waiting_for -eq 1 ]]; then
            notify-send "Debugprobe on Pico detected"
            waiting_for=0
        elif [[ $is_plugging_in -eq 0 && $waiting_for -eq 0 ]]; then
            notify-send "Debugprobe on Pico unplugged"
            waiting_for=1
        fi

        trigger_engaged=0
        is_probe=0
    fi
done

rm -f "$LOCKFILE"
