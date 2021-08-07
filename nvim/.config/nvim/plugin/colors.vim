fun! ColorMyVim()
    colorscheme gruvbox
    set background=dark
    let g:gruvbox_contrast_dark='hard'
    highlight Normal ctermbg=NONE guibg=NONE
    highlight ColorColumn ctermbg=0 guibg=grey
    highlight LineNr guifg=#5eacd3
    highlight qfFileName guifg=#aed75f
    highlight TelescopeBorder guifg=#5eacd
endfun
call ColorMyVim()
