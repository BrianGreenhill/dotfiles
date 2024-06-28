vim.fn['plug#']('tpope/vim-fugitive')

local map = vim.api.nvim_set_keymap
local options = { noremap = true, silent = true }

map('n', '<leader>gs', ':G<CR>', options)
map('n', '<leader>gc', ':G commit<CR>', options)
map('n', '<leader>gp', ':G push<CR>', options)
