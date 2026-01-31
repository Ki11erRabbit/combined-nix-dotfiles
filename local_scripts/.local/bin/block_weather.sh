#!/bin/sh

case $BLOCK_BUTTON in
    1) notify-send "Weather Report" "$(curl wttr.in)";;
esac


curl wttr.in/?format=1
