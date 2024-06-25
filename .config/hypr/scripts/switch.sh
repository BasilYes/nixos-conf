#!/usr/bin/env bash

file=/tmp/hypr/switch_${1}_temp

if [[ -f "$file" ]]; then
	switch=$(<"$file")
else
	switch="false"
fi

if [[ "$switch" == "true" ]]; then
	echo "false" > "$file"
	hyprctl dispatch "exec ${3}"
else
	echo "true" > "$file"
	hyprctl dispatch "exec ${2}"
fi
