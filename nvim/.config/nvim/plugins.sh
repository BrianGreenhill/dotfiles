#!/usr/bin/env bash
# Installs/updates neovim plugins using native packages (pack/plugins/start/)
set -e

PACK_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/pack/plugins/start"
mkdir -p "$PACK_DIR"

plugins=(
  "echasnovski/mini.nvim"
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

# Update treesitter parsers after plugin update
if [ "$action" = "update" ]; then
  echo "Updating treesitter parsers..."
  nvim --headless -c 'TSUpdateSync' -c 'qall' 2>/dev/null || echo "  ⚠ TSUpdate failed (run :TSUpdate manually)"
fi

echo "Done."
