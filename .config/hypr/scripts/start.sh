#!/usr/bin/env bash


wl-clipboard-history -t &
wl-paste --watch cliphist store &
rm "$HOME/.cache/cliphist/db" &

nm-applet --indicator &

udiskie &
otd-daemon &
# bash ~/.config/waybar/launch.sh &
rm -f /tmp/hypr/switch_*_temp &

swaync &
hypridle &

# kitty &

if [[ -f $HOME/Programs/PowerTunnel.jar ]]; then
    hyprctl dispatch "exec [workspace special:pocket0 silent] java -jar ~/Programs/PowerTunnel.jar --start" &
fi

hyprctl dispatch "togglespecialworkspace idle" &
hyprctl dispatch submap idle &

# sleep 2 && bash ~/.config/hypr/scripts/monitors_setup.sh 1
exit 0
