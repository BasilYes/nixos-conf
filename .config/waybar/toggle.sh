#!/usr/bin/env bash

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use
# polybar-msg cmd quit
# Otherwise you can use the nuclear option:
if [[ -z $(pgrep "waybar") ]]; then
	waybar
else
	pkill waybar
fi