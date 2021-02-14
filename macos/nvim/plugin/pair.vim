fun! BRIANTurnOnRelativeLineNumbers()
    set rnu
    set signcolumn=yes
    set colorcolumn=80
endfun

fun! BRIANTurnOffRelativeLineNumbers()
    set nornu
    set signcolumn=no
    set colorcolumn=800
endfun

nnoremap <leader>pe :call BRIANTurnOnRelativeLineNumbers()<cr>
nnoremap <leader>po :call BRIANTurnOffRelativeLineNumbers()<cr>
