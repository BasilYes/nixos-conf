#!/usr/bin/env bash

cd /etc/nixos/

status=$(git status -s)

if [[ -n $status ]]; then
	echo Uncommited changes
	exit
fi

sudo echo Flake update started

nix flake update . &&
sudo nixos-rebuild switch &&

git add . &&
git commit -m "Update system on $(date +%Y-%m-%d_%H-%M-%S)" &&
git push origin main &&

nix-env --delete-generations 14d