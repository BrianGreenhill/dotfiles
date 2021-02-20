call plug#begin('~/.vim/plugged')
Plug 'gruvbox-community/gruvbox'
Plug 'honza/vim-snippets'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'mbbill/undotree', {'branch': 'master'} " visual undo history
Plug 'mhartington/formatter.nvim'
Plug 'neovim/nvim-lspconfig' " vim language server protocol
Plug 'nvim-lua/completion-nvim' " autocompletion
Plug 'nvim-lua/lsp-status.nvim' " better status info
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim' " fuzzy finder in lua
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'RishabhRD/popfix'
Plug 'RishabhRD/nvim-lsputils'
Plug 'sbdchd/neoformat' " formatting
Plug 'SirVer/ultisnips' " snippet management engine
Plug 'tjdevries/complextras.nvim' " completion extras
Plug 'tjdevries/nlua.nvim'
Plug 'tjdevries/lsp_extensions.nvim'
Plug 'tpope/vim-bundler' " bundle integration for ruby projects
Plug 'tpope/vim-commentary' " comment stuff out with gcc
Plug 'tpope/vim-fugitive' " git integration
Plug 'tpope/vim-rails' " ruby rails navigation with gf
Plug 'tpope/vim-rhubarb' " :Gbrowse! to copy github URL to clipboard
Plug 'tpope/vim-surround' " change surrounding things to other things with cs<thing><otherthing>
Plug 'tpope/vim-vinegar' " netrw enhancements
call plug#end()
lua require'nvim-treesitter.configs'.setup { highlight = { enable = true } }

let mapleader="\<space>"

nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <C-n> :NERDTreeToggle<CR>

lua << EOF
require'nvim-web-devicons'.setup {default = true;}
EOF
let NERDTreeMinimalUI=1
let NERDTreeShowHidden=1

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup BRIAN
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
augroup END

exec 'luafile' . expand("~/.config/nvim/plugin/formatting.lua")
