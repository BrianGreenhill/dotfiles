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
alias kg='kubectl get'
alias kgp='kubectl get pod'
alias kd='kubectl describe'
alias kdp='kubectl describe pod'
alias kexec='kubectl exec -it'
alias klog='kubectl logs -f'
alias kdev='kctx dev-cluster.ecosia.org.k8s.local'
alias kstaging='kctx dev-cluster.ecosia.org.k8s.local'
alias kprod='kctx prod-eu-central-1.ecosia.org.k8s.local'
alias kprodus='kctx prod-us-east-1.ecosia.org.k8s.local'
alias kctx='kubectx'
alias kns='kubens'

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

aws_export() {
    export AWS_ACCESS_KEY_ID=$(aws configure get default.aws_access_key_id)
    export AWS_SECRET_ACCESS_KEY=$(aws configure get default.aws_secret_access_key)
}

alias awsexport=aws_export

# grpc

alias grpc_cli='docker run -v `pwd`:/defs --rm -it namely/grpc-cli'
