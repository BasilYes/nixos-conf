#!/usr/bin/env bash

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use
# polybar-msg cmd quit
# Otherwise you can use the nuclear option:
killall -q .waybar-wraped &

# Launch bar1 and bar2
waybar &

echo "Bars launched..."