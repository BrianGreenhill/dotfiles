#!/usr/bin/env bash
# Installs/updates neovim plugins using native packages (pack/plugins/start/)
set -e

PACK_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/pack/plugins/start"
mkdir -p "$PACK_DIR"

plugins=(
  "echasnovski/mini.nvim"
  "saghen/blink.lib"
  "saghen/blink.cmp"
  "ibhagwan/fzf-lua"
  "nvim-treesitter/nvim-treesitter"
  "rebelot/kanagawa.nvim"
  "stevearc/conform.nvim"
  "stevearc/oil.nvim"
  "tpope/vim-fugitive"
  "github/copilot.vim"
  "tpope/vim-sleuth"
)

action="${1:-install}"
pids=()
names=()

for plugin in "${plugins[@]}"; do
  name="${plugin##*/}"
  dir="$PACK_DIR/$name"

  if [ -d "$dir" ]; then
    if [ "$action" = "update" ]; then
      (git -C "$dir" fetch --depth 1 origin --quiet && git -C "$dir" reset --hard origin/HEAD --quiet && echo "✓ $name") &
      pids+=($!)
      names+=("$name")
    else
      echo "✓ $name"
    fi
  else
    (git clone --quiet --depth 1 --single-branch "https://github.com/$plugin.git" "$dir" && echo "✓ $name (installed)") &
    pids+=($!)
    names+=("$name")
  fi
done

# Wait for all clones/updates
failed=0
for i in "${!pids[@]}"; do
  if ! wait "${pids[$i]}"; then
    echo "⚠ ${names[$i]} failed"
    failed=1
  fi
done

# Build/download blink.cmp binary (rebuild on update too)
blink_needs_build=false
blink_target="$PACK_DIR/blink.cmp/target/release"
if [ ! -f "$blink_target/libblink_cmp_fuzzy.dylib" ] && [ ! -f "$blink_target/libblink_cmp_fuzzy.so" ]; then
  blink_needs_build=true
elif [ "$action" = "update" ]; then
  blink_needs_build=true
fi

if [ "$blink_needs_build" = true ]; then
  mkdir -p "$blink_target"
  if command -v cargo &>/dev/null; then
    echo "Building blink.cmp..."
    (cd "$PACK_DIR/blink.cmp" && cargo build --release --quiet 2>/dev/null) || echo "  ⚠ blink.cmp cargo build failed"
  else
    echo "Downloading blink.cmp binary..."
    # Get latest release tag from GitHub API (shallow clones lack tags)
    version=$(curl -sI "https://github.com/saghen/blink.cmp/releases/latest" 2>/dev/null | grep -i '^location:' | sed 's|.*/tag/||;s/[[:space:]]*$//')
    version="${version:-v1.10.1}"
    arch=$(uname -m)
    case "$arch" in arm64) arch="aarch64" ;; esac
    case "$(uname -s)" in
      Darwin) triple="${arch}-apple-darwin"; ext="dylib" ;;
      Linux)  triple="${arch}-unknown-linux-gnu"; ext="so" ;;
    esac
    url="https://github.com/saghen/blink.cmp/releases/download/${version}/${triple}.${ext}"
    if curl -sfL "$url" -o "$blink_target/libblink_cmp_fuzzy.${ext}"; then
      echo "  ✓ blink.cmp binary downloaded (${version})"
    else
      echo "  ⚠ blink.cmp download failed — completion will use lua fallback"
    fi
  fi
fi

# Update treesitter parsers after plugin update
if [ "$action" = "update" ]; then
  echo "Updating treesitter parsers..."
  nvim --headless -c 'TSUpdateSync' -c 'qall' 2>/dev/null || echo "  ⚠ TSUpdate failed (run :TSUpdate manually)"
fi

echo "Done."
