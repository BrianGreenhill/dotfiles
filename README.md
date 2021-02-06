# Dotfiles

There are dotfiles in this repository for both linux and mac systems. Both
system configurations operate by creating symlinks for configuration files in
the $HOME directory. Fair warning: It uses `ln -sf` which forces the creation
of a symbolic link.

## Usage

```
# mac system
make mac

# linux system
make linux
```

## What's here

### Mac
- vimrc: nvim configuration (mapped to ~/.config/nvim/init.vim)
- gitignore: global gitignore (~/.gitignore)
- tmux conf: tmux configuration (~/.tmux.conf)
- aliases: aliases to reduce toil (~/.aliases)
- zshrc: zshrc for shell config (~/.zshrc)
- zprofile: zprofile as an entrypoint to zshrc mostly for nvim (~/.zprofile)
