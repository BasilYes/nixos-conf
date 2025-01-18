#!/usr/bin/env bash
XDG_CURRENT_DESKTOP=Sway \
flameshot gui --raw > /tmp/screenshot.png && \
wl-copy < /tmp/screenshot.png && \
mv /tmp/screenshot.png ~/Pictures/Screenshots/$(date "+%Y-%m-%d_%H-%M-%S").png