#!/usr/bin/env bash

set -e

# get directories in the current directory
# exclude directories that start with a dot
directories=$(find . -maxdepth 1 -type d -not -name ".*" | sed 's|./||')

if $CODESPACES; then
    echo "installing package dependencies"
    sudo apt-get -y -q install ripgrep fzf
    echo "creating symlinks..."
    ln -sf /workspaces/.codespaces/.persistedshare/dotfiles/nvim/.config/nvim ~/.config/nvim
    ln -sf /workspaces/.codespaces/.persistedshare/dotfiles/tmux/.tmux.conf ~/.tmux.conf
    echo "symlinks created"
    export EDITOR=nvim
    echo "EDITOR set to nvim"
    echo "alias vim=nvim" >> ~/.bashrc
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
