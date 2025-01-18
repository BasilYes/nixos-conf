#!/usr/bin/env bash


window=$(hyprctl activewindow -j)
address=$(echo $window | jq -cr '.address')
group=$(echo $window | jq -cr '.grouped')

if [[ $group == "[]" ]]; then
	hyprctl dispatch "killactive"
else
	hyprctl --batch "
		dispatch changegroupactive b;
		dispatch closewindow address:${address};
	"
fi