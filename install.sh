#!/usr/bin/env bash

# This script is intended to be run in a codespace

set -e

if [[ -z $CODESPACES  ]]; then echo "this is only for codespaces"; exit 1; fi

function installfzf {
    echo "installing latest fzf..."
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --all
    echo 'source ~/.fzf.bash' >>~/.bashrc
    echo "done"
}

# check if CODESPACES env var is true
if [[ $CODESPACES == "true" ]]; then
    installfzf
    echo "configuring neovim"
    ln -sf /workspaces/.codespaces/.persistedshare/dotfiles/nvim/.config/nvim ~/.config/nvim
    nvim --headless +PlugInstall +qall
    echo "configuring tmux"
    ln -sf /workspaces/.codespaces/.persistedshare/dotfiles/tmux/.config/tmux ~/.config/tmux
    exit 0
fi
