#!/bin/sh

# wifi_change event provides the $INFO variable containing the current SSID

ICON="󰖩"
IP=$(ifconfig en0 | grep "inet " | grep -v 127.0.0.1 | awk '{print $2}')
LABEL="$IP"

if [ "$IP" = "" ]; then
  ICON="󰖪"
  LABEL="No Wi-Fi"
fi


sketchybar --set "$NAME" icon="$ICON" label="$LABEL"
