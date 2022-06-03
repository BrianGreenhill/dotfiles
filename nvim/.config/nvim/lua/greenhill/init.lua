require ("greenhill.telescope")
require ("greenhill.lsp")
require ("greenhill.refactoring")
require('lualine').setup({theme='gruvbox'})
require('zen-mode').setup({
  window = {
    width=80,
    options = {
      signcolumn = "no",
      number = false,
      relativenumber = false,
    },
  }
})
