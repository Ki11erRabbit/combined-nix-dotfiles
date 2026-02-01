#!/bin/sh

options="performance
balanced
power-saver"

selected="$(echo "$options" | dmenu -p "New Powerstate:")"

powerprofilesctl set "$selectd"
