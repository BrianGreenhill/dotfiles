# `brew shellenv` output is static; cache it and regenerate when brew updates.
for _brew in /opt/homebrew/bin/brew /usr/local/bin/brew; do
    [[ -x $_brew ]] || continue
    _brew_env="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/brew_shellenv.zsh"
    if [[ ! -s $_brew_env || $_brew -nt $_brew_env ]]; then
        mkdir -p "${_brew_env:h}"
        { $_brew shellenv > "$_brew_env.tmp.$$" && mv "$_brew_env.tmp.$$" "$_brew_env" } 2>/dev/null
    fi
    if [[ -s $_brew_env ]]; then source "$_brew_env"; else eval "$($_brew shellenv)"; fi
    break
done
unset _brew _brew_env

if command -v gpg &>/dev/null; then
    [[ -t 0 ]] && export GPG_TTY=$TTY
    export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket 2>/dev/null)"
    # gpg-agent auto-launches on first use; don't block shell startup on
    # scdaemon/YubiKey enumeration (a cold ping can stall for seconds).
fi

export PATH=$HOME/bin:$HOME/.local/bin:$PATH
export PATH=$HOME/.krew/bin:$PATH
export PATH="$GOBIN:$PATH"

# Added by OrbStack: command-line tools and integration
# Comment this line if you don't want it to be added again.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
