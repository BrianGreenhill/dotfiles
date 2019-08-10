alias dc='docker-compose'
alias hosts='sudo vim /etc/hosts'
alias please='sudo'
alias pbcopy='xclip -selection clipboard'
alias grep='grep --color=auto'
alias timer='echo "Timer started. Stop with Ctrl-D." && date && time cat && date'
alias ls='ls --color=auto'
alias refresh='source ~/.bashrc'
alias prettyjson='python -m json.tool'
alias decrypt='ansible-vault decrypt'
alias encrypt='ansible-vault encrypt'
alias ll='ls -al'
alias vim='nvim'
alias vi='vim'
alias tmux='tmux -2'

alias res='setres'

# terraform

alias tf='terraform'
alias tfp='terraform plan'
alias tfa='terraform apply'
alias tfi='terraform init'

# kube

source <(kubectl completion bash)

alias k='kubectl'
alias kgp='kubectl get pods'
alias kdp='kubectl describe pod'
alias kexec='kubectl exec -it'
alias klog='kubectl logs -f'
alias kahoy='kctx platform.ahoy-k8s.hellofresh.io'
alias klive='kctx platform.live-k8s.hellofresh.io'
alias kstaging='kctx platform.staging-k8s.hellofresh.io'
alias kctx='kubectx'
alias kns='kubens'

# arch

export QT_STYLE_OVERRIDE=gtk
export QT_SELECT=qt5

if [[ $LANG = '' ]]; then
	export LANG=en_US.UTF-8
fi

# git

alias git='hub'
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
alias gcom='git checkout master'
alias gcb='git checkout -b'
alias gg="git log --graph --pretty=format:'%C(bold)%h%Creset%C(magenta)%d%Creset %s %C(yellow)<%an> %C(cyan)(%cr)%Creset' --abbrev-commit --date=relative"
alias gb="git branch"

krr() {
    if [[ $2 ]]; then type=$2; else type="deployment"; fi

    kubectl patch $type $1 -p "{\"spec\":{\"template\":{\"metadata\":{\"labels\":{\"rolling-restart\":\"`date +'%s'`\"}}}}}"
    kubectl rollout status $type/$1
}
