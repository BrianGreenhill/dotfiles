local prettier = { 'prettier', 'prettierd' }
require('conform').setup({
  formatters_by_ft = {
    javascript      = { prettier },
    typescript      = { prettier },
    javascriptreact = { prettier },
    typescriptreact = { prettier },
    css             = { prettier },
    html            = { prettier },
    json            = { prettier },
    jsonc           = { prettier },
    yaml            = { prettier },
    markdown        = { prettier, 'injected' },
    graphql         = { prettier },
    lua             = { 'stylua' },
    go              = { 'goimports', 'gofmt' },
    sh              = { 'shfmt' },
    python          = { 'ruff' },
    ruby            = { 'rufo' },
    ['_']           = { 'trim_whitespace', 'trim_newlines' },
  },
  formatters = {
    injected = {
      options = {
        lang_to_formatters = {
          html = {},
        }
      }
    },
    shfmt = {
      prepend_args = { '-i', '2' }
    },
    prettierd = {
      range_args = false,
    }
  },
  format_after_save = function(bufnr)
    if vim.b[bufnr].disable_autoformat then
      return false
    end
    return { timeout_ms = 5000, lsp_format = 'fallback' }
  end,
})
vim.o.formatexpr = 'v:lua.require("conform").formatexpr()'
