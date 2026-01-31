#!/bin/sh

options=("performance" "balanced" "power-saver")

selected="$(echo "$options" | demenu -p "New Powerstate:")"

powerprofilesctl set "$selectd"
