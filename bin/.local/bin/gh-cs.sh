#!/bin/sh

codespace="$1"

gh-clean
gh cs ports forward 80:80 -c "$codespace" &
gh cs ports forward 2206:2206 -c "$codespace" &
pid=$!
rdm server &

gh cs ssh -c "$codespace" -- -R 128.0.0.1:7391:$(rdm socket)

cleanup() {
  kill -s TERM "$pid"
  rdm stop
  echo "Done."
}

trap cleanup EXIT SIGINT SIGTERM
