set completeopt=menuone,noinsert,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
let g:completion_enable_snippet = 'UltiSnips'
let g:UltiSnipsExpandTrigger="<C-s>"

" use tab and shift-tab to navigate through completion menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

nnoremap <leader>gd :lua vim.lsp.buf.definition()<CR>
nnoremap <leader>gi :lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>gr :lua vim.lsp.buf.references()<CR>
nnoremap <leader>sh :lua vim.lsp.buf.signature_help()<CR>
nnoremap <leader>rn :lua vim.lsp.buf.rename()<CR>
nnoremap <leader>vh :lua vim.lsp.buf.hover()<CR>
nnoremap <leader>vca :lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>vsd :lua vim.lsp.diagnostic.show_line_diagnostics()<CR>

autocmd FileType go setlocal omnifunc=v:lua.vim.lsp.omnifunc

lua <<EOF
-- go
  lspconfig = require "lspconfig"

  lspconfig.gopls.setup {
    on_attach = require'completion'.on_attach,
    cmd = {"gopls", "serve"},
    filetypes = {"go"},
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
          unreachable = true,
        },
        usePlaceholders = true,
        completeUnimported = true,
        deepCompletion = true,
        staticcheck = true,
      },
    },
  }

-- php
  lspconfig.intelephense.setup {
    settings = {
      stubs = {"wordpress"}
    },
    on_attach=require'completion'.on_attach
  }

-- typescript
  lspconfig.tsserver.setup {
    on_attach = require'completion'.on_attach,
    cmd = {"typescript-language-server", "--stdio"},
    filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx"
    },
    root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git")
  }

-- ruby
  lspconfig.solargraph.setup{ on_attach=require'completion'.on_attach }
EOF

