local options = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<leader>gs', ':G<CR>', options)
vim.api.nvim_set_keymap('n', '<leader>gc', ':G commit<CR>', options)
vim.api.nvim_set_keymap('n', '<leader>gp', ':G push<CR>', options)
