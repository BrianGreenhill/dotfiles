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

export BROWSER=/usr/bin/firefox
export EDITOR=/usr/bin/vim
export GITHUB_TOKEN=94c39002f2ceeb88c59438f954630eeddd5c1b87
export HISTSIZE=99999999999
export ANSIBLE_VAULT_PASSWORD_FILE=/home/brian/.vpass
export XDG_RUNTIME_DIR=/run/user/$(id -u)
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export PATH=~/bin:$PATH:~/go/bin
export QT_SCALE_FACTOR=1.5
export GDK_SCALE=2
export VAULT_ADDR=https://vault.hellofresh.io/
#kubectx and kubens
export PATH=~/.kubectx:$PATH
export KUBECONFIG=/home/brian/.kube/config:/home/brian/.kube/eksconfig

function _update_ps1() {
    PS1=$(powerline-shell $?)
}

if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi
