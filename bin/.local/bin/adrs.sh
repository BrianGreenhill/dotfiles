#!/bin/bash

set -e

function help() {
    echo '=========================================================='
    echo '         ______                                         '
    echo '  __________  /________      ________ _________ _______ '
    echo '  __  ___/_  /_  __ \_ | /| / /_  __ `__ \  __ `/_  __ \'
    echo '  _(__  )_  / / /_/ /_ |/ |/ /_  / / / / / /_/ /_  / / /'
    echo '  /____/ /_/  \____/____/|__/ /_/ /_/ /_/\__,_/ /_/ /_/'
    echo ""
    echo "  [adrs.sh] - search adrs"
    echo ""
    echo " Usage:"
    echo "  adrs.sh owner/repo <search term>"
    echo ""
    echo '========================================================='
    exit 1
}

# Define repository owner and name
rwo=${1}
defaultpath="${2-docs/adrs}"

if [[ -z "$1" ]]; then help; fi

markdown=$(gh api /repos/"$rwo"/contents/"$defaultpath" | jq -r '.[].path' | fzf | xargs -I "{}" gh api /repos/"$rwo"/contents/{} | jq -r '.content' | base64 -d)

echo "$markdown" | bat -l markdown
