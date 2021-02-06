set nocompatible
set encoding=utf-8

set guicursor=
set relativenumber
set nohlsearch
set incsearch
set nu
set hidden
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartcase
set smartindent
set nowrap
set noswapfile
set nobackup
set undodir=~/.config/nvim/undodir
set undofile
set cmdheight=2
set updatetime=50
set shortmess+=c
set t_Co=256
set termguicolors
set signcolumn=yes
set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

call plug#begin()

Plug 'ThePrimeagen/vim-be-good'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'
Plug 'honza/vim-snippets'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'hashivim/vim-terraform'
Plug 'gruvbox-community/gruvbox'
Plug 'mbbill/undotree', {'branch': 'master'}
Plug 'nvie/vim-flake8'
Plug 'yuki-ygino/fzf-preview.vim', { 'branch': 'release', 'do': ':UpdateRemotePlugins' }

if executable('rg')
    let g:rg_derive_root='true'
endif


call plug#end()

let g:gruvbox_contrast_dark = 'hard'
colorscheme gruvbox
set background=dark
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
let g:gruvbox_invert_selection='0'

let mapleader="\<space>"

nnoremap <C-a> :Rg<CR>
nnoremap <C-p> :GFiles<CR>
nnoremap <leader>gs :Gitstatus<Cr>
nnoremap <leader>ga :Git fetch --all<CR>
nnoremap <leader>ghw :h <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>prw :CocSearch <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>pw :Rg <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>h <C-w>h<CR>
nnoremap <leader>j <C-w>j<CR>
nnoremap <leader>k <C-w>k<CR>
nnoremap <leader>l <C-w>l<CR>
nnoremap <leader>+ :vertical resize +5<CR>
nnoremap <leader>- :vertical resize -5<CR>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
let $FZF_DEFAULT_OPTS='--reverse'
nnoremap <leader>gc :GBranches<CR>

map <C-n> :NERDTreeToggle<CR>
nnoremap <silent> <leader>f :NERDTreeFind<CR>
let NERDTreeMinimalUI=1
let NERDTreeShowHidden=1

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun
autocmd BufWritePre * :call TrimWhitespace()

autocmd BufWritePost *.*sonnet !jsonnetfmt -i --string-style d --no-pad-arrays %
let g:terraform_fmt_on_save=1
autocmd FileType make setlocal noexpandtab
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd BufRead,BufNewFile *.md setlocal textwidth=80

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <c-space> coc#refresh()
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
