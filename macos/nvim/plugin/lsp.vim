set completeopt=menuone,noinsert,noselect

" use tab and shift-tab to navigate through completion menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
nnoremap <leader>gd :lua vim.lsp.buf.definition()<CR>
nnoremap <leader>gi :lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>sh :lua vim.lsp.buf.signature_help()<CR>
nnoremap <leader>rn :lua vim.lsp.buf.rename()<CR>
nnoremap <leader>vh :lua vim.lsp.buf.hover()<CR>
nnoremap <leader>vca :lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>vsd :lua vim.lsp.diagnostic.show_line_diagnostics()<CR>

let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
let g:completion_enable_snippet = 'UltiSnips'
let g:UltiSnipsExpandTrigger="<C-s>"

lua <<EOF
  local on_attach = function(client)
    require'completion'.on_attach(client)
  end
  require'lspconfig'.gopls.setup {on_attach=on_attach}
  require'lspconfig'.intelephense.setup {on_attach=on_attach}
  require'lspconfig'.tsserver.setup {on_attach=on_attach}
  require'lspconfig'.solargraph.setup{ on_attach=on_attach}
EOF
