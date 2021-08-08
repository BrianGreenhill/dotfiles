nnoremap <leader>ps :lua require('telescope.builtin').grep_string({search = vim.fn.input("Grep for > ")})<CR>
nnoremap <C-p> :lua require('telescope.builtin').git_files()<CR>
nnoremap <C-b> :lua require('telescope.builtin').buffers()<CR>
nnoremap <leader>pl :lua require('telescope.builtin').live_grep()<CR>
nnoremap <leader>fs :lua require('telescope.builtin').current_buffer_fuzzy_find { }<CR>
nnoremap <leader>vs :lua require('telescope.builtin').lsp_document_symbols()<CR>
nnoremap <leader>vS :lua require('telescope.builtin').lsp_workspace_symbols({query = vim.fn.input("Search symbols for > ")})<CR>
nnoremap <leader>vb :lua require('telescope.builtin').builtin()<CR>
nnoremap <leader>gr :lua require('telescope.builtin').lsp_references(require('telescope.themes').get_cursor({ previewer = false, layout_settings = { width = 500 }}))<CR>
nnoremap <leader>vrc :lua require('greenhill.telescope').search_dotfiles()<CR>
nnoremap <leader>gc :lua require('greenhill.telescope').delete_branches()<CR>
