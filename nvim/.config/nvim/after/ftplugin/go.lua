local set = vim.opt_local
set.expandtab = false
set.tabstop = 4
set.shiftwidth = 4

vim.keymap.set('n', '<leader>td', function()
    require('dap-go').debug_test()
end, { buffer = 0 })
