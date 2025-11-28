#!/bin/sh

# Get all monitor IDs and their workspace lists in order
all_monitors_json=$(aerospace list-monitors --json)
all_monitor_ids=$(echo "$all_monitors_json" | jq -r '.[]["monitor-id"]')
monitor_ws_labels=""

# Find globally focused workspace and determine which monitor it is on
global_focused_ws=$(aerospace list-workspaces --focused)

# Collect all workspaces for all monitors in ascending order
for mid in $all_monitor_ids; do
  # List workspaces for this monitor in ascending order
  ws_list=$(aerospace list-workspaces --monitor "$mid" --json | jq -r '.[].workspace' | sort -n)
  label=""
  for ws in $ws_list; do
    if [ "$ws" = "$global_focused_ws" ]; then
      label="${label}[${ws}] "
    else
      label="${label}${ws} "
    fi
  done
  # Strip trailing space and append
  monitor_ws_labels="${monitor_ws_labels}$(echo "$label" | sed 's/ $//');"
done

# Now print the output as: group1 | group2 (always in fixed monitor order)
# Split by ';'
IFS=';' read -r ws_left ws_right _ <<EOF
$monitor_ws_labels
EOF

label="${ws_left} | ${ws_right}"

sketchybar --set aerospace label="$label"
