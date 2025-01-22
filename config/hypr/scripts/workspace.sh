#!/usr/bin/env bash


monitors=/tmp/hypr/monitors_temp
hyprctl monitors > $monitors

if [[ -z $1 ]]; then
  workspace=$(grep -B 5 "focused: no" "$monitors" | awk 'NR==1 {print $3}')
else
  workspace=$1
fi

last_workspace_file=/tmp/hypr/last_workspace
last_workspace=$(hyprctl activeworkspace -j | jq -rc ".name")
if ([[ "$workspace" == "$last_workspace" ]] || [[ "$workspace" == "name:${last_workspace}" ]]) && [[ -z $2 ]]; then
	workspace=$(cat $last_workspace_file)
else
	echo $last_workspace > $last_workspace_file
fi

echo $(cat $last_workspace_file)

activemonitor=$(grep -B 11 "focused: yes" "$monitors" | awk 'NR==1 {print $2}')
passivemonitor=$(grep  -B 6 "active workspace: $workspace" "$monitors" | awk 'NR==1 {print $2}')
#activews=$(grep -A 2 "$activemonitor" "$monitors" | awk 'NR==3 {print $1}' RS='(' FS=')')
passivews=$(grep -A 6 "$passivemonitor" "$monitors" | awk 'NR==7 {print $3}')

if [[ $workspace -eq $passivews ]] && [[ "$activemonitor" != "$passivemonitor" ]]; then
  hyprctl dispatch swapactiveworkspaces "$activemonitor" "$passivemonitor"
  echo $activemonitor $passivemonitor
else
  hyprctl dispatch moveworkspacetomonitor "$workspace $activemonitor" && hyprctl dispatch workspace "$workspace"
fi

# hyprctl dispatch focusworkspaceoncurrentmonitor "$1"

exit 0
