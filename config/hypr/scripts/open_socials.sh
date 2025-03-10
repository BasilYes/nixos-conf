#!/usr/bin/env bash

hyprctl dispatch "exec [group set always;workspace name:socials silent] thunderbird"
sleep 1.0
hyprctl dispatch "exec [group set always;workspace name:socials silent] telegram-desktop"
# sleep 2.5
# hyprctl dispatch "exec [group set always] ~/.config/hypr/scripts/open_PWA.sh Discord"
hyprctl dispatch "exec [group set always] sudo /etc/wgnetns discordcanary"
# sleep 0.5
# hyprctl dispatch "exec [group set always;workspace name:socials silent] ~/.config/hypr/scripts/open_PWA.sh Element"
sleep 5.0
hyprctl --batch "dispatch workspace name:socials;dispatch lockactivegroup lock;"
# sleep 0.5
# hyprctl dispatch "exec [group set always;workspace name:socials silent] vesktop"
# sleep 0.5
# hyprctl dispatch "exec [group set always] ~/.config/hypr/scripts/open_PWA.sh VK"
# sleep 0.5
# hyprctl dispatch changegroupactive f;
