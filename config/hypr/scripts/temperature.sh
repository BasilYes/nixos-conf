#!/usr/bin/env bash

max_temp=$(sensors -j | grep -P "temp._input" | tr -d " ," | awk 'BEGIN { RS=":"; } NR!=1 {print $1}' | sort -n | tail -1 | awk 'BEGIN { RS="."; } NR==1 {print $1}')
sensors=$(sensors | tr '\n' '\r')
echo { \"text\": \"$max_temp\", \"tooltip\": \"$sensors\" }
# | jq --unbuffered --compact-output