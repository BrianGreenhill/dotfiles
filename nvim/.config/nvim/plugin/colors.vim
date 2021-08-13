fun! ColorMyVim()
    colorscheme gruvbox
    set background=dark
    let g:gruvbox_contrast_dark='hard'
    highlight Normal ctermbg=NONE guibg=NONE
endfun
call ColorMyVim()
