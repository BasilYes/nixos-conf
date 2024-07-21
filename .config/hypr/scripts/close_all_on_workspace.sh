#!/usr/bin/env bash

current=$(hyprctl activeworkspace -j | jq -cr '.id')
hyprctl clients -j | jq -c '.[]' | while read value; do
	window=$(echo $value | jq -cr '.pid')
	workspace=$(echo $value | jq -c '.workspace.id')
	if [[ "$workspace" == "$current" ]]; then
		kill $window
	fi
done