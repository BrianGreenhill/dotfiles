autoload -Uz compinit && compinit
autoload -U colors && colors
autoload -U promptinit; promptinit; prompt pure

# https://zsh.sourceforge.io/Doc/Release/Options.html
# # Set options for history and shell behavior
setopt AUTO_MENU ALWAYS_TO_END COMPLETE_ALIASES LIST_PACKED
setopt AUTO_PARAM_KEYS AUTO_PARAM_SLASH AUTO_REMOVE_SLASH EXTENDED_HISTORY
setopt SHARE_HISTORY HIST_EXPIRE_DUPS_FIRST HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS HIST_FIND_NO_DUPS HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS HIST_VERIFY

eval "$(direnv hook zsh)"

[[ -e ~/.local/bin/z.sh ]] && source ~/.local/bin/z.sh
[[ -e ~/.config/zsh/.aliases ]] && source ~/.config/zsh/.aliases
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[[ -e ~/.asdf/asdf.sh ]] && source ~/.asdf/asdf.sh
[[ -f ~/.fzf-tab/fzf-tab.plugin.zsh ]] && source ~/.fzf-tab/fzf-tab.plugin.zsh

bindkey -v
export KEYTIMEOUT=1

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
    # append selection to nvim and open to the line number
    # preview the file contents
    fzf --ansi --query="$INITIAL_QUERY" \
        --bind "change:reload:$RG_PREFIX {q} || true" \
        --delimiter : \
        --tmux \
        --preview 'preview.sh {1} {2}' \
        --preview-window=right:60%:wrap \
        --phony
}

# # Bind the custom function to Ctrl-G
zle -N search_contents
bindkey '^G' search_contents

# zprof
