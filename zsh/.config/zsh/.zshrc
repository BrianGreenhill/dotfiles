autoload -Uz compinit && compinit
autoload -U colors && colors
bindkey -v
export KEYTIMEOUT=1

mountain="󰋵"
prmpt="❯"
export PS1="%F{green} "$mountain"  %~%f %F{red}"$prmpt"%f "

alias lt='tree -L 2'
alias ll='eza -l --icons -a'
alias l="eza -l --icons --git -a"
alias t="eza --tree --level=2 --icons"
alias vim='nvim'
alias k='kubectl'
alias kg='kubectl get'
alias kgp='kubectl get pod'
alias kd='kubectl describe'
alias kdp='kubectl describe pod'
alias kexec='kubectl exec -i'
alias klog='kubectl logs -f'
alias kpf='kubectl port-forward'
alias kctx='kubectx'
alias kns='kubens'
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
eval "$(rbenv init - zsh)"
