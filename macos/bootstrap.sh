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
  ln -sf $(pwd)/macos/.zshrc $HOME/.zshrc
  ln -sf $(pwd)/macos/.zprofile $HOME/.zprofile
  ln -sf $(pwd)/macos/.gitignore $HOME/.gitignore
  echo "syncing terminal and editor configs..."
  ln -sf $(pwd)/macos/alacritty.yml $HOME/.config/alacritty/alacritty.yml
  ln -sf $(pwd)/macos/kitty.conf $HOME/.config/kitty/kitty.conf
  ln -sf $(pwd)/macos/vimrc $HOME/.config/nvim/init.vim
  ln -sf $(pwd)/macos/nvim/plugin $HOME/.config/nvim/
  ln -sf $(pwd)/macos/nvim/UltiSnips $HOME/.config/nvim/
  ln -sf $(pwd)/macos/.tmux.conf $HOME/.tmux.conf
}

doTheBrew
copyTheDots
