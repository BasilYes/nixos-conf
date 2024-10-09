#!/usr/bin/env bash

hyprctl dispatch "exec [group set always] vesktop"
hyprctl --batch "
    dispatch exec [group set always] telegram-desktop;
    dispatch exec [group set always] thunderbird;
"
sleep 4.0
hyprctl dispatch "exec [group set always] flatpak run network.loki.Session"
# hyprctl dispatch "exec [group set always] ~/.config/hypr/scripts/open_PWA.sh Discord"
# sleep 0.5
# hyprctl dispatch "exec [group set always] ~/.config/hypr/scripts/open_PWA.sh Element"
# sleep 0.5
# hyprctl    dispatch "exec [group set always] ~/.config/hypr/scripts/open_PWA.sh VK"
# sleep 0.5
# hyprctl dispatch changegroupactive f;
