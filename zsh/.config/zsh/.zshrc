autoload -Uz compinit && compinit
setopt AUTO_MENU
setopt ALWAYS_TO_END
setopt COMPLETE_ALIASES
setopt COMPLETE_IN_WORD
setopt LIST_PACKED
setopt AUTO_PARAM_KEYS
setopt AUTO_PARAM_SLASH
setopt AUTO_REMOVE_SLASH
autoload edit-command-line; zle -N edit-command-line

_comp_options+=(globdots)
source $ZDOTDIR/completion.zsh
. "$HOME/.cargo/env"

export HOMEBREW_NO_AUTO_UPDATE=1

[[ -e ~/.fzf.zsh ]] && source ~/.fzf.zsh
[[ -e ~/bin/z.sh ]] && source ~/bin/z.sh
[[ -e /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh ]] && source /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh

lsflags="--color"

alias ls="ls ${lsflags}"
alias ll="ls ${lsflags} -l"
alias la="ls ${lsflags} -la"

# docker

alias dc='docker-compose'
alias dce='docker-compose exec'
alias dcl='docker-compose logs -f'
alias dcp='docker-compose ps'
alias dcr='docker-compose restart'
alias dcd='docker-compose down -v'

alias grep='grep --color=auto'
alias tt='tmux2'

# nvim

if which nvim &> /dev/null; then
  alias vim='nvim'
  export EDITOR='nvim'
  export GIT_EDITOR='nvim'
else
  export EDITOR="vim"
  export GIT_EDITOR="vim"
fi

# terraform

alias tf='terraform'
alias tfp='terraform plan'
alias tfa='terraform apply'
alias tfi='terraform init'

# kube

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

# git

alias git='hub'
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
alias gcb='git checkout -b'
alias gg="git log --graph --pretty=format:'%C(bold)%h%Creset%C(magenta)%d%Creset %s %C(yellow)<%an> %C(cyan)(%cr)%Creset' --abbrev-commit --date=relative"
alias gb="git branch"
alias gbclean="git branch --merged | grep -v main | xargs git branch -d"

## brew

alias brewup='brew update; brew upgrade; brew cleanup; brew doctor'

## functions

commitDotFiles() {
    pushd $DOTFILES
    git add .
    git commit -m "another dotfiles commit..."
    git push origin main
    popd
}

eval "$(starship init zsh)"
eval "$(direnv hook zsh)"
