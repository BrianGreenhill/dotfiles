#!/bin/bash

set -e

doTheBrew() {
  echo "Brewing..."
  brew analytics off
  brew update
  brew upgrade
  brew tap "Homebrew/bundle"
  brew bundle --file=$(pwd)/macos/Brewfile
  brew cleanup
}

copyTheDots() {
  echo "syncing dotfiles..."
  ln -sf $(pwd)/macos/.aliases $HOME/.aliases
  ln -sf $(pwd)/macos/.vimrc $HOME/.config/nvim/init.vim
  ln -sf $(pwd)/macos/.tmux.conf $HOME/.tmux.conf
  ln -sf $(pwd)/macos/.gitignore $HOME/.gitignore
}

doTheBrew
copyTheDots
