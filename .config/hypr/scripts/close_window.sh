#!/usr/bin/env bash


window=$(hyprctl activewindow -j)
pid=$(echo $window | jq -cr '.pid')
group=$(echo $window | jq -cr '.grouped')
if [[ $group == "[]" ]]; then
	hyprctl dispatch "killactive"
	sleep 5
	kill $pid
else
	hyprctl dispatch "changegroupactive b"
	hyprctl dispatch "closewindow pid:${pid}"
	sleep 5
	kill $pid
fi