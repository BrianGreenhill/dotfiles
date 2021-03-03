call plug#begin('~/.vim/plugged')
Plug 'gruvbox-community/gruvbox'
Plug 'honza/vim-snippets'
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
Plug 'sebdah/vim-delve' " go debugging
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
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()
let mapleader="\<space>"
let g:airline_theme='gruvbox'

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

exec 'luafile' . expand("~/.config/nvim/plugin/lsp.lua")
" exec 'luafile' . expand("~/.config/nvim/plugin/telescope.lua")
exec 'luafile' . expand("~/.config/nvim/plugin/formatting.lua")
