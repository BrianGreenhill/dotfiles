local nnoremap = require("greenhill.keymap").nnoremap
local vnoremap = require("greenhill.keymap").vnoremap

vnoremap("<leader>rr", "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>")
nnoremap("<C-n>", ":Ex<CR>")
nnoremap("<leader>ps", ":lua require('telescope.builtin').grep_string({search = vim.fn.input(\"Grep for > \")})<CR>")
nnoremap("<C-p>", ":lua require('telescope.builtin').git_files()<CR>")
nnoremap("<C-b>", ":lua require('telescope.builtin').buffers()<CR>")
nnoremap("<leader>pw", ":lua require('telescope.builtin').grep_string({ search = vim.fn.expand('<cword>') })<CR>")
nnoremap("<leader>pl", ":lua require('telescope.builtin').live_grep()<CR>")
nnoremap("<leader>vs", ":lua require('telescope.builtin').lsp_document_symbols()<CR>")
nnoremap("<leader>vb", ":lua require('telescope.builtin').builtin()<CR>")
nnoremap("<leader>gr", ":lua require('telescope.builtin').lsp_references()<CR>")
nnoremap("<leader>ed", ":lua require('greenhill.telescope').search_dotfiles()<CR>")
nnoremap("<leader>gc", ":lua require('greenhill.telescope').delete_branches()<CR>")
nnoremap("<Leader>pf", ":lua require('telescope.builtin').find_files()<CR>")
nnoremap("<leader>vh", ":lua require('telescope.builtin').help_tags()<CR>")
