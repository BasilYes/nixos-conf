#!/usr/bin/env bash


system=$(hyprctl systeminfo | grep "Node name:" | sed "s@Node name: @@")

if [ $system == "basilyes-desktop" ]; then
	if [[ $1 -eq 1 ]]; then
		hyprctl keyword "monitor" "HDMI-A-1, 1920x1080@60, 0x0, 1"
		hyprctl keyword "monitor" "HDMI-A-3, disable"
	elif [[ $1 -eq 2 ]]; then
		hyprctl keyword "monitor" "HDMI-A-1, 1920x1080@60, 0x0, 1"
		hyprctl keyword "monitor" "HDMI-A-3, 1920x1080@60, -1920x0, 1"
	fi
elif [ $system == "basilyes-laptop" ]; then
	hyprctl keyword "monitor" "eDP-1, 1920x1080@60, 0x0, 1"
fi

if [[ -n $(pgrep "waybar") ]]; then
	bash ~/.config/waybar/launch.sh
fi