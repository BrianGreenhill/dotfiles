fun! GREENHILLTurnOnRelativeLineNumbers()
    set rnu
    set signcolumn=yes
    set colorcolumn=80
endfun

fun! GREENHILLTurnOffRelativeLineNumbers()
    set nornu
    set signcolumn=no
    set colorcolumn=800
endfun

nnoremap <leader>pe :call GREENHILLTurnOnRelativeLineNumbers()<cr>
nnoremap <leader>po :call GREENHILLTurnOffRelativeLineNumbers()<cr>
