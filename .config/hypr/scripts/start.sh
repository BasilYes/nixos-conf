#!/usr/bin/env bash


wl-clipboard-history -t &
wl-paste --watch cliphist store &
rm "$HOME/.cache/cliphist/db" &

nm-applet --indicator &
blueman-applet &

udiskie &
otd-daemon &
bash ~/.config/waybar/launch.sh &
rm -f /tmp/hypr/switch_*_temp &

swaync &

hyprctl --batch "dispatch focusmonitor 1; dispatch workspace 12;" &&
sleep 0.1 &&
hyprctl dispatch "workspace 1" &&
hyprctl --batch "dispatch focusmonitor 0; dispatch workspace 11;"