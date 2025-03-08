#!/usr/bin/env bash

activewindow=$(hyprctl activewindow -j | jq -rc ".class")

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
if [[ -n $4 ]]; then
	workspace=$4
else
	workspace=0
fi

activeworkspace=$(hyprctl activewindow -j | jq -rc ".workspace.name")
if [[ "$activeworkspace" == "null" ]]; then
	activeworkspace=$(hyprctl activeworkspace -j | jq -rc ".name")
fi

echo "\"${activeworkspace}\""
if [[ $activewindow == $class ]]; then
	hyprctl --batch "
		dispatch movetoworkspacesilent ${workspace};
	"
else
	hyprctl --batch "
		dispatch moveoutofgroup class:${class};
		dispatch movetoworkspace ${activeworkspace},class:${class};
		dispatch focuswindow class:${class};
	"

	activewindow=$(hyprctl activewindow -j | jq -rc ".class")
	if [[ $activewindow != $class ]]; then
		hyprctl dispatch "exec ${command}"
	fi
fi
echo $command
