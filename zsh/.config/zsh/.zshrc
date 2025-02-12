parse_git_branch() {
    git branch --show 2> /dev/null | sed -E 's/(.+)/ (\1)/g'
}

setopt PROMPT_SUBST
PROMPT='[@%m] %9c%{%F{green}%}$(parse_git_branch)%{%F{none}%} $ '
autoload -Uz compinit && compinit
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

. ~/.fzf.zsh
eval "$(direnv hook zsh)"
eval "$(zoxide init zsh)"
