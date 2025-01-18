#!/usr/bin/env bash

window=$(hyprctl activewindow -j)
group=$(echo $window | jq -cr '.grouped')

if [[ $group == "[]" ]]; then
    if [[ $1 == "prev" ]]; then
        hyprctl dispatch cyclenext prev
    else
        hyprctl --batch "dispatch cyclenext; dispatch bringactivetotop"
    fi
else
    if [[ $1 == "prev" ]]; then
        hyprctl dispatch changegroupactive b
    else
        hyprctl dispatch changegroupactive f
    fi
fi
