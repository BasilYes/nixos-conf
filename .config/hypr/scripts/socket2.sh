#!/usr/bin/env bash

function handle {
  if [[ ${1:0:12} == "activewindow" ]]; then
    if [[ ${1:14:30} == "steam,Steam Big Picture Mode" ]]; then
			window=$(hyprctl activewindow -j)
			fullscreen=$(echo $window | jq -cr '.fullscreen')
			if [[ $fullscreen == "0" ]]; then
				hyprctl dispatch "fullscreenstate 2"
			fi
		# elif [[ ${1:14:10} == "steam_app_" ]]; then
		# 	hyprctl dispatch "fullscreenstate 2"
    fi
  fi
}

socat - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r line; do handle "$line"; done
