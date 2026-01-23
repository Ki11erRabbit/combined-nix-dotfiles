#!/bin/sh
swayidle -w \
    timeout 900 'wlopm --off DP-1 --off DP-2 --off HDMI-A-1' \
        resume 'wlopm --on DP-1 --on DP-2 --on HDMI-A-1' \
    timeout 1800 'lockscreen.sh' \
        resume 'wlopm --on DP-1 --on DP-2 --on HDMI-A-1' \
    before-sleep 'lockscreen.sh' &

