# https://github.com/sindresorhus/pure
autoload -U promptinit; promptinit
prompt pure

export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh
export EDITOR='vim'

[ -f ~/.aliases ] && source ~/.aliases
[ -f ~/.ghaliases ] && source ~/.ghaliases
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/bin/z.sh ] && source ~/bin/z.sh

export GOPATH=$HOME/go
export PATH=$HOME/bin:$GOPATH/bin:/usr/local/sbin:/usr/local/bin:$PATH
