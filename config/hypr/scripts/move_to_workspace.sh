#!/usr/bin/env bash

IFS=' ' read -r -a array <<< "$(hyprctl activewindow)"
current_window=${array[1]}

hyprctl dispatch "movetoworkspacesilent $1,address:0x$current_window"
bash ~/.config/hypr/scripts/workspace.sh $1

exit 0