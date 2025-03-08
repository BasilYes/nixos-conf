#!/usr/bin/env bash

cd /etc/nixos/

status=$(git status -s)

if [[ -n $status ]]; then
	echo Uncommited changes
	exit
fi

sudo echo Flake update started

# nix-env --delete-generations 7d &&
sudo nix-collect-garbage -d &&
nix-collect-garbage -d &&

nix flake update &&

git add . &&
git commit -m "Update system on $(date +%Y-%m-%d)" &&

sudo nixos-rebuild switch &&

git push origin main
