#!/usr/bin/env bash



clients=/tmp/hypr/clients_temp
hyprctl clients > $clients


app_workspace=$(grep -B 6 -iP "initialTitle:.*$2" "$clients" | awk 'NR==1 {print $2}')

if [[ -z $app_workspace ]] || [[ $app_workspace -gt 100 ]]; then
	hyprctl dispatch "workspace $1" && hyprctl dispatch "exec [workspace $1] $3"
	# app_path=$(NIXPKGS_ALLOW_UNFREE=1 nix eval --impure nixpkgs#$3.outPath | tr -d "\"") &&
	# "[workspace 1 silent] $app_path/bin/$3" 
else
	bash ~/.config/hypr/scripts/workspace.sh $app_workspace
fi

exit 0