export DOTFILES="$HOME/.dotfiles"

export GPG_TTY=$(tty)
gpgconf --launch gpg-agent
export SSH_AUTH_SOCKET=$HOME/.gnupg/S.gpg-agent.ssh

export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/sbin::/usr/local/bin:$PATH
export PATH=$HOME/.rbenv/shims:$PATH
export PATH=$HOME/.config/local/share/nvim/mason/bin:$PATH
export PATH=$HOMEBREW_PREFIX/lib/ruby/gems/3.3.0/bin:$PATH
export PATH=/opt/homebrew/opt/ruby/bin:$PATH
export PATH=$HOME/.krew/bin:$PATH
export PATH=$HOME/neovim/bin:$PATH
export PATH=$HOME/tmux/bin:$PATH
export PATH="$GOBIN:$PATH"

# Added by OrbStack: command-line tools and integration
# Comment this line if you don't want it to be added again.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    eval "$(/usr/local/bin/brew shellenv)"
fi
