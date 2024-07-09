#!/usr/bin/env bash

bash $(cat $(find $HOME/.local/share/applications/ -type f -exec grep -l "$1" '{}' \;) | grep "Exec=" | sed -e "s/^Exec=//")