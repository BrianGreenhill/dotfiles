nnoremap <leader>ps :lua require('telescope.builtin').grep_string({search = vim.fn.input("Grep for > ")})<CR>
nnoremap <C-p> :lua require('telescope.builtin').git_files()<CR>
nnoremap <Leader>pf :lua require('telescope.builtin').find_files { find_command = { 'rg', '--no-ignore', '--files', } }<CR>
nnoremap <leader>pw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
nnoremap <leader>fs :lua require('telescope.builtin').current_buffer_fuzzy_find { }<CR>
nnoremap <leader>vs :lua require('telescope.builtin').lsp_document_symbols()<CR>
nnoremap <leader>vS :lua require('telescope.builtin').lsp_workspace_symbols({query = vim.fn.input("Search symbols for > ")})<CR>
nnoremap <leader>vb :lua require('telescope.builtin').builtin()<CR>
nnoremap <leader>gr :lua require('telescope.builtin').lsp_references()<CR>
nnoremap <leader>vrc :lua require('greenhill.telescope').search_dotfiles()<CR>
nnoremap <leader>gc :lua require('greenhill.telescope').delete_branches()<CR>
