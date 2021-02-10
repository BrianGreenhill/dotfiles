" init.vim stuff
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath

" vimrc
set nocompatible
set encoding=utf-8

set guicursor=
set relativenumber
set nohlsearch
set incsearch
set nu
set hidden
set noerrorbells
set tabstop=2 softtabstop=2
set shiftwidth=2
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
set signcolumn=yes
set colorcolumn=80
set scrolloff=8

set mouse=a " mouse despite tmux

call plug#begin()

Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'
Plug 'honza/vim-snippets'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mbbill/undotree', {'branch': 'master'}
Plug 'nvie/vim-flake8'
Plug 'jparise/vim-graphql'
Plug 'yuki-ycino/fzf-preview.vim', { 'branch': 'release', 'do': ':UpdateRemotePlugins' }
Plug 'pangloss/vim-javascript'
Plug 'editorconfig/editorconfig-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'eslint/eslint'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'dense-analysis/ale'
Plug 'morhetz/gruvbox'
Plug 'szw/vim-maximizer'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'jparise/vim-graphql'

if executable('rg')
    let g:rg_derive_root='true'
endif

call plug#end()

colorscheme gruvbox
highlight Normal guibg=0 ctermbg=0
autocmd VimEnter * hi Normal ctermbg=none
let mapleader="\<space>"

nnoremap <C-a> :Rg<CR>
nnoremap <C-p> :GFiles<CR>
nnoremap <C-g> :GFiles?<CR>
nnoremap <leader>gs :Gitstatus<Cr>
nnoremap <leader>ga :Git fetch --all<CR>
nnoremap <leader>ghw :h <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>prw :CocSearch <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>pw :Rg <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <C-h> <C-w>h<CR>
nnoremap <C-j> <C-w>j<CR>
nnoremap <C-k> <C-w>k<CR>
nnoremap <C-l> <C-w>l<CR>
nnoremap <leader>z :MaximizerToggle<CR>
nnoremap <C-=> :vertical resize +10<CR>
nnoremap <C--> :vertical resize -10<CR>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
let $FZF_DEFAULT_OPTS='--reverse'
nnoremap <leader>gb :GBranches<CR>
nnoremap <leader>gf :Gfetch<CR>

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

let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ 'coc-solargraph',
  \ 'coc-prettier',
  \ 'coc-go',
  \ 'coc-protobuf'
  \ ]
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

let g:ale_disable_lsp = 1
let g:go_fmt_command = "goimports"
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'
let g:ale_completion_enabled = 1
let g:ale_sign_column_always = 1 " always show sign column, so text doesn't move around
let g:ale_set_quickfix = 1
let g:airline#extensions#ale#enabled = 1
let g:go_fmt_fail_silently = 1
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
