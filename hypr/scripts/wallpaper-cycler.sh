#!/bin/bash

DIR=$HOME/Pictures/wallpapers
INTERVAL=600
MONITOR=$(hyprctl monitors | grep Monitor | awk '{print $2}')
CONFIG_FILE=$HOME/.config/hypr/hyprpaper.conf

if [ -d "$DIR" ]; then
    killall hyprpaper
    # Get a random wallpaper
    FIRST_RANDOM_WALL=$(find $DIR/*.jpg | shuf -n 1)
    # Provide the initial config file in order to not get an error
    echo "preload = $FIRST_RANDOM_WALL" > $CONFIG_FILE
    echo "wallpaper = $MONITOR,$FIRST_RANDOM_WALL" >> $CONFIG_FILE
    hyprpaper &
    while true; do
        sleep $INTERVAL
        CURRENT_WALL=$(hyprctl hyprpaper listloaded)
        # Get a random wallpaper that is not the current one
        NEXT_WALL=$(find $DIR/*.jpg -type f ! -name "$(basename "$CURRENT_WALL")" | shuf -n 1)
        # Apply the selected wallpaper
        hyprctl hyprpaper unload all
        hyprctl hyprpaper preload "$NEXT_WALL"
        hyprctl hyprpaper wallpaper "$MONITOR, $NEXT_WALL"
    done
fi

