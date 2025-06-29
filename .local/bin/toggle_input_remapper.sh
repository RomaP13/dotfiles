#!/bin/bash

# NOTE: input-remapper-control requires sudo permissions. So, you need to edit the sudoers file safely: `sudo visudo`
# and add this line at the bottom: `<your_user> ALL=(ALL) NOPASSWD: /usr/bin/input-remapper-control`
# Replace <your_user> with your actual username, and verify the correct path with:
# `which input-remapper-control`

echo "$(date) Script triggered, state=$STATE" >> ~/.cache/remap_toggle.log

TOGGLE_STATE_FILE="$HOME/.cache/toggle-state-remap.txt"

if [ ! -f "$TOGGLE_STATE_FILE" ]; then
  echo "1" > "$TOGGLE_STATE_FILE"
fi

STATE=$(cat "$TOGGLE_STATE_FILE")

# Execute the corresponding command and update the state
if [ "$STATE" -eq 1 ]; then
    sudo input-remapper-control --command start --device "GASIA USB KB V11" --preset "mouse"
    notify-send "Remmaper Output" "MAPPING: ON" -t 2000
    echo "2" > "$TOGGLE_STATE_FILE"
else
    sudo input-remapper-control --command stop --device "GASIA USB KB V11"
    notify-send "Remmaper Output" "MAPPING: OFF" -t 2000
    echo "1" > "$TOGGLE_STATE_FILE"
fi
