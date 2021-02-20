local prettierConfig = function()
  return {
    exe = "prettier",
    args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0), "--single-quote"},
    stdin = true
  }
end

local formatter_goimports = function()
  return {
    exe = "goimports",
    args = {"-srcdir", vim.api.nvim_buf_get_name(0)},
    stdin = true
  }
end

require('formatter').setup({
  logging = true,
  filetype = {
    javascript = {prettierConfig},
    javascriptreact = {prettierConfig},
    typescriptreact = {prettierConfig},
    typescript = {prettierConfig},
    ts = {prettierConfig},
    json = {prettierConfig},
    go = {formatter_goimports}
  }
})

vim.api.nvim_exec([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.js,*.jsx,*.ts,*.json,*.tsx,*.go FormatWrite
augroup END
]], true)
