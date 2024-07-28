#!/usr/bin/env bash

window=$(hyprctl activewindow -j | jq -rc ".class")

class=$1
if [[ -n $2 ]]; then
	name=$2
else
	name=$class
fi
if [[ -n $3 ]]; then
	command=$3
else
	command=$name
fi

workspace=$(hyprctl workspaces | grep "(special:nautilus_pocket)") 
activeworkspace=$(hyprctl activeworkspace -j | jq -rc ".name")
if [[ $window == $class || -n $workspace ]]; then
	hyprctl --batch "
		dispatch togglespecialworkspace ${name}_pocket;
		dispatch movetoworkspace name:${activeworkspace};
		dispatch togglespecialworkspace ${name}_pocket;
		dispatch moveoutofgroup;
		dispatch movetoworkspace special:${name}_pocket;
		dispatch togglespecialworkspace ${name}_pocket;
	"
else
	hyprctl --batch "
		dispatch moveoutofgroup class:${class};
		dispatch movetoworkspace name:${activeworkspace},class:${class};
		dispatch focuswindow class:${class};
	"

	window=$(hyprctl activewindow -j | jq -rc ".class")
	if [[ $window != $class ]]; then
		hyprctl dispatch "exec ${command}"
	fi
fi
echo $command