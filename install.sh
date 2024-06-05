#!/usr/bin/env bash

set -e

# get directories in the current directory
# exclude directories that start with a dot
directories=$(find . -maxdepth 1 -type d -not -name ".*" | sed 's|./||')

# check stow is installed
if ! command -v stow &> /dev/null; then
  echo "stow is not installed"
  exit 1
fi

for dir in $directories; do
    echo "stowing $dir..."
    stow -R $dir
done
