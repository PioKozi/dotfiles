#!/bin/bash
# piokozi's startup script

if ! [[pgrep dunst]]
then
	dunst &
fi

if ! [[pgrep sxhkd]]
then
	sxhkd &
fi

if ! [[pgrep slstatus]]
then
	slstatus &
fi

if ! [[pgrep flameshot]]
then
    flameshot &
fi

if ! [[pgrep xbanish]]
then
    xbanish &
fi

 # feh --bg-fill `ls -d $HOME/Pictures/wallpapers/gruvbox/* | shuf -n 1`
 # yeah, the variety is nice, but I just like this wallpaper more

feh --bg-fill $HOME/Pictures/wallpapers/gruvbox/linux_user_at_best_buy.png
