#!/usr/bin/env bash

windows=$(
	hyprctl clients -j | jq -c '.[]' | while read value; do
		window=$(echo $value | jq -cr '.address')
		workspace=$(echo $value | jq -c '.workspace.id')
		if [[ "$workspace" == "$1" ]]; then
			echo "dispatch movetoworkspace +0,address:${window};"
		fi
	done
)
if [[ -z $windows ]]; then
	hyprctl dispatch "movetoworkspacesilent $1"
else
	hyprctl --batch "$windows"
fi