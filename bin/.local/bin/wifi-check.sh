#!/usr/bin/env bash
set -euo pipefail

ROUTER_IP="${1:-192.168.178.1}"         # pass a different router IP as arg1 if needed
REPEATER_IP="${2:-}"                    # optional: pass repeater IP as arg2 if you want it tested
COUNT="${COUNT:-50}"                    # packets per ping
EXT1="1.1.1.1"
EXT2="8.8.8.8"

is_private() {
  local ip="$1"
  [[ "$ip" =~ ^10\. ]] && return 0
  [[ "$ip" =~ ^192\.168\. ]] && return 0
  # 172.16.0.0 – 172.31.255.255
  if [[ "$ip" =~ ^172\.([1-2][0-9]|3[0-1])\. ]]; then return 0; fi
  return 1
}

summarize_ping() {
  local target="$1"
  # macOS ping prints: min/avg/max/stddev = a/b/c/d ms
  local line
  line=$(ping -c "$COUNT" "$target" 2>/dev/null | tail -n 1)
  if [[ -z "$line" ]]; then
    echo "  $target  ->  failed"
    return
  fi
  local stats
  stats=$(sed -E 's/.*=\s*([0-9.]+)\/([0-9.]+)\/([0-9.]+)\/([0-9.]+).*/min=\1 ms  avg=\2 ms  max=\3 ms  stddev=\4 ms/' <<<"$line")
  echo "  $target  ->  $stats"
}

first_public_hop() {
  # Skip the first (router) and grab the first non-private IP
  traceroute -n "$EXT1" 2>/dev/null | awk 'NR>1 {print $2}' | while read -r ip; do
    [[ "$ip" == "*" || -z "$ip" ]] && continue
    if ! is_private "$ip"; then
      echo "$ip"; break
    fi
  done
}

echo "== Wi-Fi / Network Latency Quick Check =="
echo "Packets per ping: $COUNT"
echo

echo "[Local]"
summarize_ping "$ROUTER_IP"
if [[ -n "$REPEATER_IP" ]]; then summarize_ping "$REPEATER_IP"; fi
echo

echo "[ISP Uplink]"
GATEWAY_IP=$(first_public_hop || true)
if [[ -n "${GATEWAY_IP:-}" ]]; then
  summarize_ping "$GATEWAY_IP"
else
  echo "  (could not detect first public hop via traceroute)"
fi
echo

echo "[External]"
summarize_ping "$EXT1"
summarize_ping "$EXT2"
echo

if command -v iperf3 >/dev/null 2>&1; then
  echo "[iPerf3 UDP jitter/loss 30s @ 1 Mbit/s]"
  iperf3 -c ping.online.net -u -b 1M -t 30 | \
    awk '/receiver/ {printf "  jitter=%s  loss=%s of %s (%.2f%%)\n", $6, $8, $10, ($8==0?0:($8/$10*100))}'
else
  echo "[iPerf3]"
  echo "  iperf3 not found. Install with:  brew install iperf3"
fi

