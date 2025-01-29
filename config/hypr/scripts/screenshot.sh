#!/usr/bin/env bash

# Flags:

# r: region
# s: screen
# w: window
# i: interactive

# p: pixel

mkdir -p$HOME/Pictures/Screenshots/

if [[ $1 == r ]]; then
    mkdir -p $HOME/Pictures/Screenshots
    dirname=$HOME/Pictures/Screenshots/
		filename=$(date +%Y-%m-%d_%H-%M-%S).png
		hyprshot -m region -o $dirname -f $filename --freeze

elif [[ $1 == ri ]]; then
    mkdir -p $HOME/Pictures/Screenshots
		filename=$HOME/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png
		hyprshot -m region --freeze --clipboard-only --raw |
		satty --filename - --output-filename $filename --initial-tool crop --copy-command wl-copy --fullscreen --early-exit --save-after-copy
		# filename=$(hyprshot -m region -o $dirname -f $filename -- echo)
		# satty --filename $filename --fullscreen --output-filename $filename --copy-command wl-copy --early-exit --save-after-copy

elif [[ $1 == s ]]; then
    mkdir -p $HOME/Pictures/Screenshots
    dirname=$HOME/Pictures/Screenshots/
		filename=$(date +%Y-%m-%d_%H-%M-%S).png
		hyprshot -m output -m active -o $dirname -f $filename --freeze

elif [[ $1 == si ]]; then
    mkdir -p $HOME/Pictures/Screenshots
		filename=$HOME/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png
		hyprshot -m output -m active --freeze --clipboard-only --raw |
		satty --filename - --output-filename $filename --initial-tool crop --copy-command wl-copy --fullscreen --early-exit --save-after-copy

elif [[ $1 == w ]]; then
    mkdir -p $HOME/Pictures/Screenshots
    dirname=$HOME/Pictures/Screenshots/
		filename=$(date +%Y-%m-%d_%H-%M-%S).png
		hyprshot -m window -m active -o $dirname -f $filename --freeze

elif [[ $1 == wi ]]; then
    mkdir -p $HOME/Pictures/Screenshots
		filename=$HOME/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png
		hyprshot -m window -m active --freeze --clipboard-only --raw |
		satty --filename - --output-filename $filename --initial-tool crop --copy-command wl-copy --fullscreen --early-exit --save-after-copy

elif [[ $1 == p ]]; then
    color=$(hyprpicker -a)
    wl-copy $color
fi
