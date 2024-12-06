#!/usr/bin/env bash

# lsusb | grep -i "logi"
# grep c548 /sys/bus/usb/devices/*/idProduct

systemctl suspend
exit 0

echo "For full suspend enter pass"
sudo echo suspend
bash ~/.nixos/.config/hypr/scripts/hypridle.sh &
sleep 1.0 &&
sudo echo disabled |
sudo tee /sys/bus/usb/devices/*/power/wakeup && systemctl suspend
