#!/usr/bin/env bash

hyprctl --batch "
	dispatch exec [group set active] telegram-desktop;
"
sleep 0.5
hyprctl --batch "
	dispatch exec vivaldi --profile-directory=Default --app=https://app.element.io;
	dispatch exec vivaldi --profile-directory=Default --app=https://discord.com/app;
	dispatch exec vivaldi --profile-directory=Default --app=https://vk.com/im;
	dispatch exec evolution;
"
# sleep 0.5
# hyprctl dispatch changegroupactive f;