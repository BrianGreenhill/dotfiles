#!/usr/bin/env bash

# This script is intended to be run in a codespace

set -e

if [[ -z $CODESPACES ]]; then
    echo "this is only for codespaces"
    exit 1
fi

function installfzf {
    if [ ! -d ~/.fzf ]; then
        echo "installing latest fzf..."
        git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
        ~/.fzf/install --all
        echo 'source ~/.fzf.bash' >>~/.bashrc
        echo "done"
    fi
}

function installneovim {
    if ! command -v nvim &>/dev/null; then
        echo "installing neovim..."

        sudo add-apt-repository ppa:neovim-ppa/unstable -y &&
            sudo apt-get update -y &&
            sudo apt-get install neovim -y

        echo "done"
    fi
}

# check if CODESPACES env var is true
if [[ $CODESPACES == "true" ]]; then
    installfzf
    installneovim
    echo "configuring neovim"
    ln -sf /workspaces/.codespaces/.persistedshare/dotfiles/nvim/.config/nvim ~/.config/nvim
    echo "configuring tmux"
    ln -sf /workspaces/.codespaces/.persistedshare/dotfiles/tmux/.config/tmux ~/.config/tmux
    exit 0
fi
