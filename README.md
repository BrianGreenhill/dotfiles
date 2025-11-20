# dotfiles

Personal development environment configuration for macOS and GitHub Codespaces.

## What's Included

- **Shell:** Zsh with custom prompt and git integration
- **Terminal:** Alacritty with Kanagawa color scheme
- **Editor:** Neovim with Lazy plugin manager
- **Multiplexer:** tmux with custom keybindings
- **Window Manager:** AeroSpace (tiling window manager for macOS)
- **Tools:** fzf, ripgrep, bat, zoxide, and more
- **Ubersicht widget** simple-bar for a minimal menu bar

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
├── aerospace/        # AeroSpace window manager config
├── alacritty/        # Terminal emulator config
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
- Lazy.nvim plugin manager
- Kanagawa Dragon theme
- LSP support with Mason
- Treesitter syntax highlighting
- Fzf search integration

## Updating

### Update Homebrew packages
```bash
cd ~/.dotfiles
brew bundle dump --force  # Update Brewfile with current packages
brew bundle                # Install/update packages
```

### Update configs
Edit files in `~/.dotfiles` - changes are reflected immediately via symlinks.

## Tools Overview

Key tools installed:
- **CLI:** bat, fd, ripgrep, fzf, zoxide, tree, jq, yq
- **Dev:** neovim, tmux, git, gh, node, go, rust
- **Apps:** Alacritty, AeroSpace, OrbStack

## License

MIT
