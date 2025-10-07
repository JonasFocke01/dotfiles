#!/bin/bash

if [ -e "$HOME/nasa-api-key" ]; then
    API_KEY=$(cat $HOME/nasa-api-key)
    API_URL="https://api.nasa.gov/planetary/apod?api_key=${API_KEY}"

    if [ -e "$HOME/nasa-wallpaper.jpg" ]; then
        feh --bg-fill $HOME/nasa-wallpaper.jpg
    fi

    while ! ping -c 1 1.1.1.1 ; do sleep 1 ; done

    response=$(curl -s "$API_URL")

    hd_image_url=$(echo "$response" | jq -r '.hdurl')

    curl -o $HOME/nasa-wallpaper.jpg "$hd_image_url"
else
    magick -size 1920x1080 xc:black -fill white -pointsize 50 -gravity center -draw "text 0,0 'No nasa api key found (expecting file \`\$HOME/nasa-api-key\`)'" $HOME/nasa-wallpaper.jpg
fi

feh --bg-fill $HOME/nasa-wallpaper.jpg
