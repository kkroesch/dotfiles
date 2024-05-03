#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 URL"
    exit 1
fi

URL="$1"

TITLE=$(curl -sL "$URL" | grep -o '<title>.*</title>' | sed 's/<[\/]*title>//g' | tr -d '\n' | cut -c 1-50)
FILENAME=$(echo "$TITLE" | awk '{ gsub(/[\/:*?"<>|]/, "-"); print $0 }').url

# Speichere die URL in einer Datei mit dem extrahierten Titel als Dateinamen
echo "$URL" > "$FILENAME"

