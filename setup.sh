#!/usr/bin/env bash

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "🍎 Setting up dotfiles for macOS..."

# Check for Homebrew
if ! command -v brew &>/dev/null; then
    echo "❌ Homebrew not found"
    echo "   Install it first: https://brew.sh"
    exit 1
fi

# Install Homebrew packages
echo "📦 Installing Homebrew packages..."
cd "$DOTFILES_DIR"
brew bundle

# Check for GNU Stow
if ! command -v stow &>/dev/null; then
    echo "❌ GNU Stow not found (should have been installed by Homebrew)"
    exit 1
fi

# Back up real files/dirs that stow would otherwise conflict with
backup_dir="$HOME/.config-backup-$(date +%Y%m%d-%H%M%S)"

echo "🔍 Checking for existing configurations..."

for path in .config/alacritty .config/nvim .config/tmux .config/zsh .zshenv; do
    if [[ -e "$HOME/$path" && ! -L "$HOME/$path" ]]; then
        mkdir -p "$backup_dir"
        echo "  → Backing up ~/$path to $backup_dir"
        mv "$HOME/$path" "$backup_dir/"
    fi
done

# Stow all configs
echo "🔗 Symlinking configurations..."
cd "$DOTFILES_DIR"

# Pre-create dirs other tools also write to, so stow links files inside them
# instead of symlinking the whole dir into this repo.
mkdir -p "$HOME/.copilot/skills" "$HOME/.local/bin"

configs=(alacritty nvim tmux zsh bin gnupg copilot)

for config in "${configs[@]}"; do
    if [[ -d "$config" ]]; then
        echo "  → Stowing $config..."
        stow "$config"
    fi
done

echo ""
echo "✅ macOS setup complete!"
echo ""
echo "📝 Next steps:"
echo "  1. Restart your terminal (or run: exec zsh)"
echo "  2. Open tmux and press Ctrl-a + I to install plugins"
echo "  3. Open nvim (plugins install automatically on first launch)"
echo ""

if [[ -d "$backup_dir" ]]; then
    echo "💡 Old configs backed up to: $backup_dir"
fi

# Apply macOS settings (optional)
read -p "Apply macOS system settings? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    ./macos-settings.sh
fi
