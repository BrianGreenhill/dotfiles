export DOTFILES="$HOME/.dotfiles"

export GPG_TTY=$(tty)
gpgconf --launch gpg-agent
export SSH_AUTH_SOCKET=$HOME/.gnupg/S.gpg-agent.ssh

export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/sbin::/usr/local/bin:$PATH
export PATH="$GOBIN:$PATH"
export PATH="/usr/local/opt/ruby/bin:$PATH"

# Added by OrbStack: command-line tools and integration
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
