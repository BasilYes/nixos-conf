#!/usr/bin/env bash

if [[ -n $(ip addr | grep veth1) ]] || [[ -n $(ip addr | grep veth0) ]]; then
	echo exit
	exit 0
fi

ip link add veth0 type veth peer name veth1
ip addr add 192.168.100.1/24 dev veth0
ip link set veth0 up
ip link set veth1 netns wg  # Важно! Переносим veth1 в netns wg

# Настраиваем veth1 внутри `netns wg`
ip netns exec wg ip addr add 192.168.100.2/24 dev veth1
ip netns exec wg ip link set veth1 up
ip netns exec wg ip link set lo up

# Проверяем, что интерфейс появился в `netns wg`
ip netns exec wg ip addr
