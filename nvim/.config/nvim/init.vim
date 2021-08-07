call plug#begin('~/.vim/plugged')
Plug 'gruvbox-community/gruvbox'
Plug 'glepnir/lspsaga.nvim'
Plug 'hoob3rt/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'mbbill/undotree', {'branch': 'master'} " visual undo history
Plug 'mhartington/formatter.nvim'
Plug 'neovim/nvim-lspconfig' " vim language server protocol
" Plug 'nvim-lua/completion-nvim' " autocompletion
Plug 'hrsh7th/nvim-compe'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim' " fuzzy finder in lua
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'pwntester/octo.nvim'
Plug 'sebdah/vim-delve' " go debugging
Plug 'tpope/vim-commentary' " comment stuff out with gcc
Plug 'tpope/vim-fugitive' " git integration
Plug 'tpope/vim-rhubarb' " :Gbrowse! to copy github URL to clipboard
call plug#end()
let mapleader="\<space>"

nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG

" Y yanks to end of line from cursor position
nnoremap Y y$
nnoremap <C-j> :cnext<CR>
nnoremap <C-k> :cprev<CR>
nnoremap <C-x> :cclose<CR>

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup GREENHILL
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
augroup END

lua require("greenhill")
