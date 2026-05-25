#!/bin/bash
# Vanguard Heartbeat: Minimal site change detector
# Checks target URLs for content change

TARGETS="$HOME/Projects/agents/hermes/vanguard-space-search/targets.txt"
TMP_DIR="$HOME/Projects/agents/hermes/.tmp"
WEBHOOK_URL="https://chat.googleapis.com/v1/spaces/AAQADERX6Ss/messages?key=AIzaSyDdI0hCZtE6vySjMm-WEfRq3CPzqKqqsHI&token=fXiuTWKyOk4Dr7muqzvQRtNXsCX1lDz6C1K6TiVxDhc"

mkdir -p "$TMP_DIR"

while read -r url; do
    if [ -z "$url" ]; then continue; fi
    
    # Generate a unique hash for this URL
    ID=$(echo "$url" | md5)
    FILE="$TMP_DIR/$ID.txt"
    
    # Get current page signature
    CURRENT=$(curl -sL "$url" | sed 's/<[^>]*>//g' | md5)
    
    # Check if we have a previous state
    if [ -f "$FILE" ]; then
        LAST=$(cat "$FILE")
        if [ "$CURRENT" != "$LAST" ]; then
            MESSAGE="Vanguard Alert: Change detected at $url"
            curl -X POST -H 'Content-Type: application/json' \
                 -d "{\"text\": \"$MESSAGE\"}" \
                 "$WEBHOOK_URL"
        fi
    fi
    
    # Update state
    echo "$CURRENT" > "$FILE"
done < "$TARGETS"
