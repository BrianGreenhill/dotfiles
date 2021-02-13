call plug#begin('~/.vim/plugged')
Plug 'dbeniamine/cheat.sh-vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'gruvbox-community/gruvbox'
Plug 'mbbill/undotree', {'branch': 'master'}
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fugitive' " git integration
Plug 'tpope/vim-commentary' " comment stuff out with gcc
Plug 'tpope/vim-rhubarb' " :Gbrowse! to copy github URL to clipboard
Plug 'tpope/vim-rails' " ruby rails navigation with gf
Plug 'tpope/vim-bundler' " bundle integration for ruby projects
Plug 'tpope/vim-dispatch' " i forgot
call plug#end()

let mapleader="\<space>"

nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>nr :set nornu<CR>
nnoremap <C-n> :Lexplore<CR>
nnoremap <C-h> <C-w>h<CR>
nnoremap <C-j> <C-w>j<CR>
nnoremap <C-k> <C-w>k<CR>
nnoremap <C-l> <C-w>l<CR>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
let NERDTreeMinimalUI=1
let NERDTreeShowHidden=1
nnoremap <leader>gs :Gstatus<Cr>
nnoremap <leader>ga :Git fetch --all<CR>
nnoremap <leader>u :UndotreeShow<CR>

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup BRIAN
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
augroup END
