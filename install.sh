#!/usr/bin/env bash

# This script is for GitHub Codespaces only

set -e -o pipefail

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
backup_dir=""
link_config() {
    local source="$1" path="$2" destination="$HOME/$2"
    if [[ -e "$destination" && ! -L "$destination" ]]; then
        if [[ -z "$backup_dir" ]]; then
            backup_dir="$(mktemp -d "$HOME/.config-backup-XXXXXXXX")"
        fi
        mkdir -p "$backup_dir/$(dirname "$path")"
        mv "$destination" "$backup_dir/$path"
        echo "  → Backed up ~/$path to $backup_dir/$path"
    fi
    ln -sfn "$source" "$destination"
}
link_config "$DOTFILES_DIR/nvim/.config/nvim" .config/nvim
link_config "$DOTFILES_DIR/tmux/.config/tmux" .config/tmux
link_config "$DOTFILES_DIR/zsh/.config/zsh" .config/zsh
link_config "$DOTFILES_DIR/zsh/.zshenv" .zshenv
mkdir -p ~/.copilot/skills
for skill in "$DOTFILES_DIR"/copilot/.copilot/skills/*; do
    link_config "$skill" ".copilot/skills/$(basename "$skill")"
done

# Run all independent installs in parallel
echo "📦 Installing tools in parallel..."

install_fzf() {
    if [ ! -d ~/.fzf ]; then
        git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
        ~/.fzf/install --all --no-update-rc >/dev/null
    fi
    echo "  ✓ fzf"
}

install_neovim() {
    if ! command -v nvim &>/dev/null || ! nvim --headless -u NONE -i NONE -n \
        -c 'if !has("nvim-0.11") | cquit | endif' -c 'qall'; then
        curl -sfL https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz \
            | sudo tar xz -C /usr/local --strip-components=1
    fi
    echo "  ✓ neovim"
}

install_apt_packages() {
    sudo apt-get install -y --no-install-recommends tmux ripgrep bat
    echo "  ✓ apt packages"
}

install_npm_tools() {
    npm install -g yaml-language-server bash-language-server
    echo "  ✓ npm LSP servers"
}

install_go_tools() {
    local gopls_pid goimports_pid failed=0
    go install golang.org/x/tools/gopls@latest & gopls_pid=$!
    go install golang.org/x/tools/cmd/goimports@latest & goimports_pid=$!
    wait "$gopls_pid" || failed=1
    wait "$goimports_pid" || failed=1
    if [[ "$failed" -ne 0 ]]; then
        echo "  ✗ go tools" >&2
        return 1
    fi
    echo "  ✓ go tools"
}

install_nvim_plugins() {
    install_neovim
    bash ~/.config/nvim/plugins.sh
}

pids=()
install_fzf & pids+=($!)
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
exit "$failed"
