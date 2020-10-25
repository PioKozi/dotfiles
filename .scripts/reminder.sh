#!/usr/bin/env bash

while true
do
    notify-send "Hourly Reminder" "Get up from the computer"
    canberra-gtk-play -i audio-volume-change
    sleep 1h 5m
done
