#!/usr/bin/env bash

choice="$(echo -e "toggle\nstatus\nqueue\nnext\nprev\nshuffle\nupdate\nstop\nplay" | dmenu)"
case $choice in
    "toggle" )
        mpc toggle
        ;;
    "status" )
        stat="$(mpc status | head -n 2)"
        echo -e $stat | dmenu
        ;;
    "queue" )
        queue="$(mpc queued)"
        echo -e $queue | dmenu
        ;;
    "next" )
        mpc next
        ;;
    "prev" )
        mpc prev
        ;;
    "shuffle" )
        mpc shuffle
        ;;
    "update" )
        mpc update
        ;;
    "stop" )
        mpc stop
        ;;
    "play" )
        mpc play
        ;;
esac
