#!/usr/bin/env bash

# This script is intended to be run in a codespace

set -e

function installfzf {
    if [[ -z $CODESPACES  ]]; then echo "CODESPACES env var is not set"; exit 1; fi
    echo "installing latest fzf..."
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --all
    echo 'source ~/.fzf.bash' >>~/.bashrc
    echo "done"
}

function confignvim {
    echo "configuring nvim..."
    gh repo clone briangreenhill/config.nvim ~/.config/nvim
    pushd ~/.config/nvim
    nvim --headless +PlugInstall +qall
    popd
}

# check if CODESPACES env var is true
if [[ $CODESPACES == "true" ]]; then
    installfzf
    confignvim
    echo "configuring tmux"
    ln -sf /workspaces/.codespaces/.persistedshare/dotfiles/tmux/.config/tmux ~/.config/tmux
    exit 0
fi
