#!/bin/bash

# script to display brighness

# Arbitrary but unique message id
msgId="991050"
brightnessctl set $1

# Query brightnessctl for the current brighness
maxbrightness="$(brightnessctl max)"
gotbrightness="$(brightnessctl get)"
brightness="$(expr 100 \* $gotbrightness / $maxbrightness)"

# Display the brightness
makoctl dismiss
dunstify -a "changeBrightness" -u low -i audio-volume-high -r "$msgId" \
"Brightness: ${brightness}%"
# notify-send "Brightness: $brightness%"

# Play the volume changed sound
canberra-gtk-play -i audio-volume-change
