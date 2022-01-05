local system_name = "macOS"
local sumneko_root_path = '/Users/briangreenhill/Personal/lua-language-server'
local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"

-- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup({
    snippet = {
        expand = function(args)
          vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping = {
      ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
      ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
      ['<C-u>'] = cmp.mapping.scroll_docs(-4),
      ['<C-d>'] = cmp.mapping.scroll_docs(4),
      ['<CR>'] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      }),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' })
    },
    sources = {
      { name = 'vsnip' },
      { name = 'nvim_lsp' },
      { name = 'buffer' },
    }
})

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true
  },
}

local function config(_config)
  return vim.tbl_deep_extend('force', {
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  }, _config or {})
end

require'lspconfig'.rust_analyzer.setup(config())
require'lspconfig'.gopls.setup(config())
require'lspconfig'.intelephense.setup(config())
require'lspconfig'.tsserver.setup(config())
require'lspconfig'.bashls.setup(config())
require'lspconfig'.svelte.setup(config())
require'lspconfig'.yamlls.setup(config())
require'lspconfig'.solargraph.setup(config({
  on_attach=config,
  settings = {
    solargraph = {
      diagnostics = {true}
    }
  }
}))
require'lspconfig'.pylsp.setup(config())

require'lspconfig'.sumneko_lua.setup(config({
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
  on_attach=config;
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
}))
