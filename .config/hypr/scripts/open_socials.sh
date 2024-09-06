#!/usr/bin/env bash

hyprctl --batch "
	dispatch exec [group set always] telegram-desktop;
	dispatch exec [group set always] thunderbird;
"
sleep 2.0
hyprctl dispatch "exec [group set always] ~/.config/hypr/scripts/open_PWA.sh Discord"
sleep 0.5
hyprctl	dispatch "exec [group set always] ~/.config/hypr/scripts/open_PWA.sh Element"
sleep 0.5
hyprctl	dispatch "exec [group set always] ~/.config/hypr/scripts/open_PWA.sh VK"
# sleep 0.5
# hyprctl dispatch changegroupactive f;
