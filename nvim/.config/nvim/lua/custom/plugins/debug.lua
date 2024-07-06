-- debug.lua
return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'leoluz/nvim-dap-go',
    'rcarriga/nvim-dap-ui',
    'theHamsta/nvim-dap-virtual-text',
    'nvim-neotest/nvim-nio',
    'williamboman/mason.nvim',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('dapui').setup()
    require('dap-go').setup()
    require('nvim-dap-virtual-text').setup()

    vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<F6>', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<F7>', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<F8>', dap.step_out, { desc = 'Debug: Step Out' })
    vim.keymap.set('n', '<F12>', dap.restart, { desc = 'Debug: Restart' })
    vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>gb', dap.run_to_cursor, { desc = 'Debug: Run to Cursor' })
    vim.keymap.set('n', '<leader>?', function()
      dapui.eval(nil, { enter = true })
    end, { desc = 'Debug: Inspect' })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close
  end,
}
