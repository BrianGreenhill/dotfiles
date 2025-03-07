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

local set = vim.keymap.set
set('n', '<leader>w', '<cmd>:w<cr>', { desc = '[W]rite' })
set('n', '<leader>q', '<cmd>:q<cr>', { desc = '[Q]uit' })
set('v', '<leader>y', '"+y')
set('n', '<leader>Y', '"+Y', { noremap = false })

local Plug = vim.fn['plug#']
vim.call 'plug#begin'
Plug 'folke/which-key.nvim'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug('ibhagwan/fzf-lua', { branch = 'main' })
Plug 'lewis6991/gitsigns.nvim'
Plug 'leoluz/nvim-dap-go'
Plug 'mbbill/undotree'
Plug 'mfussenegger/nvim-dap'
Plug 'mfussenegger/nvim-lint'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-neotest/nvim-nio'
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'onsails/lspkind.nvim'
Plug 'ray-x/lsp_signature.nvim'
Plug 'rcarriga/nvim-dap-ui'
Plug 'rebelot/kanagawa.nvim'
Plug 'stevearc/conform.nvim'
Plug 'stevearc/oil.nvim'
Plug('ThePrimeagen/harpoon', { branch = 'harpoon2' })
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rhubarb'
Plug 'windwp/nvim-autopairs'
Plug 'williamboman/mason.nvim'
Plug 'zbirenbaum/copilot.lua'
vim.call 'plug#end'

require('kanagawa').setup {
  theme = 'dragon',
  transparent = true,
}
vim.cmd.colorscheme 'kanagawa'
vim.o.background = 'dark'
vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'none' })
vim.api.nvim_set_hl(0, 'LineNr', { bg = 'none' })
set('n', '<leader>gs', '<cmd>:G<cr>')
require('gitsigns').setup {
  on_attach = function(bufnr)
    local gitsigns = require 'gitsigns'
    set('n', '<leader>hs', gitsigns.stage_hunk, { buffer = bufnr, desc = 'Git [H]unk: [S]tage' })
    set('n', '<leader>hu', gitsigns.undo_stage_hunk, { buffer = bufnr, desc = 'Git [H]unk: [U]ndo [S]tage' })
    set('v', '<leader>hr', gitsigns.reset_hunk, { buffer = bufnr, desc = 'Git [H]unk: [R]eset [H]unk' })
    set('n', '<leader>hp', gitsigns.preview_hunk, { buffer = bufnr, desc = 'Git [H]unk: [P]review' })
    set('n', '<leader>hb', gitsigns.blame_line, { buffer = bufnr, desc = 'Git [H]unk: [B]lame' })
    set('n', '<leader>hd', gitsigns.diffthis, { buffer = bufnr, desc = 'Git [H]unk: [D]iff this' })
  end,
}
require('oil').setup()
set('n', '-', '<cmd>:Oil<cr>', { desc = '[O]il' })
require('which-key').setup()
local wk = require 'which-key'
wk.add {
  { '<leader>c', group = '[C]ode' },
  { '<leader>f', group = '[F]iles' },
  { '<leader>s', group = '[S]earch' },
  { '<leader>g', group = '[G]it' },
  { '<leader>h', group = 'Git [H]unks' },
}

-- fzf-lua setup
local fzflua = require 'fzf-lua'
fzflua.setup {
  'max-perf',
  keymap = { fzf = { ['ctrl-q'] = 'select-all+accept' } }, -- send all results to quickfix
  winopts = {
    preview = { hidden = 'hidden' },
  },
  files = {
    fd_opts = [[--color=never --type f --hidden --follow --exclude .git --exclude vendor]],
  },
  grep = {
    rg_opts = [[--hidden --column --line-number --no-heading --color=always --smart-case --max-columns=4096 -g !.git/ -g !vendor -e ]], -- luacheck: ignore
  },
  register_ui_select = true,
}
set('n', '<leader>sf', fzflua.files, { desc = 'FZF: [S]earch [F]iles' })
set('n', '<leader>sh', fzflua.help_tags, { desc = 'FZF: [S]earch [H]elp' })
set('n', '<leader>s/', fzflua.live_grep_native, { desc = 'FZF: [S]earch [R]egex' })
set('n', '<leader>/', fzflua.lgrep_curbuf, { desc = 'FZF: [L]ocal [G]rep' })
set('n', '<leader>sq', fzflua.quickfix, { desc = 'FZF: [S]earch [Q]uickfix' })
set('n', '<leader><leader>', fzflua.live_grep_resume, { desc = 'FZF: [R]esume [S]earch' })
set('n', '<leader>sn', function()
  fzflua.files { cwd = vim.fn.stdpath 'config' }
end, { desc = 'FZF: [S]earch [N]vim [C]onfig' })
set('n', '<leader>sd', function()
  fzflua.files { cwd = vim.env.HOME .. '/work/briangreenhill/dotfiles' }
end, { desc = 'FZF: [S]earch [D]otfiles' })
set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = '[U]ndo tree' })

