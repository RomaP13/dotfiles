#!/bin/bash

# Toggle mic mute
pactl set-source-mute @DEFAULT_SOURCE@ toggle

# Check new state
IS_MUTED=$(pactl get-source-mute @DEFAULT_SOURCE@ | awk '{print $2}')

# Show notification
if [ "$IS_MUTED" = "yes" ]; then
    notify-send "Microphone" "Muted" -t 2000
else
    notify-send "Microphone" "Unmuted" -t 2000
fi
