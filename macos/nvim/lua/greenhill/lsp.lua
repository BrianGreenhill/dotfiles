require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true
  },
}

local on_attach = function(client)
  require'completion'.on_attach(client)
end
require'lspconfig'.gopls.setup {on_attach=on_attach}
require'lspconfig'.intelephense.setup {on_attach=on_attach}
require'lspconfig'.tsserver.setup {on_attach=on_attach}
require'lspconfig'.solargraph.setup{on_attach=on_attach}
require'lspconfig'.pyls.setup{on_attach=on_attach}

local system_name = "macOS"
local sumneko_root_path = '/Users/briangreenhill/Personal/lua-language-server'
local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"
require'lspconfig'.sumneko_lua.setup{
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
  on_attach=on_attach;
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
    },
  },
}
