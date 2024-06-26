export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$XDG_CONFIG_HOME/local/share"
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/cache"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

export EDITOR="nvim"
export VISUAL="nvim"
export GIT_EDITOR="nvim"

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Man pages
export MANPAGER='nvim +Man!'

# fzf
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="
--preview 'bat --color=always --style=numbers --line-range :500 {}' --preview-window=right:60%"

# go
export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"
export GOCACHE="$XDG_CACHE_HOME/go-build"
export GOPROXY=https://goproxy.githubapp.com/mod,https://proxy.golang.org/,direct
export GOPRIVATE=
export GONOPROXY=
export GONOSUMDB='github.com/github/*'

# dotfiles
# TERMINAL = wezterm|kitty|alacritty
export TERMINAL="alacritty"
export STOW_FOLDERS="bin,nvim,tmux,personal,zsh,${TERMINAL}"
export CLICOLOR=1
export BAT_THEME=rose-pine-moon
export HOMEBREW_NO_AUTO_UPDATE=1
