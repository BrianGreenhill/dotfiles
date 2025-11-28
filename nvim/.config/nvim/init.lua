local vim = vim -- luacheck: ignore
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.nu = true
vim.opt.rnu = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.mouse = 'a'
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.signcolumn = 'yes'
vim.opt.inccommand = 'split'
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath 'data' .. '/undo'
vim.opt.undolevels = 1000
vim.opt.undoreload = 10000
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 5
vim.opt.wrap = false

-- Plugins
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)
require('lazy').setup {
  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.ai').setup { n_lines = 500 }
      require('mini.surround').setup()
      local statusline = require 'mini.statusline'
      statusline.setup {}
      statusline.section_location = function()
        return '%2l:%-2v'
      end
    end,
  },
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-cmdline',
    },
    config = function()
      local lspkind = require 'lspkind'
      local cmp = require 'cmp'
      cmp.setup {
        completion = {
          completeopt = 'menu,menuone,preview,noinsert',
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-y>'] = cmp.mapping.confirm { select = true },
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<C-space>'] = cmp.mapping.complete(),
        },
        formatting = {
          format = lspkind.cmp_format {
            maxwidth = 50,
            ellipsis_char = '...',
          },
        },
        sources = cmp.config.sources {
          { name = 'nvim_lsp' },
          { name = 'buffer', keyword_length = 3 },
          { name = 'path' },
        },
      }

      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources {
          { name = 'buffer' },
        },
      })

      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' },
        }, {
          {
            name = 'cmdline',
            option = {
              ignore_cmds = { 'Man', '!' },
            },
          },
        }),
      })
    end,
  },
  {
    'ibhagwan/fzf-lua',
    opts = {
      'max-perf',
      keymap = { fzf = { ['ctrl-q'] = 'select-all+accept' } },
      winopts = {
        preview = { hidden = true },
      },
      files = {
        fd_opts = [[--color=never --type f --hidden --follow --exclude .git --exclude vendor]],
      },
      grep = {
        rg_opts = [[--hidden --column --line-number --no-heading --color=always --smart-case --max-columns=4096 -g !.git/ -g !vendor -e ]],
      },
      register_ui_select = true,
    },
    config = function(_, opts)
      local fzflua = require 'fzf-lua'
      fzflua.setup(opts)
      vim.keymap.set('n', '<leader>sf', fzflua.files, { desc = 'FZF: [S]earch [F]iles' })
      vim.keymap.set('n', '<leader>sh', fzflua.help_tags, { desc = 'FZF: [S]earch [H]elp' })
      vim.keymap.set('n', '<leader>s/', fzflua.live_grep_native, { desc = 'FZF: [S]earch [R]egex' })
      vim.keymap.set('n', '<leader>/', fzflua.lgrep_curbuf, { desc = 'FZF: [L]ocal [G]rep' })
      vim.keymap.set('n', '<leader>sq', fzflua.quickfix, { desc = 'FZF: [S]earch [Q]uickfix' })
      vim.keymap.set('n', '<leader><leader>', fzflua.live_grep_resume, { desc = 'FZF: [R]esume [S]earch' })
      vim.keymap.set('n', '<leader>sb', fzflua.buffers, { desc = 'FZF: [S]earch [B]uffers' })
      vim.keymap.set('n', '<leader>sn', function()
        fzflua.files { cwd = vim.fn.stdpath 'config' }
      end, { desc = 'FZF: [S]earch [N]vim [C]onfig' })
      vim.keymap.set('n', '<leader>sd', function()
        fzflua.files { cwd = vim.env.HOME .. '/work/briangreenhill/dotfiles' }
      end, { desc = 'FZF: [S]earch [D]otfiles' })
      fzflua.register_ui_select()
    end,
  },
  {
    'williamboman/mason.nvim',
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
    },
    config = function()
      require('mason').setup()
      require('mason-lspconfig').setup {
        ensure_installed = {
          'gopls',
          'yamlls',
          'bashls',
          'lua_ls',
        },
        automatic_installation = true,
      }

      require('mason-tool-installer').setup {
        ensure_installed = {
          'stylua',
          'goimports',
        },
      }
    end,
  },
  {
    'hrsh7th/cmp-nvim-lsp',
    dependencies = { 'ibhagwan/fzf-lua' },
    config = function()
      local fzflua = require 'fzf-lua'

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = event.buf, desc = 'LSP: Hover' })
          vim.keymap.set('n', 'rn', vim.lsp.buf.rename, { buffer = event.buf, desc = 'LSP: [R]e[n]ame' })
          vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = event.buf, desc = 'LSP: [C]ode [A]ction' })
          vim.keymap.set('n', '<leader>dh', vim.diagnostic.open_float, { buffer = event.buf, desc = 'LSP: [D]iagnostic [H]elp' })
          vim.keymap.set('n', 'gd', fzflua.lsp_definitions, { desc = 'LSP: [G]oto [D]efinition' })
          vim.keymap.set('n', 'gr', fzflua.lsp_references, { desc = 'LSP: [G]oto [R]eferences' })
          vim.keymap.set('n', 'gi', fzflua.lsp_implementations, { desc = 'LSP: [G]oto [I]mplementations' })
        end,
      })

      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      vim.lsp.config.gopls = {
        cmd = { 'gopls' },
        filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
        root_markers = { 'go.work', 'go.mod', '.git' },
        capabilities = capabilities,
        settings = {
          gopls = {
            buildFlags = { '-tags=integration' },
          },
        },
      }

      vim.lsp.config.yamlls = {
        cmd = { 'yaml-language-server', '--stdio' },
        filetypes = { 'yaml', 'yaml.docker-compose', 'yaml.gitlab' },
        root_markers = { '.git' },
        capabilities = capabilities,
      }

      vim.lsp.config.bashls = {
        cmd = { 'bash-language-server', 'start' },
        filetypes = { 'sh', 'bash' },
        root_markers = { '.git' },
        capabilities = capabilities,
      }

      vim.lsp.config.lua_ls = {
        cmd = { 'lua-language-server' },
        filetypes = { 'lua' },
        root_markers = { '.luarc.json', '.luacheckrc', '.stylua.toml', 'stylua.toml', '.git' },
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = { version = 'LuaJIT' },
            workspace = {
              checkThirdParty = false,
              library = {
                '${3rd}/luv/library',
                unpack(vim.api.nvim_get_runtime_file('', true)),
              },
            },
            diagnostics = {
              globals = { 'vim' },
            },
            telemetry = { enable = false },
          },
        },
      }

      vim.lsp.enable 'gopls'
      vim.lsp.enable 'yamlls'
      vim.lsp.enable 'bashls'
      vim.lsp.enable 'lua_ls'
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    opts = {
      ensure_installed = { 'go', 'lua', 'yaml', 'bash', 'markdown' },
      auto_install = true,
      highlight = {
        enable = true,
      },
      indent = { enable = true },
    },
  },
  'onsails/lspkind.nvim',
  { 'rebelot/kanagawa.nvim', lazy = false, priority = 1000, opts = {
    theme = 'dragon',
    transparent = true,
  } },
  {
    'stevearc/conform.nvim',
    opts = {
      format_on_save = {
        async = false,
        timeout_ms = 5000,
        lsp_format = 'fallback',
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        go = { 'gofmt', 'goimports' },
        ['*'] = { 'trim_whitespace', 'trim_newlines' },
      },
    },
  },
  {
    'stevearc/oil.nvim',
    opts = {
      view_options = {
        show_hidden = true,
      },
    },
    lazy = false,
  },
  'tpope/vim-fugitive',
  {
    'github/copilot.vim',
    config = function()
      vim.keymap.set('i', '<C-j>', 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false })
      vim.g.copilot_no_tab_map = true
    end,
  },
  'tpope/vim-sleuth',
}

vim.cmd.colorscheme 'kanagawa'
vim.o.background = 'dark'
vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'none' })
vim.api.nvim_set_hl(0, 'LineNr', { bg = 'none' })

vim.keymap.set('n', '<leader>w', '<cmd>:w<cr>', { desc = '[W]rite' })
vim.keymap.set('n', '<leader>q', '<cmd>:q<cr>', { desc = '[Q]uit' })
vim.keymap.set('v', '<leader>y', '"+y')
vim.keymap.set('n', '<leader>Y', '"+Y', { noremap = false })
vim.keymap.set('n', '<leader>gs', '<cmd>:G<cr>')
vim.keymap.set('n', '-', '<cmd>:Oil<cr>', { desc = '[O]il' })
