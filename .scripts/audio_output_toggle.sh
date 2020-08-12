#!/bin/bash

# script to display audio

# Arbitrary but unique message id
msgId="991049"
pactl set-sink-mute 0 toggle

# Query pulsemixer for the current volume and whether or not the speaker is muted
volume="$(pulsemixer --get-volume --id 0)"
mute="$(pulsemixer --get-mute --id 0)"

if [[ $volume == 0 || "$mute" == "1" ]]; then
    # Show the sound muted notification
    dunstify -a "output volume" -u low -i audio-volume-muted -r "$msgId" "Volume muted" 
else
    # Show the volume notification
    dunstify -a "output volume" -u low -i audio-volume-high -r "$msgId" \
    "Volume: ${volume}%"
fi

# Play the volume changed sound
canberra-gtk-play -i audio-volume-change
