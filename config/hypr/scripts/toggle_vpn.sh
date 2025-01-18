#!/usr/bin/env bash

for arg; do
	if [[ $arg != $1 ]]; then
    nmcli c down $arg
	fi
done

if [[ $1 != "none" ]]; then
	active=$(nmcli c show --active | grep $1)
	if [[ -z $active ]];then
			nmcli c up $1
	else
			nmcli c down $1
	fi
fi

