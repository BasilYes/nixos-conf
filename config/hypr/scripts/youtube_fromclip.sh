#!/usr/bin/env bash
sudo /etc/setup_proxy && sleep 1.0
cd /run/media/basilyes/VIDEO\&FILM/
yt-dlp --yes-playlist "$(wl-paste)" -f "bv*[height<=1080]+ba/b[height<=1080]" --proxy "http://192.168.100.2:8888"
