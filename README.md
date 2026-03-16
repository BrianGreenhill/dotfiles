# dotfiles

Personal development environment configuration for macOS and GitHub Codespaces.

## What's Included

- **Shell:** Zsh with custom prompt and git integration
- **Terminal:** Ghostty / Alacritty with Kanagawa color scheme
- **Editor:** Neovim with native package management
- **Multiplexer:** tmux with custom keybindings
- **Window Manager:** Rectangle
- **Tools:** fzf, ripgrep, bat, zoxide, and more

## Installation

### macOS

```bash
# Clone the repository
git clone https://github.com/BrianGreenhill/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# Run the setup script
./setup.sh
```

**Prerequisites:** [Homebrew](https://brew.sh)

### GitHub Codespaces

**Automatic setup:**
1. Go to [Settings → Codespaces](https://github.com/settings/codespaces)
2. Enable "Automatically install dotfiles"
3. Select repository: `BrianGreenhill/dotfiles`

Your dotfiles will be installed automatically in every new Codespace.

## Structure

```
dotfiles/
├── alacritty/        # Alacritty terminal config
├── ghostty/          # Ghostty terminal config
├── bin/              # Personal scripts
├── nvim/             # Neovim configuration
├── tmux/             # tmux configuration
├── zsh/              # Zsh shell configuration
├── install.sh        # Codespaces installer (auto-runs)
├── setup.sh          # macOS installer
└── Brewfile          # Homebrew packages
```

## Key Features

### Zsh Prompt
- Hostname and shortened path
- Git branch and dirty status indicator
- Integrated with zoxide for smart directory jumping

### Tmux
- **Prefix:** `Ctrl-a` (instead of `Ctrl-b`)
- **Vim-style navigation:** `prefix + h/j/k/l`
- **Splits open in current directory**
- **Status bar:** Session name, current directory, time
- **Kanagawa color scheme**

### Neovim
- No plugin manager — uses native packages (`pack/plugins/start/`)
- Kanagawa Dragon theme
- LSP via `vim.lsp.config` (nvim 0.11+)
- Treesitter syntax highlighting
- blink.cmp (Rust-powered completion)
- Fzf search integration

#### Neovim Plugins

Plugins are managed by a shell script, not a plugin manager.

```bash
~/.config/nvim/plugins.sh           # Install missing plugins
~/.config/nvim/plugins.sh update    # Update all plugins
```

To add a plugin, add `owner/repo` to the `plugins` array in `plugins.sh` and re-run it.

Plugins auto-install on first launch if the pack directory doesn't exist.

## Updating

### Update Homebrew packages
```bash
cd ~/.dotfiles
brew bundle dump --force  # Update Brewfile with current packages
brew bundle                # Install/update packages
```

### Update Neovim plugins
```bash
~/.config/nvim/plugins.sh update
```

### Update configs
Edit files in `~/.dotfiles` - changes are reflected immediately via symlinks.

## Tools Overview

Key tools installed:
- **CLI:** bat, fd, ripgrep, fzf, zoxide, tree, jq, yq
- **Dev:** neovim, tmux, git, gh, node, go
- **Apps:** Ghostty, Alacritty, OrbStack
