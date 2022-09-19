#!/usr/bin/env bash

if [[ -z "${CODESPACES}" ]]; then
	echo "==> this script is only for codespaces exiting..."
	exit 1
fi

exec > >(tee -i $HOME/dotfiles_install.log)
exec 2>&1
set -x

PACKAGES_NEEDED="\
    hub \
    fzf \
    tmux \
    direnv \
    fuse"

# install neovim nightly
curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
chmod u+x nvim.appimage
sudo mv nvim.appimage /usr/bin/nvim

if ! dpkg -s ${PACKAGES_NEEDED} >/dev/null 2>&1; then
	if [ ! -d "/var/lib/apt/lists" ] || [ "$(ls /var/lib/apt/lists/ | wc -l)" = "0" ]; then
		sudo apt-get update
	fi
	sudo apt-get -y -q install ${PACKAGES_NEEDED}
fi

sudo apt-get install -y -o Dpkg::Options::="--force-overwrite" bat ripgrep

rm -f $HOME/.tmux.conf
ln -s $(pwd)/tmux/.tmux.conf $HOME/.tmux.conf
rm -f $HOME/.zshrc
ln -s $(pwd)/zsh/.zshrc $HOME/.zshrc
rm -f $HOME/.zprofile
ln -s $(pwd)/zsh/.zprofile $HOME/.zprofile

rm -rf $HOME/.config
mkdir $HOME/.config

mkdir $(pwd)/nvim/.config/nvim/autoload

# install packer
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

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

sudo chsh -s "$(which zsh)" "$(whoami)"
rm -rf $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
export PS1="(codespaces) ${PS1}"
