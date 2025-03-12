#!/usr/bin/env bash

# lsusb | grep -i "logi"
# grep c548 /sys/bus/usb/devices/*/idProduct

sudo echo disabled | sudo tee /sys/bus/usb/devices/*/power/wakeup &&
systemctl suspend
