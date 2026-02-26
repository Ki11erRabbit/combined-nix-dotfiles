#!/bin/bash

direction=$1

workspaces=$(swaymsg -t get_workspaces)
current_workspace=$(echo "${workspaces}" | jq '.[] | select(.focused==true).num')

case $direction in
    left)
        if [ "${current_workspace: -1}" = "1" ]; then
            exit 0
        fi
        workspace="$(( $current_workspace - 1 ))"
        swaysome focus "$workspace"
        ;;
    right)
        if [ "${current_workspace: -1}" = "9" ]; then
            exit 0
        fi
        workspace="$(( $current_workspace + 1 ))"
        swaysome focus "$workspace"
        ;;
esac
