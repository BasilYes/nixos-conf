#!/usr/bin/env bash

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use
# polybar-msg cmd quit
# Otherwise you can use the nuclear option:
pkill waybar &

sleep 2.0 &&
# Launch bar1 and bar2
waybar &
# sleep 3 && pkill -SIGUSR1 waybar &
echo "Bars launched..."