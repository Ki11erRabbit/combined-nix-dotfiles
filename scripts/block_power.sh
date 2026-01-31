#!/bin/sh


case $BLOCK_BUTTON in

esac


for battery in /sys/class/power_supply/BAT?*; do
    # If non-first battery, print a space separator.
    [ -n "${capacity+x}" ] && printf " "

    capacity="$(cat "$battery/capacity" 2>&1)"
    if [ "$capacity" -gt 90 ]; then
        color="31cc74"
        start="3"
        width="20"
    elif [ "$capacity" -gt 70 ]; then
        color="31cc74"
        start="10"
        width="13"
    elif [ "$capacity" -gt 50 ]; then
        color="eaed18"
        start="14"
        width="9"
    elif [ "$capacity" -gt 30 ]; then
        color="edaa18"
        start="16"
        width="7"
    elif [ "$capacity" -gt 10 ]; then
        color="ed7b18"
        start="18"
        width="5"
    else
        color="e32110"
        start="20"
        width="3"
    fi
    
    echo "^r0,7,2,4^^r2,4,22,10^^c#ffffff^^r3,5,20,8^^c#${color}^^r${start},5,${width},8^^d^^f24^"
done
