#!/bin/bash

source "$HOME/.config/sketchybar/colors.sh"

# Check Spotify playback state
#STATE=$(osascript -e 'tell application "Spotify" to player state' 2>/dev/null)

# If Spotify is not running or no music is playing
#if [ "$STATE" != "playing" ]; then
#  sketchybar --set spotify.anchor label="Not Playing" icon="􁁒" drawing=on
#  exit 0
#fi

# Fetch Spotify details
#TITLE=$(osascript -e 'tell application "Spotify" to name of current track')
#ARTIST=$(osascript -e 'tell application "Spotify" to artist of current track')
#ALBUM=$(osascript -e 'tell application "Spotify" to album of current track')

# Update SketchyBar items dynamically
#sketchybar --set spotify.title label="$TITLE"
#sketchybar --set spotify.artist label="by $ARTIST"
#sketchybar --set spotify.album label="on $ALBUM"
#sketchybar --set spotify.anchor icon="􁁒" label="$TITLE - $ARTIST" drawing=on
