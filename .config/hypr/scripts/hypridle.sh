
if [[ $1 == "idle" ]]; then
    if $2; then
        if [[ -z $(hyprctl clients | grep "kitty-idle") ]]; then
            hyprctl dispatch "togglespecialworkspace idle"
            hyprctl dispatch submap idle
        fi
    else
        hyprctl dispatch closewindow title:kitty-idle
        hyprctl dispatch submap reset
    fi
fi
