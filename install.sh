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

# Link configs first (instant, unblocks plugin install early)
echo "🔗 Linking configs..."
mkdir -p ~/.config
ln -sf "$DOTFILES_DIR/nvim/.config/nvim" ~/.config/nvim
ln -sf "$DOTFILES_DIR/tmux/.config/tmux" ~/.config/tmux
ln -sf "$DOTFILES_DIR/zsh/.zshrc" ~/.zshrc

# Run all independent installs in parallel
echo "📦 Installing tools in parallel..."

install_fzf() {
    if [ ! -d ~/.fzf ]; then
        git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
        ~/.fzf/install --all --no-update-rc >/dev/null 2>&1
    fi
    echo "  ✓ fzf"
}

install_neovim() {
    if ! command -v nvim &>/dev/null || [[ "$(nvim --version | head -1)" < "NVIM v0.11" ]]; then
        curl -sfL https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz \
            | sudo tar xz -C /usr/local --strip-components=1
    fi
    echo "  ✓ neovim"
}

install_apt_packages() {
    sudo apt-get install -y --no-install-recommends tmux ripgrep bat >/dev/null 2>&1 || true
    echo "  ✓ apt packages"
}

install_npm_tools() {
    npm install -g --silent yaml-language-server bash-language-server >/dev/null 2>&1 || true
    echo "  ✓ npm LSP servers"
}

install_go_tools() {
    go install golang.org/x/tools/gopls@latest &
    go install golang.org/x/tools/cmd/goimports@latest &
    wait
    echo "  ✓ go tools"
}

install_nvim_plugins() {
    bash ~/.config/nvim/plugins.sh
}

pids=()
install_fzf & pids+=($!)
install_neovim & pids+=($!)
install_apt_packages & pids+=($!)
install_npm_tools & pids+=($!)
install_go_tools & pids+=($!)
install_nvim_plugins & pids+=($!)

failed=0
for pid in "${pids[@]}"; do
    wait "$pid" || failed=1
done

echo ""
if [ "$failed" -eq 1 ]; then
    echo "⚠️  Codespaces setup completed with some errors (see above)"
else
    echo "✅ Codespaces setup complete!"
fi
