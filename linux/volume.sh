#!/bin/bash
# changeVolume

msgId="991049"
pactl set-sink-volume @DEFAULT_SINK@ "$@" > /dev/null
volume="$(amixer -D pulse | grep -A 5 Master | tail -1 | awk '{print $5}' | sed 's/[^0-9]*//g')"
mute="$(amixer -c 1 -D pulse get Master | tail -1 | awk '{print $6}' | sed 's/[^a-z]*//g')"

if [[ $volume == 0 || "$mute" == "off" ]]; then
  pactl set-sink-mute @DEFAULT_SINK@ toggle > /dev/null
  dunstify -a "changeVolume" -u low -r "$msgId" "Volume muted"
else
  dunstify -a "changeVolume" -u low -r "$msgId" "Volume: ${volume}%"
fi

