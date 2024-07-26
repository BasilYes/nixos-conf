#!/usr/bin/env bash

window=$(hyprctl activewindow -j | jq -rc ".class")

if [[ -n $2 ]]; then
	name=$2
else
	name=$1
fi

if [[ -n $3 ]]; then
	command=$3
else
	command=$name
fi

workspace=$(hyprctl workspaces | grep "(special:nautilus_pocket)") 

echo $workspace

if [[ $window == $1 || -n $workspace ]]; then
	hyprctl --batch "
		dispatch togglespecialworkspace ${name}_pocket;
		dispatch movetoworkspace +0;
		dispatch togglespecialworkspace ${name}_pocket;
		dispatch movetoworkspace special:${name}_pocket;
		dispatch togglespecialworkspace ${name}_pocket;
	"
else
	hyprctl dispatch "exec ${command}"
fi
echo $command