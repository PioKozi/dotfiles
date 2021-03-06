#!/bin/bash

# script to display brighness

# Arbitrary but unique message id
msgId="991050"

# Query brightnessctl for the current brighness
maxbrightness="$(brightnessctl max)"
gotbrightness="$(brightnessctl get)"
brightness="$(expr 100 \* $gotbrightness / $maxbrightness)"
echo $maxbrightness
echo $gotbrightness

# Display the brightness
dunstify -a "changeBrightness" -u low -i audio-volume-high -r "$msgId" \
"Brightness: ${brightness}%"

# Play the volume changed sound
canberra-gtk-play -i audio-volume-change
