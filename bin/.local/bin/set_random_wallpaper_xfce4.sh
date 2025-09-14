#!/bin/bash

WALLPAPER_DIR="/home/roman/Pictures/wallpapers"

DIR=$(find $WALLPAPER_DIR/* -type d | shuf -n 1)

WALLPAPER=$(ls "$DIR" | shuf -n 1)

xfce4-set-wallpaper "$DIR/$WALLPAPER"
