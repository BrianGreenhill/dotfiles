local Remap = require("greenhill.keymap")
local nnoremap = Remap.nnoremap
local inoremap = Remap.inoremap

nnoremap("<leader>gd", ":lua vim.lsp.buf.definition()<CR>")
nnoremap("<leader>gi", ":lua vim.lsp.buf.implementation()<CR>")
nnoremap("<leader>sh", ":lua vim.lsp.buf.signature_help()<CR>")
nnoremap("<leader>rn", ":lua vim.lsp.buf.rename()<CR>")
nnoremap("<leader>vh", ":lua vim.lsp.buf.hover()<CR>")
nnoremap("<leader>vf", ":lua vim.lsp.buf.format({ async = true })<CR>")
nnoremap("<leader>vd", ":lua vim.lsp.buf.type_definition()<CR>")
nnoremap("<leader>vca", ":lua vim.lsp.buf.code_action()<CR>")
nnoremap("<leader>vsd", ":lua vim.diagnostic.open_float(0, {scope='line'})<CR>")
nnoremap("<leader>L", ":lua vim.diagnostic.goto_prev()<CR>")
nnoremap("<leader>l", ":lua vim.diagnostic.goto_next()<CR>")
inoremap("<Tab>", 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', { expr = true })
inoremap("<S-Tab>", 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', { expr = true })
