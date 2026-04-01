autoload -Uz compinit
if [[ -z "$ZSH_COMPDUMP" ]]; then
  ZSH_COMPDUMP="${ZDOTDIR:-$HOME}/.zcompdump"
fi
if [[ "$ZSH_COMPDUMP"(#qNmh+24) ]]; then
  compinit -d "$ZSH_COMPDUMP"
else
  compinit -C -d "$ZSH_COMPDUMP"
fi

parse_git_branch() {
  local info
  info=$(git status --branch --porcelain=v2 2>/dev/null) || return
  local branch=$(echo "$info" | sed -n 's/^# branch.head //p')
  local dirty=""
  echo "$info" | grep -qE '^[12?!]' && dirty="*"
  [[ -n "$branch" ]] && echo " (${branch})${dirty}"
}

setopt PROMPT_SUBST
PROMPT='%F{blue}%m%f: %F{cyan}%2~%f%F{green}$(parse_git_branch)%f $ '
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

[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh
command -v direnv &>/dev/null && eval "$(direnv hook zsh)"
command -v zoxide &>/dev/null && eval "$(zoxide init zsh)"
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
command -v carapace &>/dev/null && source <(carapace _carapace)
