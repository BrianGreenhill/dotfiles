inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
nnoremap <leader>gd :lua vim.lsp.buf.definition()<CR>
nnoremap <leader>pd :lua require'lspsaga.provider'.preview_definition()<CR>
nnoremap <leader>gi :lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>sh :lua require('lspsaga.signaturehelp').signature_help()<CR>
nnoremap <leader>rn :lua require('lspsaga.rename').rename()<CR>
nnoremap <leader>vh :lua vim.lsp.buf.hover()<CR>
nnoremap <leader>vca :lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>vsd :lua vim.diagnostic.open_float(0, {scope="line"})<CR>
nnoremap <leader>L :lua vim.diagnostic.goto_prev()<CR>
nnoremap <leader>l :lua vim.diagnostic.goto_next()<CR>

let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
