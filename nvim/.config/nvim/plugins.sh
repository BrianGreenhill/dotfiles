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

# Remove plugins no longer listed above; anything in start/ loads on every launch.
for dir in "$PACK_DIR"/*/; do
  [ -d "$dir" ] || continue
  name="$(basename "$dir")"
  listed=0
  for plugin in "${plugins[@]}"; do
    [ "${plugin##*/}" = "$name" ] && listed=1 && break
  done
  if [ "$listed" = 0 ]; then
    rm -rf "${PACK_DIR:?}/$name"
    echo "✗ $name (removed)"
  fi
done

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

# Install missing treesitter parsers (no-op if present); update them on `update`.
# Building parsers needs the tree-sitter CLI (brew "tree-sitter-cli").
parsers="'go', 'lua', 'yaml', 'bash', 'markdown', 'markdown_inline', 'json', 'toml', 'dockerfile'"
if ! command -v tree-sitter >/dev/null; then
  echo "⚠ tree-sitter CLI not found; skipping parsers (brew install tree-sitter-cli)"
else
  echo "Installing treesitter parsers..."
  ts="local ts = require('nvim-treesitter'); ts.install({ $parsers }):wait(300000)"
  [ "$action" = "update" ] && ts="$ts; ts.update():wait(300000)"
  nvim --headless -c "lua $ts" -c 'qall' || echo "  ⚠ parser install failed (run :TSInstall manually)"
fi

echo "Done."
