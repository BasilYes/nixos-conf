#!/usr/bin/env bash

current=$(hyprctl activewindow -j | jq -cr '.workspace.id')
hyprctl --batch "$(
	hyprctl clients -j | jq -c '.[]' | while read value; do
		window=$(echo $value | jq -cr '.address')
		workspace=$(echo $value | jq -c '.workspace.id')
		if [[ "$workspace" == "$current" ]]; then
			echo "dispatch closewindow address:$window;"
		fi
	done
)"