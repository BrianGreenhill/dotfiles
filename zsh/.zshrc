DISABLE_MAGIC_FUNCTIONS=true
export ZSH="$HOME/.oh-my-zsh"
export DOTFILES=$HOME/.dotfiles
export EDITOR='vim'
export NVM_LAZY_LOAD=true

ZSH_THEME="minimal"

plugins=(zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

HISTFILE=$HOME/.zsh_history
HISTSIZE=50000
SAVEHIST=50000

setopt EXTENDED_HISTORY
setopt HIST_VERIFY
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Dont record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Dont record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Dont write duplicate entries in the history file.

setopt inc_append_history
setopt share_history

[[ -e ~/.config/personal/.personal-bashrc ]] && source ~/.config/personal/.personal-bashrc
[[ -e ~/.config/github/.personal-bashrc ]] && source ~/.config/github/.personal-bashrc
[[ -e ~/.fzf.zsh ]] && source ~/.fzf.zsh
[[ -e ~/bin/z.sh ]] && source ~/bin/z.sh

if type fzf &> /dev/null && type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*" --glob "!vendor/*"'
  export FZF_CTRL_T_COMMAND='rg --files --hidden --follow --glob "!.git/*" --glob "!vendor/*"'
  export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
fi

[[ -s "/Users/briangreenhill/.gvm/scripts/gvm" ]] && source "/Users/briangreenhill/.gvm/scripts/gvm"
eval "$(direnv hook zsh)"

timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}

initRuby() {
  eval "$(rbenv init -)"
}
