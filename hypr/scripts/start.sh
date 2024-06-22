#!/usr/bin/env bash


wl-clipboard-history -t &
wl-paste --watch cliphist store &
rm "$HOME/.cache/cliphist/db" &

nm-applet --indicator &

udiskie &

bash ~/.config/waybar/launch.sh &

dunst
