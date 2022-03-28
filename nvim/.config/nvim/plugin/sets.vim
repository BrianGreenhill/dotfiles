set tabstop=2 softtabstop=2 shiftwidth=2 " default tabs of 4 spaces
set expandtab " tabs to spaces
set smartindent " best effort indenting
set exrc " auto sources .vimrc in current folder if it exists
set guicursor= " use a block cursor
set rnu " relative line numbers on, set nornu to turn off
set nu " show current line number
set nohlsearch " remove highlights when done searching
set incsearch " highlight as you search
set hidden " keeps buffers in memory
set noerrorbells " less cowbell
set nowrap " dont wrap code
set noswapfile " dont like swap files
set nobackup " dont make backup files
set undodir=~/.vim/undodir
set undofile
set scrolloff=8 " leave an 8 line offset to the top and bottom when scrolling
set sidescrolloff=4 " leave 4 character offset to the sides when scrolling
set signcolumn=yes " add column to the left for linting feedback
set colorcolumn=80 " add column for 80 character max line length prompt
set updatetime=50 " makes vim a bit snappier
set shortmess+=c " dont pass messages to |ins-completion-menu|
set mouse=a " mouse even when running in tmux
set cmdheight=1
set linebreak " breaks lines at word boundaries
