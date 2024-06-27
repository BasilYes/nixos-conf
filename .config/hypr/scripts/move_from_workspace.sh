#!/usr/bin/env bash

hyprctl \
  --batch "$(
# echo \
  # "$(
	hyprctl clients -j | jq -c '.[]' | while read value; do
		window=$(echo $value | jq -cr '.address')
		workspace=$(echo $value | jq -c '.workspace.id')
		if [[ "$workspace" == "$1" ]]; then
			echo "dispatch movetoworkspace +0,address:${window};"
		fi
	done
	)"