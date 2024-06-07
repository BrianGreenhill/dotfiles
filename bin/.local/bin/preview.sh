#!/bin/bash

file=$1
line=$2

if [[ -z "$file" || -z "$line" ]]; then
    exit 1
fi

start_line=$((line - 10))
end_line=$((line + 10))

if [[ $start_line -lt 1 ]]; then
    start_line=1
fi

bat --style=numbers --color=always --highlight-line=$line --line-range=$start_line:$end_line "$file"

