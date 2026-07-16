autoload -Uz compinit
if [[ -z "$ZSH_COMPDUMP" ]]; then
  ZSH_COMPDUMP="${ZDOTDIR:-$HOME}/.zcompdump"
fi
if [[ "$ZSH_COMPDUMP"(#qNmh+24) ]]; then
  compinit -d "$ZSH_COMPDUMP"
else
  compinit -C -d "$ZSH_COMPDUMP"
fi

# Git prompt: branch name is resolved synchronously (cheap, no work-tree
# scan) while the dirty indicator is computed asynchronously so a slow
# `git status` in a large repo never blocks the prompt (e.g. a new tmux tab).
typeset -g _prompt_git_branch=''
typeset -g _prompt_git_dirty=''
typeset -g _prompt_git_async_fd=-1

_prompt_git_branch_name() {
  _prompt_git_branch=''
  git rev-parse --is-inside-work-tree &>/dev/null || { _prompt_git_dirty=''; return }
  local ref
  ref=$(git symbolic-ref --short HEAD 2>/dev/null) \
    || ref=$(git rev-parse --short HEAD 2>/dev/null) \
    || return
  _prompt_git_branch=$ref
}

_prompt_git_async_done() {
  local fd=$1 result=''
  IFS= read -r result <&$fd
  zle -F $fd 2>/dev/null
  exec {fd}<&- 2>/dev/null
  _prompt_git_async_fd=-1
  if [[ $result != $_prompt_git_dirty ]]; then
    _prompt_git_dirty=$result
    zle reset-prompt 2>/dev/null
  fi
}

_prompt_git_async_start() {
  if (( _prompt_git_async_fd >= 0 )); then
    zle -F $_prompt_git_async_fd 2>/dev/null
    exec {_prompt_git_async_fd}<&- 2>/dev/null
    _prompt_git_async_fd=-1
  fi
  [[ -n $_prompt_git_branch ]] || { _prompt_git_dirty=''; return }
  exec {_prompt_git_async_fd}< <(
    if [[ -n $(git status --porcelain --ignore-submodules=dirty 2>/dev/null) ]]; then
      print -r -- '*'
    fi
  )
  zle -F $_prompt_git_async_fd _prompt_git_async_done
}

_prompt_git_precmd() {
  _prompt_git_branch_name
  _prompt_git_async_start
}
autoload -Uz add-zsh-hook
add-zsh-hook precmd _prompt_git_precmd

setopt PROMPT_SUBST
PROMPT='%F{blue}%m%f: %F{cyan}%2~%f%F{green}${_prompt_git_branch:+ (${_prompt_git_branch})${_prompt_git_dirty}}%f $ '
autoload -U colors && colors
bindkey -e

bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

export KEYTIMEOUT=1

alias ll='ls -alh'
alias vim='nvim'
alias v='nvim'
alias dcp='docker compose ps'
alias dcd='docker compose down -v'
alias dcu='docker compose up -d --build'
alias dc='docker compose'
alias dcexec='docker compose exec'
alias k='kubectl'
alias kg='kubectl get'
alias kgp='kubectl get pod'
alias kd='kubectl describe'
alias kdp='kubectl describe pod'
alias kexec='kubectl exec -i'
alias klog='kubectl logs -f'
alias kpf='kubectl port-forward'
alias kctx='kubectl ctx'
alias kns='kubectl ns'
alias g='git'
alias gcl='git clone'
alias gap='git add -p'
alias gpristine='git reset --hard && git clean -dfx'
alias gst='git status'
alias gl='git pull'
alias gp='git push'
alias gpuo="git push --set-upstream origin"
alias branch="git branch | grep \* | cut -d ' ' -f2"
alias gd='git diff'
alias gcm='git commit -v -m'
alias gco='git checkout'
alias gcom='git checkout main'
alias gcoma='git checkout master'
alias gcb='git checkout -b'
alias gb="git branch"
alias gbclean="git branch --merged | grep -v main | xargs git branch -d"
alias rg="rg --hidden --glob=!.git/"
alias grep='grep --color=auto'
alias brewup='brew update; brew upgrade; brew cleanup; brew doctor'

alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"

# Cache a command's init output, regenerating when the binary updates
_cached_eval() {
    local cmd=$1
    local cmd_path="${commands[$cmd]:-$(command -v "$cmd" 2>/dev/null)}" || return
    shift
    local cache_key="${cmd}__${(j:_:)@}"
    local cache_file="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/${cache_key}.zsh"
    if [[ ! -f "$cache_file" || "$cmd_path" -nt "$cache_file" ]]; then
        mkdir -p "${cache_file:h}"
        local tmp_file="${cache_file}.tmp.$$"
        if "$cmd" "$@" > "$tmp_file" 2>/dev/null; then
            mv "$tmp_file" "$cache_file"
        else
            rm -f "$tmp_file"
            # Fallback to direct eval if caching fails
            eval "$("$cmd" "$@")"
            return
        fi
    fi
    source "$cache_file"
}

[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh
command -v direnv &>/dev/null && _cached_eval direnv hook zsh
command -v zoxide &>/dev/null && _cached_eval zoxide init zsh
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
command -v carapace &>/dev/null && _cached_eval carapace _carapace
