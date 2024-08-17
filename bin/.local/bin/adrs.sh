#!/bin/bash

set -e

function help() {
    echo ' slowman - a slow but powerful pokemon'
    echo ""
    echo "  [adrs.sh] - search adrs"
    echo ""
    echo " Usage:"
    echo "  adrs.sh owner/repo <search term>"
    echo ""
    exit 1
}
if [[ -z "$1" ]]; then help; fi

# Define repository owner and name
rwo=${1}
defaultpath="${2-docs/adrs}"
markdown=$(gh api /repos/"$rwo"/contents/"$defaultpath" | jq -r '.[].path' | fzf | xargs -I "{}" gh api /repos/"$rwo"/contents/{} | jq -r '.content' | base64 -d)
echo "$markdown" | glow
