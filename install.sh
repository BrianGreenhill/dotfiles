#!/usr/bin/env bash

echo "==> this script is only for codespaces"
exec > >(tee -i $HOME/dotfiles_install.log)
exec 2>&1
set -x

PACKAGES_NEEDED="\
    silversearcher-ag \
    bat \
    fuse \
    libfuse2 \
    tmux"

if ! dpkg -s ${PACKAGES_NEEDED} > /dev/null 2>&1; then
    if [ ! -d "/var/lib/apt/lists" ] || [ "$(ls /var/lib/apt/lists/ | wc -l)" = "0" ]; then
        sudo apt-get update
    fi
    sudo apt-get -y -q install ${PACKAGES_NEEDED}
fi

mkdir -p $HOME/.config/personal

# install nvim
sudo modprobe fuse
sudo groupadd fuse
sudo usermod -a -G fuse "$(whoami)"

wget https://github.com/github/copilot.vim/releases/download/neovim-nightlies/appimage.zip
unzip appimage.zip
sudo chmod u+x nvim.appimage
sudo mv nvim.appimage /usr/local/bin/nvim
# curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
# chmod u+x nvim.appimage
# ./nvim.appimage --appimage-extract
# sudo mv squashfs-root / && sudo ln -s /squashfs-root/AppRun /usr/bin/nvim

# make sure we're using zsh
export PS1="(codespaces) ${PS1}"

ln -s $(pwd)/tmux/.tmux.conf $HOME/.tmux.conf
rm -f $HOME/.zshrc
ln -s $(pwd)/zsh/.zshrc $HOME/.zshrc
rm -f $HOME/.zprofile
ln -s $(pwd)/zsh/.zprofile $HOME/.zprofile

rm -rf $HOME/.config
mkdir $HOME/.config
ln -s $(pwd)/nvim/.config/nvim $HOME/.config/nvim
ln -s $(pwd)/personal/.config/personal/.personal-bashrc $HOME/.config/personal/.personal-bashrc
ln -s $(pwd)/macos/.config/personal/alias $HOME/.config/personal/alias
ln -s $(pwd)/macos/.config/personal/env $HOME/.config/personal/env

curl -fLo $HOME/.config/nvim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim +PlugInstall +qall
nvim +'PlugInstall --sync' +qa

sudo chsh -s "$(which zsh)" "$(whoami)"

