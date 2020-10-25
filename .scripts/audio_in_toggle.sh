#!/bin/bash

# script to display audio

# Arbitrary but unique message id
msgId="991048"
pulsemixer --toggle-mute --id 1

# Query pulsemixer for the current volume and whether or not the speaker is muted
volume="$(pulsemixer --get-volume --id 1)"
mute="$(pulsemixer --get-mute --id 1)"

makoctl dismiss
if [[ $volume == 0 || "$mute" == "1" ]]; then
    # Show the sound muted notification
    dunstify -a "input volume" -u low -i audio-volume-muted -r "$msgId" "Volume muted" 
    # notify-send "Mic muted"
else
    # Show the volume notification
    dunstify -a "input volume" -u low -i audio-volume-high -r "$msgId" \
    "Volume: ${volume}%"
    # notify-send "Input Volume: $volume%"
fi

# Play the volume changed sound
canberra-gtk-play -i audio-volume-change
