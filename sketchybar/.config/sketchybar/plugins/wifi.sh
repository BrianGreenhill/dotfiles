#!/bin/sh

ICON="󰖩"

# Measure ping to google.de (get first ping result)
ping_ms=$(ping -c 1 -t 2 google.de 2>/dev/null | awk -F'time=' '/time=/{split($2,a," "); print int(a[1]) "ms"}')

if [ -z "$ping_ms" ]; then
  ping_ms="timeout"
  ICON="󰖪"
fi
LABEL="$LABEL-> $ping_ms"

sketchybar --set "$NAME" icon="$ICON" label="$LABEL" label.width=70
