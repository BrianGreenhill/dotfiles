#!/usr/bin/env bash

echo "==> this script is only for codespaces"
exec > >(tee -i $HOME/dotfiles_install.log)
exec 2>&1
set -x

mkdir -p $HOME/.config/personal

# install nvim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage --appimage-extract
sudo mv squashfs-root / && sudo ln -s /squashfs-root/AppRun /usr/bin/nvim

# install tmux
sudo apt install tmux

ln -s $(pwd)/tmux/.tmux.conf $HOME/.tmux.conf
ln -s $(pwd)/nvim/.config/nvim $HOME/.config/nvim
rm -f $HOME/.zshrc
ln -s $(pwd)/zsh/.zshrc $HOME/.zshrc
rm -f $HOME/.zprofile
ln -s $(pwd)/zsh/.zprofile $HOME/.zprofile
ln -s $(pwd)/personal/.config/personal/.personal-bashrc $HOME/.config/personal/.personal-bashrc

curl -fLo $HOME/.config/nvim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

nvim --headless +PlugInstall +q

sudo chsh -s "$(which zsh)" "$(whoami)"
