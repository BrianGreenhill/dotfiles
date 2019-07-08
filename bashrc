#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export PS1='[\u@\h \W]\$ '

. ~/.sensible-bash
. ~/.aliases
. ~/bin/z.sh
. ~/.fzf-keybindings
. ~/bin/kube-ps1.sh

export BROWSER=/usr/bin/firefox
export EDITOR=/usr/bin/vim
export HISTSIZE=99999999999
export ANSIBLE_VAULT_PASSWORD_FILE=/home/brian/.vpass
export XDG_RUNTIME_DIR=/run/user/$(id -u)
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export PATH=~/bin:$PATH:~/go/bin
export QT_SCALE_FACTOR=1.5
export GDK_SCALE=2
export VAULT_ADDR=https://vault.hellofresh.io/
#kubectx and kubens
export PATH=/snap/bin/:~/.kubectx:$PATH
export KUBECONFIG=/home/brian/.kube/config:/home/brian/.kube/eksconfig
export TERM=xterm

. ~/.prompt
