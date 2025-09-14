#!/bin/bash

pkill swaybg

WALLPAPER_DIR="$HOME/dots/wallpapers"

DIR=$(find $WALLPAPER_DIR/* -type d | shuf -n 1)

WALLPAPER=$(ls "$DIR" | shuf -n 1)

swaybg -i "$DIR/$WALLPAPER"
