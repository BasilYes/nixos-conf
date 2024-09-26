#!/usr/bin/env bash

# lsusb | grep -i "logi"
# grep c548 /sys/bus/usb/devices/*/idProduct

echo "For full suspend enter pass"
sudo echo disabled | sudo tee /sys/bus/usb/devices/*/power/wakeup && systemctl suspend
