#!/usr/bin/env bash
pipename="/run/user/1000/waypipe-$(uuidgen)"
username=basilyes
export WAYLAND_DISPLAY='wayland-1'
export XDG_RUNTIME_DIR='/run/user/1000/'
waypipe -s $pipename client &
sleep 0.1
chown ${username}:users $pipename
ip netns exec wg bash -c "sudo \
	HOME='/home/${username}' \
	PULSE_SERVER=/run/user/$(id -u $username)/pulse/native \
	PULSE_COOKIE=/home/${username}/.config/pulse/cookie \
	XDG_RUNTIME_DIR='/run/user/1000' \
	WAYLAND_DISPLAY='$WAYLAND_DISPLAY' \
  MOZ_ENABLE_WAYLAND=1 \
	-u ${username} waypipe -s $pipename server -- $@"
# ip netns exec wg sudo -u basilyes "$@"
kill -SIGINT %1
rm -f $pipename
