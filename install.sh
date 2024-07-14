#!/usr/bin/env bash

set -e

# get directories in the current directory
# exclude directories that start with a dot
directories=$(find . -maxdepth 1 -type d -not -name ".*" | sed 's|./||')

# check if CODESPACES env var is true
if [[ $CODESPACES == "true" ]]; then
    echo "installing fzf"
    sudo apt-get -y -q install fzf
    echo "pulling nvim config"
    pushd /workspaces/.codespaces/.persistedshare/dotfiles
    git submodule update --init --recursive
    echo "creating symlinks..."
    directories=("tmux" "nvim")
    for dir in "${directories[@]}"; do
        echo "symlinked $dir..."
        ln -sf /workspaces/.codespaces/.persistedshare/dotfiles/$dir/.config/$dir ~/.config/$dir
    done
    echo "==> install vim plugins"
    nvim --headless +PlugInstall +qall
    echo "==> installing ruby"
    rbenv install 3.3.1 -s
    rbenv global 3.3.1
    sudo apt install python3.8-venv -y -q
    echo "done"
    popd
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