local harpoon = require 'harpoon'
harpoon:setup()
set('n', '<leader>fa', function()
  harpoon:list():add()
end, { desc = 'Harpoon: [A]dd' })
set('n', '<leader>ft', function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = 'Harpoon: [T]oggle' })

require('copilot').setup {
  suggestion = {
    auto_trigger = true,
    keymap = { accept = '<C-j>' },
  },
  filetypes = {
    yaml = true,
    markdown = true,
  },
}

require('nvim-autopairs').setup {}

-- lsp and treesitter
require('nvim-treesitter.configs').setup {}
require('mason').setup()
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require 'lspconfig'
local opts = { capabilities = capabilities }
lspconfig.gopls.setup(opts)
lspconfig.yamlls.setup(opts)
lspconfig.bashls.setup(opts)
local lspkind = require 'lspkind'
local cmp = require 'cmp'
cmp.setup {
  completion = {
    completeopt = 'menu,menuone,preview,noinsert',
  },
  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-y>'] = cmp.mapping.confirm { select = false },
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

local fzfdefault = { jump_to_single_result = true }

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(event)
    require('lsp_signature').on_attach()
    set('n', 'rn', vim.lsp.buf.rename, { buffer = event.buf, desc = 'LSP: [R]e[n]ame' })
    set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = event.buf, desc = 'LSP: [C]ode [A]ction' })
    set('n', '<leader>dh', vim.diagnostic.open_float, { buffer = event.buf, desc = 'LSP: [D]iagnostic [H]elp' })
    set('n', 'gd', function()
      fzflua.lsp_definitions(fzfdefault)
    end, { desc = 'LSP: [G]oto [D]efinition' })
    set('n', 'gr', function()
      fzflua.lsp_references(fzfdefault)
    end, { desc = 'LSP: [G]oto [R]eferences' })
    set('n', 'gi', function()
      fzflua.lsp_implementations(fzfdefault)
    end, { desc = 'LSP: [G]oto [I]mplementations' })
  end,
})

require('conform').setup {
  format_on_save = {
    async = false,
    timeout_ms = 5000,
    lsp_format = 'fallback',
  },
  formatters_by_ft = {
    lua = { 'stylua' },
    go = { 'gofmt', 'goimports' },
    python = { 'isort', 'black' },
    ruby = { 'rubocop' },
  },
}
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

require('dapui').setup()
require('dap-go').setup()
local dap = require 'dap'
local ui = require 'dapui'
set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'DAP: [D]ebug [B]reakpoint' })
set('n', '<F5>', dap.continue, { desc = 'DAP: [C]ontinue F5' })
set('n', '<F6>', dap.step_over, { desc = 'DAP: [S]tep [O]ver F6' })
set('n', '<F7>', dap.step_into, { desc = 'DAP: [S]tep [I]nto F7' })
set('n', '<F8>', dap.step_out, { desc = 'DAP: [S]tep [O]ut F8' })
set('n', '<F9>', dap.step_back, { desc = 'DAP: [S]tep [B]ack F9' })
set('n', '<F10>', dap.restart, { desc = 'DAP: [R]estart, F10' })

local open = function()
  ui.open()
end
dap.listeners.before.attach.dapui_config = open
dap.listeners.before.launch.dapui_config = open
dap.listeners.before.event_terminated.dapui_config = open
dap.listeners.before.event_exited.dapui_config = open
