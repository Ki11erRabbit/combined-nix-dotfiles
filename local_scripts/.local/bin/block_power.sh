#!/bin/sh

case $BLOCK_BUTTON in
    1) notify-send "Current Power Profile" "$(powerprofilesctl get)";;
    2) power_profile_set.sh ;;
    4)
        case $(powerprofilesctl get) in
            balanced) powerprofilesctl set performance ;;
            power-saver) powerprofilesctl set balanced ;;
        esac
        ;;
    5)
        case $(powerprofilesctl get) in
            performance) powerprofilesctl set balanced ;;
            balanced) powerprofilesctl set power-saver ;;
        esac
        ;;
esac

for battery in /sys/class/power_supply/BAT?*; do
    # If non-first battery, print a space separator.
    [ -n "${capacity+x}" ] && printf " "

    capacity="$(cat "$battery/capacity" 2>&1)"
    if [ "$capacity" -gt 90 ]; then
        color="40a02b"
        start="3"
        width="20"
    elif [ "$capacity" -gt 70 ]; then
        color="40a02b"
        start="10"
        width="13"
    elif [ "$capacity" -gt 50 ]; then
        color="df8e1d"
        start="14"
        width="9"
    elif [ "$capacity" -gt 30 ]; then
        color="fe640b"
        start="16"
        width="7"
    elif [ "$capacity" -gt 10 ]; then
        color="dd7878"
        start="18"
        width="5"
    else
        color="d20f39"
        start="20"
        width="3"
    fi
    
    echo "^r0,7,2,4^^r2,4,22,10^^c#ffffff^^r3,5,20,8^^c#${color}^^r${start},5,${width},8^^d^^f24^ ${capacity}%"
done
