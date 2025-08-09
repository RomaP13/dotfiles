#!/bin/bash

# Map IDs to sink names
SINK_56_NAME="alsa_output.pci-0000_00_1f.3.analog-stereo"
SINK_58_NAME="alsa_output.usb-C-Media_Electronics_Inc._USB_Audio_Device-00.analog-stereo"

# Get current default sink name
CURRENT_SINK=$(pactl get-default-sink)

# Toggle and show notification with sink name
if [[ "$CURRENT_SINK" == "$SINK_56_NAME" ]]; then
    pactl set-default-sink "$SINK_58_NAME"
    notify-send "Audio Output" "Switched to USB" -t 2000
else
    pactl set-default-sink "$SINK_56_NAME"
    notify-send "Audio Output" "Switched to Analog" -t 2000
fi

# Move playing streams to the new default sink
NEW_SINK=$(pactl get-default-sink)
pactl list short sink-inputs | cut -f1 | while read -r INPUT; do
    pactl move-sink-input "$INPUT" "$NEW_SINK"
done

