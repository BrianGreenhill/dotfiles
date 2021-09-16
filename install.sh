#!/usr/bin/env bash

echo "==> this script is only for codespaces"
exec > >(tee -i $HOME/dotfiles_install.log)
exec 2>&1
set -x

mkdir -p $HOME/.config

sudo apt update -y && sudo apt install -y neovim

ln -s $(pwd)/tmux/.tmux.conf $HOME/.tmux.conf
ln -s $(pwd)/nvim $HOME/.config/nvim
ln -s $(pwd)/zsh/.zshrc $HOME/.zshrc
ln -s $(pwd)/zsh/.zprofile $HOME/.zprofile

curl -fLo $HOME/.config/nvim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

nvim -Es -u $HOME/.config/nvim/init.vim -c "PlugInstall | qa"

sudo chsh -s "$(which zsh)" "$(whoami)"
