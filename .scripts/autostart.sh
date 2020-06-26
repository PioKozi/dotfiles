#!/bin/bash

if [[ -z "$(pgrep batsignal)" ]]; then
    batsignal -w 20 -c 5 -d 2 -f 100 -W "BATTERY LOW" -C "BATTERY CRITICAL" -F "BATTERY FULL" -a "battery" -b
fi

if [[ -z "$(pgrep dunst)" ]]; then
    dunst &
fi

if [[ -z "$(pgrep sxhkd)" ]]; then
    sxhkd &
fi

if [[ -z "$(pgrep slstatus)" ]]; then
    slstatus &
fi

if [[ -z "$(pgrep flameshot)" ]]; then
    flameshot &
fi

if [[ -z "$(pgrep xbanish)" ]]; then
    xbanish &
fi

# feh --bg-fill `ls -d $HOME/Pictures/wallpapers/gruvbox/* | shuf -n 1`
feh --no-fehbg --bg-fill $HOME/Pictures/wallpapers/gruvbox/campfire.png
