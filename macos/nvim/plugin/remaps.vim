" general
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <C-n> :NERDTreeToggle<CR>

" lsp
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
nnoremap <leader>gd :lua vim.lsp.buf.definition()<CR>
nnoremap <leader>gi :lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>sh :lua vim.lsp.buf.signature_help()<CR>
nnoremap <leader>rn :lua vim.lsp.buf.rename()<CR>
nnoremap <leader>vh :lua vim.lsp.buf.hover()<CR>
nnoremap <leader>vca :lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>vsd :lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
nnoremap <leader>ps :lua require('telescope.builtin').grep_string({search = vim.fn.input("Grep for > ")})<CR>

" telescope
nnoremap <C-p> :lua require('telescope.builtin').git_files()<CR>
nnoremap <Leader>pf :lua require('telescope.builtin').find_files { find_command = { 'rg', '--no-ignore', '--files', } }<CR>
nnoremap <leader>pw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
nnoremap <leader>fs :lua require('telescope.builtin').current_buffer_fuzzy_find { }<CR>
nnoremap <leader>vs :lua require('telescope.builtin').lsp_document_symbols()<CR>
nnoremap <leader>vS :lua require('telescope.builtin').lsp_workspace_symbols({query = vim.fn.input("Search symbols for > ")})<CR>
nnoremap <leader>vb :lua require('telescope.builtin').builtin()<CR>
nnoremap <leader>gr :lua require('telescope.builtin').lsp_references()<CR>
