#!/bin/bash

# script to display audio

# Arbitrary but unique message id
msgId="991049"
pulsemixer --toggle-mute

# Query pulsemixer for the current volume and whether or not the speaker is muted
volume="$(pulsemixer --get-volume)"
mute="$(pulsemixer --get-mute)"

makoctl dismiss
if [[ $volume == 0 || "$mute" == "1" ]]; then
    # Show the sound muted notification
    dunstify -a "output volume" -u low -i audio-volume-muted -r "$msgId" "Volume muted" 
    # notify-send "Output muted"
else
    # Show the volume notification
    dunstify -a "output volume" -u low -i audio-volume-high -r "$msgId" \
    "Volume: ${volume}%"
    # notify-send "Output volume: $volume%"
fi

# Play the volume changed sound
canberra-gtk-play -i audio-volume-change
