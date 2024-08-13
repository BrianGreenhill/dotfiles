#!/usr/bin/env bash

set -e

# get directories in the current directory
# exclude directories that start with a dot
directories=$(find . -maxdepth 1 -type d -not -name ".*" | sed 's|./||')

function installfzf() {
    if [[ -z $CODESPACES  ]]; then echo "CODESPACES env var is not set"; exit 1; fi
    echo "==> installing latest fzf..."
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --all
    echo 'source ~/.fzf.bash' >>~/.bashrc
    echo "done"
}

# check if CODESPACES env var is true
if [[ $CODESPACES == "true" ]]; then
    echo "pulling nvim config"
    pushd /workspaces/.codespaces/.persistedshare/dotfiles
    git submodule update --init --recursive
    echo "creating symlinks..."
    directories=("tmux" "nvim")
    for dir in "${directories[@]}"; do
        echo "symlinked $dir..."
        ln -sf /workspaces/.codespaces/.persistedshare/dotfiles/"$dir"/.config/"$dir" ~/.config/"$dir"
    done
    echo "==> nvim plugins"
    nvim --headless +PlugInstall +qall
    installfzf
    echo "==> installing ruby"
    rbenv install 3.3.1 -s
    rbenv global 3.3.1
    sudo apt-get install python3.8-venv -y -q
    echo "done"
    popd
    exit 0
fi

if [[ $(which stow) == "" ]]; then
    echo "stow is not installed"
    exit 1
fi

# ensure this runs from the user home directory
for dir in "${directories[@]}"; do
    echo "stowing $dir..."
    stow "$dir"
done
