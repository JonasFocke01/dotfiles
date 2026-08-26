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

echo "PHONE BATTERY LEVEL "$BATTERY_LEVEL" %"
