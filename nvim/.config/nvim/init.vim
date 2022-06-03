call plug#begin('~/.vim/plugged')
Plug 'darrikonn/vim-gofmt', { 'do': ':GoUpdateBinaries' } " minimal go fmt
Plug 'folke/zen-mode.nvim'
Plug 'glepnir/lspsaga.nvim'
Plug 'gruvbox-community/gruvbox'
Plug 'hoob3rt/lualine.nvim'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'kyazdani42/nvim-web-devicons'
Plug 'L3MON4D3/LuaSnip' " snippets
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'mbbill/undotree', {'branch': 'master'} " visual undo history
Plug 'neovim/nvim-lspconfig' " vim language server protocol
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim', { 'do': 'git submodule update --init --recursive' }
Plug 'nvim-telescope/telescope.nvim' " fuzzy finder in lua
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/playground'
Plug 'onsails/lspkind-nvim'
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'pwntester/octo.nvim'
Plug 'rafamadriz/friendly-snippets' " preconfigured snippets
Plug 'ray-x/lsp_signature.nvim' " show signature help
Plug 'sbdchd/neoformat'
Plug 'sebdah/vim-delve' " go debugging
Plug 'ThePrimeagen/harpoon' " file navigation helper
Plug 'ThePrimeagen/refactoring.nvim' " refactoring a la Martin
Plug 'tpope/vim-commentary' " comment stuff out with gcc
Plug 'tpope/vim-fugitive' " git integration
Plug 'tpope/vim-rhubarb' " :Gbrowse! to copy github URL to clipboard
Plug 'tpope/vim-dispatch' " :Dispatch to tmux stuff
Plug 'windwp/nvim-autopairs' " auto pair things
call plug#end()

set completeopt=menu,menuone,noselect

let mapleader="\<space>"

nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG
nnoremap <C-n> :Ex<CR>

" Y yanks to end of line from cursor position
nnoremap Y y$
nnoremap <leader>n :cnext<CR>
nnoremap <leader>p :cprev<CR>
nnoremap <leader>x :cclose<CR>

augroup GREENHILL
    autocmd!
    autocmd BufWritePre *.js,*.ts,*.tsx,*.jsx,*.lua,*.py,*.lua,*.go try | undojoin | Neoformat | catch /E790/ | Neoformat | endtry
    autocmd BufWritePre * %s/\s\+$//e
    autocmd BufEnter,BufWinEnter,TabEnter *.rs :lua require'lsp_extensions'.inlay_hints{}
augroup END

lua require("greenhill")
