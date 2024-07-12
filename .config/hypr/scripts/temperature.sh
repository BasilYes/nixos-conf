#!/usr/bin/env bash

sensors -j | grep -P "temp._input" | tr -d " ," | awk 'BEGIN { RS=":"; } NR!=1 {print $1}' | sort -n | tail -1 | awk 'BEGIN { RS="."; } NR==1 {print $1}'