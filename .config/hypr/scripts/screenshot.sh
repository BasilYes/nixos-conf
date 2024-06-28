#!/usr/bin/env bash

# Flags:

# r: region
# s: screen
#
# c: clipboard
# f: file
# i: interactive

# p: pixel

if [[ $1 == r ]]; then
    mkdir -p ~/Pictures/Screenshots
    filename=~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png
    grim -g "$(slurp -b '#000000b0' -c '#00000000')" - | wl-copy && wl-paste > $filename
    notify-send 'Screenshot Taken' $filename

elif [[ $1 == ri ]]; then
    mkdir -p ~/Pictures/Screenshots
    filename=~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png
    grim -g "$(slurp -b '#000000b0' -c '#00000000')" - | wl-copy && wl-paste > $filename
		swappy -f $filename -o $filename

elif [[ $1 == s ]]; then
    mkdir -p ~/Pictures/Screenshots
    filename=~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png
    grim - | wl-copy && wl-paste > $filename
    notify-send 'Screenshot Taken' $filename

elif [[ $1 == si ]]; then
    mkdir -p ~/Pictures/Screenshots
    filename=~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png
    grim - | wl-copy && wl-paste > $filename
		swappy -f $filename -o $filename

elif [[ $1 == p ]]; then
    color=$(hyprpicker -a)
    wl-copy $color
    notify-send 'Copied to Clipboard' $color
fi