autoload -Uz compinit && compinit
setopt AUTO_MENU
setopt ALWAYS_TO_END
setopt COMPLETE_ALIASES
setopt COMPLETE_IN_WORD
setopt LIST_PACKED
setopt AUTO_PARAM_KEYS
setopt AUTO_PARAM_SLASH
setopt AUTO_REMOVE_SLASH
autoload edit-command-line; zle -N edit-command-line

_comp_options+=(globdots)

export HOMEBREW_NO_AUTO_UPDATE=1

[[ -e ~/.config/personal/.personal-bashrc ]] && source ~/.config/personal/.personal-bashrc
[[ -e ~/.fzf.zsh ]] && source ~/.fzf.zsh
[[ -e ~/bin/z.sh ]] && source ~/bin/z.sh
[[ -e /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh ]] && source /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh


eval "$(starship init zsh)"
eval "$(direnv hook zsh)"
