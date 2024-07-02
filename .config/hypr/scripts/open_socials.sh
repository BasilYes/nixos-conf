#!/usr/bin/env bash

hyprctl --batch "
	dispatch exec [group set always] telegram-desktop;
	dispatch exec [group set always] thunderbird;
"
sleep 2.0
hyprctl --batch "
	dispatch exec [group set always] vivaldi --profile-directory=Default --app=https://app.element.io;
	dispatch exec [group set always] vivaldi --profile-directory=Default --app=https://discord.com/app;
	dispatch exec [group set always] vivaldi --profile-directory=Default --app=https://vk.com/im;
"
# sleep 0.5
# hyprctl dispatch changegroupactive f;