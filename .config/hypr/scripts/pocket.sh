#!/usr/bin/env bash

activeworkspace=$(hyprctl activeworkspace -j | jq -rc ".name")
windows=$(
	hyprctl clients -j | jq -c '.[]' | while read value; do
		window=$(echo $value | jq -cr '.address')
		workspace=$(echo $value | jq -cr '.workspace.name')
		if [[ $workspace == "special:$1" ]]; then
			echo "dispatch movetoworkspace ${activeworkspace},address:${window};"
		fi
	done
)
if [[ -z $windows ]]; then
	hyprctl dispatch "movetoworkspacesilent special:$1"
else
	hyprctl --batch "$windows"
fi