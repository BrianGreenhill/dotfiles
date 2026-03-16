#!/usr/bin/env bash
# Installs/updates neovim plugins using native packages (pack/plugins/start/)
set -e

PACK_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/pack/plugins/start"
mkdir -p "$PACK_DIR"

plugins=(
  "echasnovski/mini.nvim"
  "saghen/blink.cmp"
  "ibhagwan/fzf-lua"
  "williamboman/mason.nvim"
  "WhoIsSethDaniel/mason-tool-installer.nvim"
  "neovim/nvim-lspconfig"
  "nvim-treesitter/nvim-treesitter"
  "rebelot/kanagawa.nvim"
  "stevearc/conform.nvim"
  "stevearc/oil.nvim"
  "tpope/vim-fugitive"
  "github/copilot.vim"
  "tpope/vim-sleuth"
)

action="${1:-install}"

for plugin in "${plugins[@]}"; do
  name="${plugin##*/}"
  dir="$PACK_DIR/$name"

  if [ -d "$dir" ]; then
    if [ "$action" = "update" ]; then
      echo "Updating $name..."
      git -C "$dir" pull --quiet
    else
      echo "✓ $name"
    fi
  else
    echo "Installing $name..."
    git clone --quiet --depth 1 "https://github.com/$plugin.git" "$dir"
  fi
done

# Build blink.cmp (Rust-powered completion)
blink_target="$PACK_DIR/blink.cmp/target/release"
if [ ! -f "$blink_target/libblink_cmp_fuzzy.dylib" ] && [ ! -f "$blink_target/libblink_cmp_fuzzy.so" ]; then
  mkdir -p "$blink_target"
  if command -v cargo &>/dev/null; then
    echo "Building blink.cmp..."
    (cd "$PACK_DIR/blink.cmp" && cargo build --release --quiet 2>/dev/null) || echo "  ⚠ blink.cmp cargo build failed"
  else
    echo "Downloading blink.cmp binary..."
    version=$(cd "$PACK_DIR/blink.cmp" && git describe --tags --abbrev=0 2>/dev/null || echo "v1.3.1")
    os=$(uname -s | tr '[:upper:]' '[:lower:]')
    arch=$(uname -m)
    case "$arch" in
      x86_64) arch="x86_64" ;;
      arm64|aarch64) arch="aarch64" ;;
    esac
    case "$os" in
      darwin) triple="${arch}-apple-darwin" ;;
      linux) triple="${arch}-unknown-linux-gnu" ;;
    esac
    url="https://github.com/saghen/blink.cmp/releases/download/${version}/blink-fuzzy-lib-${triple}.tar.gz"
    if curl -sL "$url" | tar xz -C "$PACK_DIR/blink.cmp" 2>/dev/null; then
      echo "  ✓ blink.cmp binary downloaded"
    else
      echo "  ⚠ blink.cmp download failed — completion will use lua fallback"
    fi
  fi
fi

echo "Done."
