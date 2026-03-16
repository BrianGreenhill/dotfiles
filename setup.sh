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

# Backup existing configs
backup_dir="$HOME/.config-backup-$(date +%Y%m%d-%H%M%S)"
needs_backup=false

echo "🔍 Checking for existing configurations..."

for config in alacritty nvim tmux; do
    if [[ -e "$HOME/.config/$config" && ! -L "$HOME/.config/$config" ]]; then
        needs_backup=true
        break
    fi
done

if [[ -e "$HOME/.zshrc" && ! -L "$HOME/.zshrc" ]]; then
    needs_backup=true
fi

if [[ "$needs_backup" == "true" ]]; then
    echo "💾 Backing up existing configs to $backup_dir"
    mkdir -p "$backup_dir"

    for config in alacritty nvim tmux aerospace; do
        if [[ -e "$HOME/.config/$config" && ! -L "$HOME/.config/$config" ]]; then
            echo "  → Backing up $config..."
            mv "$HOME/.config/$config" "$backup_dir/"
        fi
    done

    if [[ -e "$HOME/.zshrc" && ! -L "$HOME/.zshrc" ]]; then
        echo "  → Backing up .zshrc..."
        mv "$HOME/.zshrc" "$backup_dir/"
    fi
fi

# Stow all configs
echo "🔗 Symlinking configurations..."
cd "$DOTFILES_DIR"

configs=(aerospace alacritty nvim tmux zsh)

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
echo "  3. Run ~/.config/nvim/plugins.sh to install Neovim plugins"
echo ""

if [[ "$needs_backup" == "true" ]]; then
    echo "💡 Old configs backed up to: $backup_dir"
fi

# Apply macOS settings (optional)
read -p "Apply macOS system settings? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    ./macos-settings.sh
fi
