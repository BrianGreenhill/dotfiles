if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -f /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi

if command -v gpg &>/dev/null; then
    export GPG_TTY=$(tty)
    gpgconf --launch gpg-agent 2>/dev/null || true
    export SSH_AUTH_SOCK=$HOME/.gnupg/S.gpg-agent.ssh
fi

export PATH=$HOME/bin:$HOME/.local/bin:$PATH
export PATH=$HOME/.krew/bin:$PATH
export PATH="$GOBIN:$PATH"

# Added by OrbStack: command-line tools and integration
# Comment this line if you don't want it to be added again.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
