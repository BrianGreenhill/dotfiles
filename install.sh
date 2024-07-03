#!/usr/bin/env bash

set -e

# get directories in the current directory
# exclude directories that start with a dot
directories=$(find . -maxdepth 1 -type d -not -name ".*" | sed 's|./||')

# check if CODESPACES env var is true
if [[ $CODESPACES == "true" ]]; then
    echo "installing package dependencies"
    sudo apt-get -y -q install ripgrep fzf
    echo "creating symlinks..."
    directories = $(tmux nvim)
    for dir in $directories; do
        ln -sf /workspaces/.codespaces/.persistedshare/dotfiles/$dir/.config/$dir ~/.config/$dir
    done
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

if [[ $(which asdf) == "" ]]; then
    echo "asdf is not installed. installing..."
    brew install asdf
    . $(brew --prefix asdf)/libexec/asdf.sh
fi

echo "installing asdf plugins..."
plugins=$(cat $HOME/.tool-versions | cut -d ' ' -f 1 | sort | uniq)
for p in $plugins; do
    asdf plugin add $p
done

echo "installing asdf versions..."
# https://github.com/aphecetche/asdf-tmux/pull/9
export TMUX_CONFIGURE_OPTIONS="--enable-utf8proc"
asdf install
unset TMUX_CONFIGURE_OPTIONS
