
if $1; then
    if [[ -z $(hyprctl clients | grep "kitty-idle") ]]; then
        hyprctl dispatch "togglespecialworkspace idle"
        # hyprctl dispatch closewindow title:kitty-idle
        # hyprctl dispatch submap idle
    fi
    bash ~/.config/hypr/scripts/keyboard_layout.sh 0
    pidof hyprlock ||
    hyprlock
else
    hyprctl dispatch closewindow title:kitty-idle
    # hyprctl dispatch submap reset
fi
