#!/bin/zsh

export PATH="/home/ki11errabbit/.local/bin:$PATH"

gentoo-pipewire-launcher &
feh --bg-fill /home/ki11errabbit/Pictures/Wallpapers/wp14593283-windows-xp-anime-wallpapers.jpg
feh --bg-fill /home/ki11errabbit/Pictures/Wallpaper/78657213_p0.jpg
feh --bg-fill /home/ki11errabbit/Downloads/__astolfo_and_sieg_fate_and_1_more_drawn_by_haoro__43716a018163d88756f849fb040e765d.jpg

if cat /proc/bus/input/devices | grep -qi "japanese\|jis\|AT Translated Set 2 keyboard"; then
    echo "JIS keyboard detected"
    setxkbmap -layout jis_colemak_dh
else
    echo "ANSI keyboard detected"
    setxkbmap us -variant colemak_dh -option caps:backspace
fi

xset r 66

dwmblocks &

dwm-lock.sh &
