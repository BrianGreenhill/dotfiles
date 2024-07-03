# autoload zsh/zprof
autoload -U colors && colors
# https://zsh.sourceforge.io/Doc/Release/Options.html
setopt AUTO_MENU
setopt ALWAYS_TO_END
setopt COMPLETE_ALIASES
setopt LIST_PACKED
setopt AUTO_PARAM_KEYS
setopt AUTO_PARAM_SLASH
setopt AUTO_REMOVE_SLASH
setopt HIST_EXPIRE_DUPS_FIRST
setopt SHARE_HISTORY

export HISTFILE="$ZDOTDIR/.zhistory"
export HISTSIZE=10000
export SAVEHIST=10000
export INC_APPEND_HISTORY

# prompt with git branch
autoload -Uz vcs_info
setopt prompt_subst
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '( %F{#8be9fd}%b%f)'
PROMPT='%(?.%F{#50fa7b}⏺.%F{#ff79cb}⏺)%f %2~ ${vcs_info_msg_0_} %# '

bindkey ^R history-incremental-search-backward 

FPATH=~/.rbenv/completions:"$FPATH"
autoload -Uz compinit && compinit
zstyle ':completion:*' menu yes select
zmodload zsh/complist
_comp_options+=(globdots)

bindkey -v
export KEYTIMEOUT=1

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

[[ -e ~/.fzf.zsh ]] && source ~/.fzf.zsh
[[ -e ~/.config/zsh/.aliases ]] && source ~/.config/zsh/.aliases
[[ -e /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh ]] && source /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh
[[ -e ~/.asdf/asdf.sh ]] && source ~/.asdf/asdf.sh

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
eval "$(direnv hook zsh)"
eval "$(zoxide init zsh)"
#zprof
