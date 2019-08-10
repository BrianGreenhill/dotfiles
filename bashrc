#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export PS1='[\u@\h \W]\$ '

. ~/.aliases
. ~/.fzf-keybindings
. ~/bin/kube-ps1.sh
. ~/.prompt

export BROWSER=/usr/bin/firefox
export EDITOR=/usr/bin/vim
export HISTSIZE=99999999999
export XDG_RUNTIME_DIR=/run/user/$(id -u)
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export PATH=~/.local/bin:~/bin:$PATH:~/go/bin
#kubectx and kubens
export GOPATH=/home/brian/go
export PATH=/snap/bin/:~/.kubectx:$GOPATH/bin:$PATH
export KUBECONFIG=/home/brian/.kube/config:/home/brian/.kube/eksconfig
export TERM=xterm

[[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh
setxkbmap -option "ctrl:nocaps"
