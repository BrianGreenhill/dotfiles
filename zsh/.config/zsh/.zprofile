export DOTFILES="$HOME/.dotfiles"

export GPG_TTY=$(tty)
gpgconf --launch gpg-agent
export SSH_AUTH_SOCKET=$HOME/.gnupg/S.gpg-agent.ssh

export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/sbin::/usr/local/bin:$PATH
export PATH="$GOBIN:$PATH"
