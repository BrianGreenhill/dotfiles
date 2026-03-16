local vim = vim -- luacheck: ignore
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.number = true
vim.opt.relativenumber = true
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
vim.opt.updatetime = 250
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.diagnostic.config {
  virtual_text = { spacing = 4, prefix = '●' },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = { border = 'rounded', source = true },
}

-- Auto-install plugins on first launch
local pack_dir = vim.fn.stdpath 'data' .. '/site/pack/plugins/start'
if vim.fn.isdirectory(pack_dir) == 0 then
  local script = vim.fn.stdpath 'config' .. '/plugins.sh'
  vim.fn.system { 'bash', script }
  vim.cmd 'packloadall'
end

-- Colorscheme
require('kanagawa').setup { theme = 'dragon', transparent = true }
vim.cmd.colorscheme 'kanagawa'
vim.o.background = 'dark'
vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'none' })
vim.api.nvim_set_hl(0, 'LineNr', { bg = 'none' })

-- mini.nvim
require('mini.ai').setup { n_lines = 500 }
require('mini.surround').setup()
local statusline = require 'mini.statusline'
statusline.setup {}
statusline.section_location = function()
  return '%2l:%-2v'
end

-- Completion (blink.cmp)
require('blink.cmp').setup {
  keymap = {
    preset = 'default',
    ['<C-y>'] = { 'select_and_accept' },
    ['<C-space>'] = { 'show' },
  },
  completion = {
    documentation = { auto_show = true, auto_show_delay_ms = 200 },
    list = { selection = { preselect = true, auto_insert = false } },
    menu = { auto_show = true },
  },
  cmdline = { enabled = true },
  sources = {
    default = { 'lsp', 'path', 'buffer' },
  },
}

-- Fuzzy finder (fzf-lua)
local fzflua = require 'fzf-lua'
fzflua.setup {
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
}
fzflua.register_ui_select()

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

-- Mason (tool installer)
require('mason').setup()
require('mason-tool-installer').setup {
  ensure_installed = {
    'gopls',
    'yaml-language-server',
    'bash-language-server',
    'lua-language-server',
    'stylua',
    'goimports',
  },
}

-- LSP
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(event)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = event.buf, desc = 'LSP: Hover' })
    vim.keymap.set('n', 'rn', vim.lsp.buf.rename, { buffer = event.buf, desc = 'LSP: [R]e[n]ame' })
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = event.buf, desc = 'LSP: [C]ode [A]ction' })
    vim.keymap.set('n', '<leader>dh', vim.diagnostic.open_float, { buffer = event.buf, desc = 'LSP: [D]iagnostic [H]elp' })
    vim.keymap.set('n', 'gd', fzflua.lsp_definitions, { buffer = event.buf, desc = 'LSP: [G]oto [D]efinition' })
    vim.keymap.set('n', 'gr', fzflua.lsp_references, { buffer = event.buf, desc = 'LSP: [G]oto [R]eferences' })
    vim.keymap.set('n', 'gi', fzflua.lsp_implementations, { buffer = event.buf, desc = 'LSP: [G]oto [I]mplementations' })
  end,
})

vim.lsp.config('gopls', {
  cmd = { 'gopls' },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
  root_markers = { 'go.work', 'go.mod', '.git' },
  settings = {
    gopls = {
      buildFlags = { '-tags=integration' },
    },
  },
})

vim.lsp.config('yamlls', {
  cmd = { 'yaml-language-server', '--stdio' },
  filetypes = { 'yaml', 'yaml.docker-compose', 'yaml.gitlab' },
  root_markers = { '.git' },
})

vim.lsp.config('bashls', {
  cmd = { 'bash-language-server', 'start' },
  filetypes = { 'sh', 'bash' },
  root_markers = { '.git' },
})

vim.lsp.config('lua_ls', {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { '.luarc.json', '.luacheckrc', '.stylua.toml', 'stylua.toml', '.git' },
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
})

vim.lsp.enable { 'gopls', 'yamlls', 'bashls', 'lua_ls' }

-- Treesitter
require('nvim-treesitter.config').setup {
  ensure_installed = { 'go', 'lua', 'yaml', 'bash', 'markdown' },
  auto_install = true,
  highlight = { enable = true, additional_vim_regex_highlighting = false },
  indent = { enable = true },
}

-- Formatting (conform.nvim)
require('conform').setup {
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
}

-- File browser (oil.nvim)
require('oil').setup {
  view_options = {
    show_hidden = true,
  },
}

-- Copilot
vim.keymap.set('i', '<C-j>', 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false })
vim.g.copilot_no_tab_map = true

-- Keymaps
vim.keymap.set('n', '<leader>w', '<cmd>w<cr>', { desc = '[W]rite' })
vim.keymap.set('n', '<leader>q', '<cmd>q<cr>', { desc = '[Q]uit' })
vim.keymap.set('v', '<leader>y', '"+y', { desc = '[Y]ank to clipboard' })
vim.keymap.set('n', '<leader>Y', '"+Y', { noremap = false, desc = '[Y]ank line to clipboard' })
vim.keymap.set('n', '<leader>gs', '<cmd>G<cr>', { desc = 'Git: [G]it [S]tatus' })
vim.keymap.set('n', '-', '<cmd>Oil<cr>', { desc = 'Oil: File browser' })
