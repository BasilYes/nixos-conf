
if [[ $1 == "idle" ]]; then
    if $2; then
        hyprctl dispatch "togglespecialworkspace idle"
    else
        hyprctl dispatch closewindow title:kitty-idle
    fi
fi
