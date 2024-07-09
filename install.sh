#!/usr/bin/env bash

set -e

# get directories in the current directory
# exclude directories that start with a dot
directories=$(find . -maxdepth 1 -type d -not -name ".*" | sed 's|./||')

# check if CODESPACES env var is true
if [[ $CODESPACES == "true" ]]; then
    echo "installing nvim"
    /workspaces/.codespaces/.persistedshare/dotfiles/bin/.local/bin/build-nvim-debian.sh
    echo "installing package dependencies"
    sudo apt-get -y -q install ripgrep fzf
    echo "creating symlinks..."
    directories=("tmux" "nvim")
    for dir in "${directories[@]}"; do
        echo "symlinked $dir..."
        ln -sf /workspaces/.codespaces/.persistedshare/dotfiles/$dir/.config/$dir ~/.config/$dir
    done
    echo "done"
    exit 0
fi

if [[ $(which stow) == "" ]]; then
    echo "stow is not installed"
    exit 1
fi

# ensure this runs from the user home directory
for dir in $directories; do
    echo "stowing $dir..."
    stow -R $dir
done

if [[ $(which nix-env) ]]; then
    echo "installing nix packages..."
    NIX_SYSTEM_PACKAGES_CONFIG="$HOME/.dotfiles/nix/system-packages.nix"
    nix-env -if "$NIX_SYSTEM_PACKAGES_CONFIG"
fi
