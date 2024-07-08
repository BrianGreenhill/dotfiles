require('oil').setup {
  columns = { 'icon' },
  view_options = {
    show_hidden = true,
  },
}

vim.keymap.set('n', '-', '<cmd>Oil<CR>', { desc = 'Open parent directory' })
vim.keymap.set('n', '<leader>-', require('oil').toggle_float)
