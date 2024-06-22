#!/usr/bin/env bash


wl-clipboard-history -t &
wl-paste --watch cliphist store &
rm "$HOME/.cache/cliphist/db" &

swww init &
swww img ~/Wallpapers/galaxy-cosmic-3840x2160-14974.jpg &

nm-applet --indicator &

waybar &

dunst
