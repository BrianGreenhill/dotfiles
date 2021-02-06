source ~/.zshrc
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export GPG_TTY=$(tty)
gpgconf --launch gpg-agent
export SSH_AUTH_SOCKET=$HOME/.gnupg/S.gpg-agent.ssh
[ -z "$TMUX" ] && export TERM="xterm-256color"
