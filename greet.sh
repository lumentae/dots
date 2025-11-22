#!/bin/bash

### Modify me ###
ENABLE_WEATHER=true
LATITUDE=$1
LONGITUDE=$2

CACHE_FILE="/tmp/weather_cache.json"
CACHE_TTL=$((10 * 60))
DEBUG=false

### DON'T modify me ###
echo -e "Hello \e[1;32m$(whoami)\e[0m!, it is currently \e[1;32m$(date '+%H:%M:%S %Z\e[0m on \e[1;32m%A, %B %d, %Y.\e[0m')"
if $ENABLE_WEATHER; then
    if [[ -f "$CACHE_FILE" ]]; then
        now=$(date +%s)
        modified=$(stat -c %Y "$CACHE_FILE")
        age=$((now - modified))

        if (( age < CACHE_TTL )); then
            if $DEBUG; then
                echo "DEBUG: Retrieved weather data from cache"
            fi
            WEATHER_RESULT=$(cat "$CACHE_FILE")
        else
            if $DEBUG; then
                echo "DEBUG: Cache file expired!"
            fi
            WEATHER_RESULT=$(curl -s "https://api.open-meteo.com/v1/forecast?latitude=$LATITUDE&longitude=$LONGITUDE&current=temperature_2m,wind_speed_10m")
            echo "$WEATHER_RESULT" > "$CACHE_FILE"
        fi
    else
        if $DEBUG; then
            echo "DEBUG: No cache file exists..."
        fi
        WEATHER_RESULT=$(curl -s "https://api.open-meteo.com/v1/forecast?latitude=$LATITUDE&longitude=$LONGITUDE&current=temperature_2m,wind_speed_10m")
        echo "$WEATHER_RESULT" > "$CACHE_FILE"
    fi

    TEMP_VALUE=$(echo "$WEATHER_RESULT" | jq -r '.current.temperature_2m')
    TEMP_UNIT=$(echo "$WEATHER_RESULT" | jq -r '.current_units.temperature_2m')
    TEMPERATURE="$TEMP_VALUE$TEMP_UNIT"

    WIND_VALUE=$(echo "$WEATHER_RESULT" | jq -r '.current.wind_speed_10m')
    WIND_UNIT=$(echo "$WEATHER_RESULT" | jq -r '.current_units.wind_speed_10m')
    WIND_SPEED="$WIND_VALUE$WIND_UNIT"
    echo -e "The current temperature is \e[1;32m$TEMPERATURE\e[0m and the wind speed is \e[1;32m$WIND_SPEED\e[0m, but you won't notice anyway..."
fi
