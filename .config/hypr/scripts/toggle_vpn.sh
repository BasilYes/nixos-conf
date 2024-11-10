#!/usr/bin/env bash

active=$(nmcli c show --active | grep $1)
if [[ -z $active ]];then
    nmcli c up $1
else
    nmcli c down $1
fi
