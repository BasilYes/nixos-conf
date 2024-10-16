#!/usr/bin/env bash

hyprctl dispatch "exec [group set always;workspace name:socials silent] telegram-desktop"
hyprctl dispatch "exec [group set always;workspace name:socials silent] thunderbird"
sleep 2.0
hyprctl dispatch "exec [group set always] ~/.config/hypr/scripts/open_PWA.sh Discord"
sleep 0.5
hyprctl dispatch "exec [group set always;workspace name:socials silent] ~/.config/hypr/scripts/open_PWA.sh Element"
sleep 2.0
hyprctl --batch "dispatch workspace name:socials;dispatch lockactivegroup lock;"
# sleep 0.5
# hyprctl dispatch "exec [group set always;workspace name:socials silent] vesktop"
# sleep 0.5
# hyprctl dispatch "exec [group set always] ~/.config/hypr/scripts/open_PWA.sh VK"
# sleep 0.5
# hyprctl dispatch changegroupactive f;
