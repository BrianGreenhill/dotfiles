#!/usr/bin/env bash

if [[ -z "${CODESPACES}" ]]; then
  echo "==> this script is only for codespaces"
  exit 1
else
  echo "==> installing dotfiles in codespace"
fi

exec > >(tee -i $HOME/dotfiles_install.log)
exec 2>&1
set -x


PACKAGES_NEEDED="\
    hub \
    neovim \
    tmux"

sudo add-apt-repository -y ppa:cpick/hub

if ! dpkg -s ${PACKAGES_NEEDED} > /dev/null 2>&1; then
    if [ ! -d "/var/lib/apt/lists" ] || [ "$(ls /var/lib/apt/lists/ | wc -l)" = "0" ]; then
        sudo apt-get update
    fi
    sudo apt-get -y -q install ${PACKAGES_NEEDED}
fi

sudo apt install -y -o Dpkg::Options::="--force-overwrite" bat ripgrep
npm install -g typescript

# make sure we're using zsh
export PS1="(codespaces) ${PS1}"

rm -f $HOME/.tmux.conf
ln -s $(pwd)/tmux/.tmux.conf $HOME/.tmux.conf
rm -f $HOME/.zshrc
ln -s $(pwd)/zsh/.zshrc $HOME/.zshrc
rm -f $HOME/.zprofile
ln -s $(pwd)/zsh/.zprofile $HOME/.zprofile

rm -rf $HOME/.config
mkdir $HOME/.config

mkdir $(pwd)/nvim/.config/nvim/autoload
curl -fLo $(pwd)/nvim/.config/nvim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

rm -rf $HOME/.config/nvim
ln -s $(pwd)/nvim/.config/nvim $HOME/.config/nvim
rm -rf $HOME/.config/personal
mkdir -p $HOME/.config/personal
ln -s $(pwd)/personal/.config/personal/.personal-bashrc $HOME/.config/personal/.personal-bashrc
ln -s $(pwd)/macos/.config/personal/alias $HOME/.config/personal/alias
ln -s $(pwd)/macos/.config/personal/env $HOME/.config/personal/env

nvim --headless +PlugInstall +qa

sudo chsh -s "$(which zsh)" "$(whoami)"
