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
if ! command -v nvim &>/dev/null || [[ "$(nvim --version | head -1)" < "NVIM v0.11" ]]; then
    echo "📦 Installing neovim..."
    curl -sfL https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz \
        | sudo tar xz -C /usr/local --strip-components=1
fi

# Install other tools
echo "📦 Installing additional tools..."
sudo apt-get install -y tmux ripgrep bat || true

# Install LSP servers and dev tools
echo "📦 Installing LSP servers..."
npm install -g yaml-language-server bash-language-server || true
go install golang.org/x/tools/gopls@latest || true
go install golang.org/x/tools/cmd/goimports@latest || true

# Link configs
echo "🔗 Linking configs..."
mkdir -p ~/.config
ln -sf "$DOTFILES_DIR/nvim/.config/nvim" ~/.config/nvim
ln -sf "$DOTFILES_DIR/tmux/.config/tmux" ~/.config/tmux
ln -sf "$DOTFILES_DIR/zsh/.zshrc" ~/.zshrc

# Install neovim plugins
echo "📦 Installing Neovim plugins..."
bash ~/.config/nvim/plugins.sh

echo ""
echo "✅ Codespaces setup complete!"
