#!/usr/bin/env bash

IFS=' ' read -r -a array <<< "$(hyprctl activewindow)"
current_window=${array[1]}

bash ~/.config/hypr/scripts/workspace.sh $1
hyprctl dispatch "movetoworkspace $1,address:0x$current_window"

exit 0