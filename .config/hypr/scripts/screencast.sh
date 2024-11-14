#!/usr/bin/env bash

file=$HOME/Videos/Screencasts/$(date +%Y-%m-%d_%H-%M-%S).mp4

if [[ $1 == r ]]; then
    wf-recorder -g "$(slurp)" --file=$file
elif [[ $1 == w ]]; then
    window=$(hyprctl activewindow -j)
    at=$(echo $window | jq -cr '.at')
    size=$(echo $window | jq -cr '.size')
    echo $at $size
    region="$(echo $at | jq -cr '.[0]'),$(echo $at | jq -cr '.[1]') $(echo $size | jq -cr '.[0]')x$(echo $size | jq -cr '.[1]')"
    wf-recorder -g "$region" --file=$file
fi

ffmpeg -i $file -pix_fmt yuv420p -movflags +faststart -c:v h264 -c:a aac /tmp/sceencast.mp4
mv /tmp/sceencast.mp4 $file
