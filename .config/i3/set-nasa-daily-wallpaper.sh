#!/bin/bash

API_KEY=$(cat nasa-api-key)
API_URL="https://api.nasa.gov/planetary/apod?api_key=${API_KEY}"

response=$(curl -s "$API_URL")

hd_image_url=$(echo "$response" | jq -r '.hdurl')

if [ -e "/tmp/nasa-wallpaper.jpg" ]; then
    feh --bg-fill /tmp/nasa-wallpaper.jpg
fi

while ! ping -c 1 1.1.1.1 ; do sleep 1 ; done

curl -o /tmp/nasa-wallpaper.jpg "$hd_image_url"

feh --bg-fill /tmp/nasa-wallpaper.jpg
