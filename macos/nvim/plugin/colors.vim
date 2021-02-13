fun! ColorMyVim()
    colorscheme gruvbox
    set background=dark
    let g:gruvbox_contrast_dark='hard'
    highlight normal guibg=none
    highlight ColorColumn ctermbg=0 guibg=grey
endfun
call ColorMyVim()
