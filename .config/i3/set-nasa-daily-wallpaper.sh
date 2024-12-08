#!/bin/bash

API_KEY="EgH2nOsaD5w2fQzWztXGhVnAf0h0o2qJvpR64VHv"
API_URL="https://api.nasa.gov/planetary/apod?api_key=${API_KEY}"

response=$(curl -s "$API_URL")

hd_image_url=$(echo "$response" | jq -r '.hdurl')

curl -o /tmp/nasa-wallpaper.jpg "$hd_image_url"

feh --bg-fill /tmp/nasa-wallpaper.jpg

rm /tmp/nasa-wallpaper.jpg
