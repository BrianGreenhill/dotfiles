#!/bin/bash
msgId="991048"
xbacklight "$@" > /dev/null
brightness="$(xbacklight | awk '{printf "%.0f\n", $1}')"
dunstify -a "changeBrightness" -u low -r "$msgId" "Brightness: ${brightness}"
