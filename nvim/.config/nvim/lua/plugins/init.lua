vim.cmd [[
  call plug#begin('~/.config/nvim/plugged')

  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
  Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
  Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
  Plug 'nvim-lua/plenary.nvim'
  Plug 'rose-pine/neovim', {'as': 'rose-pine'}
  Plug 'neovim/nvim-lspconfig'
  Plug 'williamboman/mason.nvim'
  Plug 'williamboman/mason-lspconfig.nvim'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'zbirenbaum/copilot.lua'
  Plug 'windwp/nvim-autopairs'
  Plug 'nvim-lualine/lualine.nvim'
  Plug 'tpope/vim-fugitive'
  Plug 'ray-x/lsp_signature.nvim'

  call plug#end()
]]

require("plugins.telescope")
require("plugins.git")
require("plugins.colorscheme")
require("plugins.lsp")
require("plugins.completion")
require("plugins.copilot")
require("plugins.treesitter")
require("plugins.statusline")
