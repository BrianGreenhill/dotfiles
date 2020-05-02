#
# ~/.bashrc
#
export NPM_TOKEN=a028105e-ecac-4576-8114-9cc4b927c489
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
[[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

setxkbmap -option "ctrl:nocaps"
xmodmap -e "keycode 112 = Left"
xmodmap -e "keycode 117 = Right"

. ~/.aliases
. ~/bin/kube-ps1.sh
. ~/.prompt

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export BROWSER=/usr/bin/firefox
export TERMINAL=termite
export EDITOR=/usr/bin/vim
export HISTSIZE=99999999999
export XDG_RUNTIME_DIR=/run/user/$(id -u)
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export PATH=~/.local/bin:~/bin:$PATH:~/go/bin:${KREW_ROOT:-$HOME/.krew}/bin:/home/brian/.cargo/bin
#kubectx and kubens
export GOPATH=/home/brian/go
export PATH=/snap/bin/:~/.kubectx:$GOPATH/bin:~/.local/bin:$PATH
export KUBECONFIG=/home/brian/.kube/config:/home/brian/.kube/eksconfig
export TERM=xterm
export HISTCONTROL=ignoreboth:erasedups
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
