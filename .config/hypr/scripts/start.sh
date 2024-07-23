#!/usr/bin/env bash


wl-clipboard-history -t &
wl-paste --watch cliphist store &
rm "$HOME/.cache/cliphist/db" &

nm-applet --indicator &
blueman-applet &

udiskie &
otd-daemon &
# bash ~/.config/waybar/launch.sh &
rm -f /tmp/hypr/switch_*_temp &

swaync &

kitty &

sleep 2 && bash ./monitors_setup.sh 1