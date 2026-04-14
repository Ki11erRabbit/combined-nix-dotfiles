#!/bin/sh

widepapers="$HOME/Pictures/Wallpapers/Widepapers/"
widepapers_list="$HOME/widepapers_list_lockscreen.txt"
tallpapers="$HOME/Pictures/Wallpapers/Tallpapers/"
tallpapers_list="$HOME/tallpapers_list_lockscreen.txt"

# $1 label
# $2 wallpaper list
# $3 wallpaper dir
# $4 display
function select_wallpaper () {
    if [[ $(stat --printf="%s" "$2") == "0" ]]; then
        find "$3" -name "*.png" -or -name "*.jpeg" -or -name "*.jpg" | shuf -o "$2"
        file=$(cat $2 | head -n 1)
    else 
        file=$(cat $2 | head -n 1)
    fi
    exec 19<> "$2"
    tail -n +2 "$2" >&19 
    exec 19>&-
    echo "$1: $file" >> $HOME/lockscreen.log
    echo "$4:$file"

}


file1=$(select_wallpaper "wide1" "$widepapers_list" "$widepapers" DP-1)
file2=$(select_wallpaper "wide2" "$widepapers_list" "$widepapers" DP-2)
file3=$(select_wallpaper "tall" "$tallpapers_list" "$tallpapers" HDMI-A-1)

swaylock -ef -i "$file1" -i "$file2" -i "$file3"

