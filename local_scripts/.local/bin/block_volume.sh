#!/bin/sh

case "$BLOCK_BUTTON" in

esac

vol=$(amixer sget Master | awk 'NR == 6 { print $5 }')
vol=${vol:1:-2}

mute_state="$(amixer sget Master | awk 'NR == 6 { print $6 }')"
mute_state=${mute_state:1:-1}

if [ "$mute_state" == "on" ]; then
    if [ "$vol" -gt "99" ]; then
        icon="🔊"
    elif [ "$vol" -gt "70" ]; then
        icon="🔊 "
    elif [ "$vol" -gt "30" ]; then
        icon="🔉 "
    elif [ "$vol" -gt "9" ]; then
        icon="🔉 "
    elif [ "$vol" -gt "0" ]; then
        icon="🔈  "
    else
        echo " 🔇  $vol%" && exit
    fi
elif [ "$mute_state" == "off" ]; then
    echo " 🔇  $vol%" && exit
fi


echo "$icon$vol%"
