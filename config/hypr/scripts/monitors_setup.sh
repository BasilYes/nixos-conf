#!/usr/bin/env bash


system=$(hyprctl systeminfo | grep "Node name:" | sed "s@Node name: @@")

if [ $system == "basilyes-desktop24" ]; then
    if [[ $1 -eq 1 ]]; then
				echo monitor1
        hyprctl keyword "monitor" "DP-3, 1920x1080@60, 0x0, 1"
        hyprctl keyword "monitor" "HDMI-A-1, disable"
    elif [[ $1 -eq 2 ]]; then
				echo monitor2
        hyprctl keyword "monitor" "HDMI-A-1, 1920x1080@60, 0x0, 1"
        hyprctl keyword "monitor" "DP-3, disable"
    elif [[ "$1" -eq "d" ]]; then
				echo monitors
        hyprctl keyword "monitor" "HDMI-A-1, 1920x1080@60, -1920x0, 1"
        hyprctl keyword "monitor" "DP-3,  1920x1080@60, 0x0, 1"
    elif [[ "$1" == "m" ]]; then
				echo monitor_mirror
        hyprctl keyword "monitor" "DP-3, 1920x1080@60, 0x0, 1"
        hyprctl keyword "monitor" "HDMI-A-1, 1920x1080@60, 0x0, 1, mirror, DP-3"
    fi
elif [ $system == "basilyes-laptop" ]; then
    hyprctl keyword "monitor" "eDP-1, 1920x1080@60, 0x0, 1"
fi

if [[ -n $(pgrep "waybar") ]]; then
	bash ~/.config/waybar/launch.sh
fi
