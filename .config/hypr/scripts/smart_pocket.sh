#!/usr/bin/env bash

window=$(hyprctl activewindow -j | jq -rc ".class")

if [[ -z $2 ]]; then
	2=$1
fi

if [[ -z $3 ]]; then
	3=$2
fi

workspace=$(hyprctl workspaces | grep "(special:nautilus_pocket)") 

echo $workspace

if [[ $window == $1 || -n $workspace ]]; then
	hyprctl --batch "
		dispatch togglespecialworkspace ${2}_pocket;
		dispatch movetoworkspace +0;
		dispatch togglespecialworkspace ${2}_pocket;
		dispatch movetoworkspace special:${2}_pocket;
		dispatch togglespecialworkspace ${2}_pocket;
	"
else
	hyprctl dispatch "exec ${3}"
fi