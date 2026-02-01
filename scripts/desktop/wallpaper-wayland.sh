#!/bin/sh

widepapers="$HOME/Pictures/Wallpapers/Widepapers/"
widepapers_list="$HOME/widepapers_list.txt"
tallpapers="$HOME/Pictures/Wallpapers/Tallpapers/"
tallpapers_list="$HOME/tallpapers_list.txt"

# $1 label
# $2 wallpaper list
# $3 wallpaper dir
function select_wallpaper () {
    if [[ ! -s "$2" ]]; then
        find "$3" -name "*.png" -o -name "*.jpeg" -o -name "*.jpg" -o -name "*.webm" -o -name "*.mp4" | shuf > "$2"
    fi
    
    file=$(head -n 1 "$2")
    
    # Use a temp file to avoid corruption
    tail -n +2 "$2" > "$2.tmp"
    mv "$2.tmp" "$2"
    
    echo "$1: $file" >> "$HOME/wallpaper.log"
    echo "$file"
}

file1=$(select_wallpaper "wide1" "$widepapers_list" "$widepapers")
file2=$(select_wallpaper "wide2" "$widepapers_list" "$widepapers")
file3=$(select_wallpaper "tall" "$tallpapers_list" "$tallpapers")

# $1 display
# $2 file
function apply_wallpaper () {
    case $2 in
        *.png|*.jpeg|*.jpg)
            swaybg -o "$1" -i "$2" -m fill &
            ;;
        *.webm|*.mp4)
            mpvpaper -o "no-audio loop" "$1" "$2" &
            ;;
    esac
}

pkill swaybg
pkill mpvpaper
pkill .mpvpaper-wrapp

apply_wallpaper "DP-1" "$file1"
apply_wallpaper "DP-2" "$file2"
apply_wallpaper "HDMI-A-1" "$file3"
