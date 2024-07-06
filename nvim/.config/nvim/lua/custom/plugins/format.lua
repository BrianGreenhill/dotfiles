--- stevearc/conform.nvim
--- https://github.com/stevearc/conform.nvim
return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '=',
      function()
        require('conform').format({ async = true, lsp_format = 'fallback' }, function(err)
          if not err then
            if vim.startswith(vim.api.nvim_get_mode().mode:lower(), 'v') then
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'v', true)
            end
          end
        end)
      end,
      mode = "",
      desc = "Format buffer",
    },
  },
  init = function() vim.o.formatexpr = 'v:lua.require("conform").formatexpr()' end,
  config = function()
    require 'custom.format'
  end,
}
