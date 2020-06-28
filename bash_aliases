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
alias evrc='vim ~/.vimrc'
alias ei3c='vim ~/.config/i3/config'
alias tmux='tmux -2'

alias res='setres'

# terraform

alias tf='terraform'
alias tfp='terraform plan'
alias tfa='terraform apply'
alias tfi='terraform init'

# kube

source <(kubectl completion bash)
# complete on the k alias as well
complete -F __start_kubectl k

alias k='kubectl'
alias kg='kubectl get'
alias kgp='kubectl get pod'
alias kd='kubectl describe'
alias kdp='kubectl describe pod'
alias kexec='kubectl exec -it'
alias klog='kubectl logs -f'
alias kpf='kubectl port-forward'
alias kpfprom='kubectl port-forward svc/monitoring-prometheus-server 9090:80 -n monitoring'
alias kdev='kctx dev-cluster.ecosia.org.k8s.local'
alias kstaging='kctx dev-cluster.ecosia.org.k8s.local'
alias kprod='kctx prod-eu-central-1.ecosia.org.k8s.local'
alias kprodus='kctx prod-us-east-1.ecosia.org.k8s.local'
alias kctx='kubectx'
alias kns='kubens'
alias allmanifests='find . -type f -name "Makefile" -printf "%h\n" | grep -v \{\{ | grep -v ingress | grep -v system | xargs -I{} make ECOSIA_ENV=prod REGION=ca-central-1 -s -C {} manifest > manifest.yaml'

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
    export AWS_PROFILE=$1
    export AWS_ACCESS_KEY_ID=$(aws configure get ${AWS_PROFILE}.aws_access_key_id)
    export AWS_SECRET_ACCESS_KEY=$(aws configure get ${AWS_PROFILE}.aws_secret_access_key)
    export AWS_DEFAULT_REGION=$2
}

alias awsex='aws_export'
alias awsexport='aws_export default eu-central-1'
alias awsexportdo='aws_export digitalocean eu-central-1'
alias awsexportca='aws_export default ca-central-1'
alias awsexportcs='aws_export cabinscape us-east-2'
alias awsexportdev='aws_export developer ca-central-1'

# grpc

alias grpc_cli='docker run -v `pwd`:/defs --rm -it namely/grpc-cli'

make_corona_api_call() {
  uri=$1
  curl https://api.covid19api.com/$uri -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:74.0) Gecko/20100101 Firefox/74.0' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' -H 'Accept-Language: en-US,en;q=0.5' --compressed -H 'Referer: https://covid19api.com/' -H 'DNT: 1' -H 'Connection: keep-alive' -H 'Upgrade-Insecure-Requests: 1' -H 'Cache-Control: max-age=0'
}

alias coronapi=make_corona_api_call
