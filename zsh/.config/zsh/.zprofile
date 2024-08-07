export DOTFILES="$HOME/.dotfiles"

export GPG_TTY=$(tty)
gpgconf --launch gpg-agent
export SSH_AUTH_SOCKET=$HOME/.gnupg/S.gpg-agent.ssh

export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/sbin::/usr/local/bin:$PATH
export PATH=$HOME/.rbenv/shims:$PATH
export PATH="$GOBIN:$PATH"

# Added by OrbStack: command-line tools and integration
# Comment this line if you don't want it to be added again.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
