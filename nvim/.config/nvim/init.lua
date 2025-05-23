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
    '--branch=stable', -- latest stable release
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
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
      delay = 10,
      spec = {
        { '<leader>c', group = '[C]ode' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>g', group = '[G]it' },
        { '<leader>h', group = 'Git [H]unks' },
      },
    },
  },
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        build = 'make install_jsregexp',
        dependencies = {
          'rafamadriz/friendly-snippets',
          config = function()
            require('luasnip.loaders.from_vscode').lazy_load()
          end,
        },
      },
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lsp-signature-help',
    },
    config = function()
      local lspkind = require 'lspkind'
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {}
      cmp.setup {
        completion = {
          completeopt = 'menu,menuone,preview,noinsert',
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-y>'] = cmp.mapping.confirm { select = true },
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<C-space>'] = cmp.mapping.complete(),
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),
        },
        formatting = {
          format = lspkind.cmp_format {
            maxwidth = 50,
            ellipsis_char = '...',
          },
        },
        sources = cmp.config.sources {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer', keyword_length = 3 },
          { name = 'path' },
          { name = 'nvim_lsp_signature_help' },
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
    'lewis6991/gitsigns.nvim',
    opts = {
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'
        vim.keymap.set('n', '<leader>hs', gitsigns.stage_hunk, { buffer = bufnr, desc = 'Git [H]unk: [S]tage' })
        vim.keymap.set('n', '<leader>hu', gitsigns.undo_stage_hunk, { buffer = bufnr, desc = 'Git [H]unk: [U]ndo [S]tage' }) -- luacheck: ignore
        vim.keymap.set('v', '<leader>hr', gitsigns.reset_hunk, { buffer = bufnr, desc = 'Git [H]unk: [R]eset [H]unk' })
        vim.keymap.set('n', '<leader>hp', gitsigns.preview_hunk, { buffer = bufnr, desc = 'Git [H]unk: [P]review' })
        vim.keymap.set('n', '<leader>hb', gitsigns.blame_line, { buffer = bufnr, desc = 'Git [H]unk: [B]lame' })
        vim.keymap.set('n', '<leader>hd', gitsigns.diffthis, { buffer = bufnr, desc = 'Git [H]unk: [D]iff this' })
      end,
    },
  },
  {
    'mbbill/undotree',
    config = function()
      vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = '[U]ndo tree' })
    end,
  },
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'leoluz/nvim-dap-go',
      'nvim-neotest/nvim-nio',
      'rcarriga/nvim-dap-ui',
    },
    config = function()
      require('dapui').setup()
      require('dap-go').setup()
      local dap = require 'dap'
      local ui = require 'dapui'
      vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'DAP: [D]ebug [B]reakpoint' })
      vim.keymap.set('n', '<F5>', dap.continue, { desc = 'DAP: [C]ontinue F5' })
      vim.keymap.set('n', '<F6>', dap.step_over, { desc = 'DAP: [S]tep [O]ver F6' })
      vim.keymap.set('n', '<F7>', dap.step_into, { desc = 'DAP: [S]tep [I]nto F7' })
      vim.keymap.set('n', '<F8>', dap.step_out, { desc = 'DAP: [S]tep [O]ut F8' })
      vim.keymap.set('n', '<F9>', dap.step_back, { desc = 'DAP: [S]tep [B]ack F9' })
      vim.keymap.set('n', '<F10>', dap.restart, { desc = 'DAP: [R]estart, F10' })
      vim.keymap.set('n', '<leader>dt', require('dap-go').debug_test, { desc = 'DAP: [D]ebug [T]est' })

      local open = function()
        ui.open()
      end
      dap.listeners.before.attach.dapui_config = open
      dap.listeners.before.launch.dapui_config = open
      dap.listeners.before.event_terminated.dapui_config = open
      dap.listeners.before.event_exited.dapui_config = open
    end,
  },
  {
    'mfussenegger/nvim-lint',
    config = function()
      require('lint').linters_by_ft = {
        markdown = { 'cspell' },
        go = { 'golangcilint' },
        ruby = { 'rubocop' },
        lua = { 'luacheck' },
        python = { 'flake8' },
      }
      local lintaugroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
        group = lintaugroup,
        callback = function()
          require('lint').try_lint()
        end,
      })
    end,
  },
  {
    'ibhagwan/fzf-lua',
    opts = {
      'max-perf',
      keymap = { fzf = { ['ctrl-q'] = 'select-all+accept' } }, -- send all results to quickfix
      winopts = {
        preview = { hidden = true },
      },
      files = {
        fd_opts = [[--color=never --type f --hidden --follow --exclude .git --exclude vendor]],
      },
      grep = {
        rg_opts = [[--hidden --column --line-number --no-heading --color=always --smart-case --max-columns=4096 -g !.git/ -g !vendor -e ]], -- luacheck: ignore
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
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', opts = {} },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
      'hrsh7th/cmp-nvim-lsp',
      'ibhagwan/fzf-lua',
      'ray-x/lsp_signature.nvim',
    },
    config = function()
      local fzflua = require 'fzf-lua'

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          require('lsp_signature').on_attach()
          vim.keymap.set('n', 'rn', vim.lsp.buf.rename, { buffer = event.buf, desc = 'LSP: [R]e[n]ame' })
          vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = event.buf, desc = 'LSP: [C]ode [A]ction' }) -- luacheck: ignore
          vim.keymap.set('n', '<leader>dh', vim.diagnostic.open_float, { buffer = event.buf, desc = 'LSP: [D]iagnostic [H]elp' }) -- luacheck: ignore
          vim.keymap.set('n', 'gd', fzflua.lsp_definitions, { desc = 'LSP: [G]oto [D]efinition' })
          vim.keymap.set('n', 'gr', fzflua.lsp_references, { desc = 'LSP: [G]oto [R]eferences' })
          vim.keymap.set('n', 'gi', fzflua.lsp_implementations, { desc = 'LSP: [G]oto [I]mplementations' })
        end,
      })
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lspconfig = require 'lspconfig'
      local opts = { capabilities = capabilities }
      lspconfig.gopls.setup { capabilities = capabilities, settings = {
        gopls = {
          buildFlags = { '-tags=integration' },
        },
      } }
      lspconfig.yamlls.setup(opts)
      lspconfig.bashls.setup(opts)
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    opts = {
      ensure_installed = { 'go', 'lua', 'ruby', 'yaml', 'bash', 'c', 'diff', 'html', 'luadoc', 'vimdoc', 'vim', 'markdown', 'markdown_inline' }, -- luacheck: ignore
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
  },
  'nvim-treesitter/nvim-treesitter-context',
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
        html = { 'htmlbeautifier' },
        lua = { 'stylua' },
        go = { 'gofmt', 'goimports' },
        python = { 'isort', 'black' },
        ruby = { 'rubocop' },
        ['*'] = { 'trim_whitespace', 'remove_trailing_newlines' },
      },
    },
  },
  {
    'stevearc/oil.nvim',
    dependencies = {
      { 'echasnovski/mini.icons', opts = {} },
    },
    opts = {
      view_options = {
        show_hidden = true,
      },
    },
    lazy = false,
  },
  'tpope/vim-fugitive',
  'tpope/vim-rails',
  'tpope/vim-rhubarb',
  'tpope/vim-sleuth',
  { 'windwp/nvim-autopairs', opts = {} },
  {
    'github/copilot.vim',
    config = function()
      vim.keymap.set('i', '<C-j>', 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false })
      vim.g.copilot_no_tab_map = true
    end,
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    build = 'make tiktoken',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'github/copilot.vim',
    },
    opts = {},
  },
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
