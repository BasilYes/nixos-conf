#!/usr/bin/env bash

# Flags:

# r: region
# s: screen
# w: window
#
# TODO:
# c: control selection
# i: interactive

# p: pixel

if [[ $1 == r ]]; then
    mkdir -p $HOME/Pictures/Screenshots
    dirname=$HOME/Pictures/Screenshots/
		filename=$(date +%Y-%m-%d_%H-%M-%S).png
		hyprshot -m region -o $dirname -f $filename -- echo

elif [[ $1 == ri ]]; then
    mkdir -p $HOME/Pictures/Screenshots
    dirname=$HOME/Pictures/Screenshots/
		filename=$(date +%Y-%m-%d_%H-%M-%S).png
		filename=$(hyprshot -m region -o $dirname -f $filename -- echo)
		satty --filename $filename --fullscreen --output-filename $filename --early-exit --save-after-copy

elif [[ $1 == s ]]; then
    mkdir -p $HOME/Pictures/Screenshots
    dirname=$HOME/Pictures/Screenshots/
		filename=$(date +%Y-%m-%d_%H-%M-%S).png
		hyprshot -m output -m active -o $dirname -f $filename -- echo

elif [[ $1 == si ]]; then
    mkdir -p $HOME/Pictures/Screenshots
    dirname=$HOME/Pictures/Screenshots/
		filename=$(date +%Y-%m-%d_%H-%M-%S).png
		filename=$(hyprshot -m output -m active -o $dirname -f $filename -- echo)
		satty --filename $filename --output-filename $filename --initial-tool crop --early-exit --save-after-copy

elif [[ $1 == w ]]; then
    mkdir -p $HOME/Pictures/Screenshots
    dirname=$HOME/Pictures/Screenshots/
		filename=$(date +%Y-%m-%d_%H-%M-%S).png
		hyprshot -m window -m active -o $dirname -f $filename -- echo

elif [[ $1 == wi ]]; then
    mkdir -p $HOME/Pictures/Screenshots
    dirname=$HOME/Pictures/Screenshots/
		filename=$(date +%Y-%m-%d_%H-%M-%S).png
		filename=$(hyprshot -m window -m active -o $dirname -f $filename -- echo)
		satty --filename $filename --output-filename $filename --initial-tool crop --early-exit --save-after-copy

elif [[ $1 == p ]]; then
    color=$(hyprpicker -a)
    wl-copy $color
fi