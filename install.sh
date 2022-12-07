#!/usr/bin/env bash

if [[ -z "${CODESPACES}" ]]; then
	echo "==> this script is only for codespaces exiting..."
	exit 1
fi

exec > >(tee -i $HOME/dotfiles_install.log)
exec 2>&1
set -x

rm -f $HOME/.tmux.conf
ln -s $(pwd)/tmux/.tmux.conf $HOME/.tmux.conf
rm -f $HOME/.zshrc
ln -s $(pwd)/zsh/.zshrc $HOME/.zshrc
rm -f $HOME/.zprofile
ln -s $(pwd)/zsh/.zprofile $HOME/.zprofile
rm -rf $HOME/.config
mkdir $HOME/.config
mkdir $(pwd)/nvim/.config/nvim/autoload
rm -rf $HOME/.config/nvim
ln -s $(pwd)/nvim/.config/nvim $HOME/.config/nvim
rm -rf $HOME/.config/personal
mkdir -p $HOME/.config/personal
ln -s $(pwd)/personal/.config/personal/.personal-bashrc $HOME/.config/personal/.personal-bashrc
ln -s $(pwd)/macos/.config/personal/alias $HOME/.config/personal/alias
ln -s $(pwd)/macos/.config/personal/env $HOME/.config/personal/env
mkdir -p $HOME/.local/bin
rm -f $HOME/.local/bin/tmux2
ln -s $(pwd)/bin/.local/bin/tmux2 $HOME/.local/bin/tmux2
