#!/bin/bash

TOKEN="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJmMDg2Mzk2YTk5YWE0ZjZiYTdiYWYxZmMzOTU0MDIxZCIsImlhdCI6MTc4Nzc1ODE2NCwiZXhwIjoyMTAzMTE4MTY0fQ._8C2NwAC23VHEl8k2-tlwiYUf1Pv9PtolGhVGZrQzWM"
ENTITY_ID="sensor.jonas_handy_battery_level"
HOME_ASSISTANT_URL="http://192.168.2.50:8123/api/states/$ENTITY_ID"
CACHE_FILE="/tmp/phone_battery_level_cache"
CHECK_INTERVAL=60

BATTERY_LEVEL=$(curl -s -H "Authorization: Bearer $TOKEN" \
                     -H "Content-Type: application/json" \
                     "$HOME_ASSISTANT_URL" | \
                     jq -r '.state')

if [ -f "$CACHE_FILE" ]; then
    CACHED_BATTERY_LEVEL=$(cat "$CACHE_FILE")
else
    CACHED_BATTERY_LEVEL=""
fi

while true; do
    nofify-send $BATTERY_LEVEL
    if [ "$BATTERY_LEVEL" != "$CACHED_BATTERY_LEVEL" ] && [ "$BATTERY_LEVEL" = "57" ]; then
        notify-send "PHONE CHARGE LIMIT REACHED" "Battery level is now at 86%"
        echo "$BATTERY_LEVEL" > "$CACHE_FILE"
    fi
    sleep $CHECK_INTERVAL
done
