#!/bin/bash

wallpaper_path="$HOME/.cache/wallpaper.jpg"

updateWallpaper() {
    mkdir -p $(dirname "$wallpaper_path")

    API_URL="https://api.wikimedia.org/feed/v1/wikipedia/en/featured/$(date +%Y/%m/%d)"

    while ! ping -c 1 1.1.1.1 ; do sleep 1 ; done

    response=$(curl -s "$API_URL")

    image_url=$(echo "$response" | jq -r '.image.image.source')

    if curl -o "$wallpaper_path" "$image_url"; then
        notify-send "$(date +%d.%m.%Y\ %H:%M:%S) Wallpaper updated"
    else
        notify-send -u critical "$(date +%d.%m.%Y\ %H:%M:%S) Failed to download new wallpaper."
    fi
}

while true; do
    if [ -e "$wallpaper_path" ]; then
        feh --bg-fill "$wallpaper_path"
    fi
    snooze -M 1 -s 1d -t "$wallpaper_path"
    updateWallpaper;
done


# Sadly nasa is not available anymore
#
# wallpaper_path="$HOME/.cache/nasa-wallpaper.jpg"
#
# mkdir -p $(dirname "$wallpaper_path")
#
# if [ -e "$HOME/.config/nasa-api-key" ]; then
#     API_KEY=$(cat $HOME/.config/nasa-api-key)
#     API_URL="https://api.nasa.gov/planetary/apod?api_key=${API_KEY}"
#
#     if [ -e "$wallpaper_path" ]; then
#         feh --bg-fill "$wallpaper_path"
#     fi
#
#     while ! ping -c 1 1.1.1.1 ; do sleep 1 ; done
#
#     response=$(curl -s "$API_URL")
#
#     hd_image_url=$(echo "$response" | jq -r '.hdurl')
#
#     curl -o $wallpaper_path "$hd_image_url"
# else
#     magick -size 1920x1080 xc:black -fill white -pointsize 50 -gravity center -draw "text 0,0 'No nasa api key found (expecting file \`\$HOME/.config/nasa-api-key\`)'" "$wallpaper_path"
# fi
#
# feh --bg-fill "$wallpaper_path"
