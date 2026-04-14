#!/bin/sh
swayidle -w \
    timeout 900 'wlopm --off eDP-1' \
        resume 'wlopm --on eDP-1' \
    timeout 1800 'qs -c noctalia-shell ipc call lockScreen lock' \
        resume 'wlopm --on eDP-1' \
    before-sleep 'qs -c noctalia-shell ipc call lockScreen lock' &

