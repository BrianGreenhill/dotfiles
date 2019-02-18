#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export PS1='[\u@\h \W]\$ '

. ~/.aliases
. ~/bin/z.sh
. ~/.fzf-keybindings

export BROWSER=/usr/bin/firefox
export EDITOR=/usr/bin/vim
export GITHUB_TOKEN=94c39002f2ceeb88c59438f954630eeddd5c1b87
export HISTSIZE=99999999999
export ANSIBLE_VAULT_PASSWORD_FILE=/home/brian/.vpass
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export PATH=~/bin:$PATH:~/go/bin

powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. /usr/share/powerline/bindings/bash/powerline.sh
