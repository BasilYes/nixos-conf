#!/usr/bin/env bash

pwaybar=$(pgrep "waybar")
if [[ $1 == true || -z $1 ]] && [[ -z $pwaybar ]]; then
	waybar &
	blueman-applet
elif [[ $1 == false || -z $1 ]] && [[ -n $pwaybar ]]; then
	pkill waybar
	pkill blueman &
fi