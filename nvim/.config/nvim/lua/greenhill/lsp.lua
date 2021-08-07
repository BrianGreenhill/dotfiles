local system_name = "macOS"
local sumneko_root_path = '/Users/briangreenhill/Personal/lua-language-server'
local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true
  },
}

local function on_attach()
end

require'lspconfig'.gopls.setup {on_attach=on_attach}
require'lspconfig'.intelephense.setup {on_attach=on_attach}
require'lspconfig'.tsserver.setup {on_attach=on_attach}
require'lspconfig'.bashls.setup {on_attach=on_attach}
require'lspconfig'.yamlls.setup{on_attach=on_attach}
require'lspconfig'.solargraph.setup{
  on_attach=on_attach,
  settings = {
    solargraph = {
      diagnostics = {true}
    }
  }
}
require'lspconfig'.pylsp.setup{on_attach=on_attach}

require'lspconfig'.sumneko_lua.setup{
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
  on_attach=on_attach;
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        globals = {'vim'},
      },
      workspace = {
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
    },
  },
}
