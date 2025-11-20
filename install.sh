#!/usr/bin/env bash

# This script is for GitHub Codespaces only

set -e

if [[ $CODESPACES != "true" ]]; then
    echo "❌ This script is only for GitHub Codespaces"
    echo "   For local macOS setup, run: ./setup.sh"
    exit 1
fi

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "☁️  Setting up dotfiles for GitHub Codespaces..."

# Install fzf
if [ ! -d ~/.fzf ]; then
    echo "📦 Installing fzf..."
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --all
fi

# Install neovim
if ! command -v nvim &>/dev/null; then
    echo "📦 Installing neovim..."
    sudo add-apt-repository ppa:neovim-ppa/unstable -y
    sudo apt-get update -y
    sudo apt-get install neovim -y
fi

# Install other tools
echo "📦 Installing additional tools..."
sudo apt-get install -y tmux ripgrep bat zoxide

# Link configs
echo "🔗 Linking configs..."
mkdir -p ~/.config
ln -sf "$DOTFILES_DIR/nvim/.config/nvim" ~/.config/nvim
ln -sf "$DOTFILES_DIR/tmux/.config/tmux" ~/.config/tmux
ln -sf "$DOTFILES_DIR/zsh/.zshrc" ~/.zshrc

echo ""
echo "✅ Codespaces setup complete!"
