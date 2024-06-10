autoload -U colors && colors
PROMPT='%F{#eb6f92}%n%f@%F{#c4a7e7}%m %F{#e0def4}%~ %f> '

setopt AUTO_MENU
setopt ALWAYS_TO_END
setopt COMPLETE_ALIASES
setopt LIST_PACKED
setopt AUTO_PARAM_KEYS
setopt AUTO_PARAM_SLASH
setopt AUTO_REMOVE_SLASH

export HISTFILE="$ZDOTDIR/.zhistory"
export HISTSIZE=10000
export SAVEHIST=10000
export INC_APPEND_HISTORY

bindkey ^R history-incremental-search-backward 

autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

bindkey -v
export KEYTIMEOUT=1

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

[[ -e ~/.fzf.zsh ]] && source ~/.fzf.zsh
[[ -e ~/bin/z.sh ]] && source ~/bin/z.sh
[[ -e ~/.config/zsh/.aliases ]] && source ~/.config/zsh/.aliases
[[ -e /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh ]] && source /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh

## functions
commitDotFiles() {
    pushd $DOTFILES
    git add .
    git commit -m "another dotfiles commit..."
    git push origin main
    popd
}

# Custom function to search file contents with rg and fzf
search_contents() {
    RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case --hidden --glob '!.git/*' --ignore-file '.gitignore'"
    INITIAL_QUERY=""

    # Use fzf with ripgrep to search file contents
    fzf --ansi --query="$INITIAL_QUERY" \
        --bind "change:reload:$RG_PREFIX {q} || true" \
        --delimiter : \
        --preview 'preview.sh {1} {2}' \
        --preview-window=right:60%:wrap \
        --phony
}

# Bind the custom function to Ctrl-G
zle -N search_contents
bindkey '^G' search_contents

. "$HOME/.cargo/env"
eval "$(direnv hook zsh)"

# Minimalistic Zsh Prompt with Rose Pine Moon Color Scheme
