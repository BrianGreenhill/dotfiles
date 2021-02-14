call plug#begin('~/.vim/plugged')
Plug 'dbeniamine/cheat.sh-vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'gruvbox-community/gruvbox'
Plug 'honza/vim-snippets'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree', {'branch': 'master'}
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'SirVer/ultisnips'
Plug 'tpope/vim-bundler' " bundle integration for ruby projects
Plug 'tpope/vim-commentary' " comment stuff out with gcc
Plug 'tpope/vim-dispatch' " i forgot
Plug 'tpope/vim-fugitive' " git integration
Plug 'tpope/vim-rails' " ruby rails navigation with gf
Plug 'tpope/vim-rhubarb' " :Gbrowse! to copy github URL to clipboard
Plug 'tpope/vim-vinegar' " netrw enhancements
call plug#end()

let mapleader="\<space>"

nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>y "+y
vnoremap <leader>y "+y

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup BRIAN
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
augroup END
