#!/usr/bin/env bash

keyboard=$(hyprctl devices | grep -B 4 "main: yes" | awk 'NR==2 {print $1}')
echo $keyboard

hyprctl switchxkblayout ${keyboard} $1
