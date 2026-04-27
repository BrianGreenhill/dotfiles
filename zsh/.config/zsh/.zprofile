if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -f /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi

if command -v gpg &>/dev/null; then
    [[ -t 0 ]] && export GPG_TTY=$(tty)
    export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket 2>/dev/null)"
    # Skip slow gpgconf --launch (~400ms) when agent is already healthy
    if ! gpg-connect-agent /bye &>/dev/null; then
        gpgconf --launch gpg-agent 2>/dev/null || true
    fi
fi

export PATH=$HOME/bin:$HOME/.local/bin:$PATH
export PATH=$HOME/.krew/bin:$PATH
export PATH="$GOBIN:$PATH"

# Added by OrbStack: command-line tools and integration
# Comment this line if you don't want it to be added again.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
