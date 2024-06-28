vim.cmd [[
  call plug#begin('~/.config/nvim/plugged')

  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
  Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
  Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'rose-pine/neovim', {'as': 'rose-pine'}
  Plug 'neovim/nvim-lspconfig'
  Plug 'williamboman/mason.nvim'
  Plug 'williamboman/mason-lspconfig.nvim'
  Plug 'stevearc/conform.nvim'
  Plug 'ray-x/lsp_signature.nvim'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-nvim-lua'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'saadparwaiz1/cmp_luasnip'
  Plug 'L3MON4D3/LuaSnip'
  Plug 'nvim-tree/nvim-web-devicons'
  Plug 'bluz71/nvim-linefly'
  Plug 'zbirenbaum/copilot.lua'
  Plug 'CopilotC-Nvim/CopilotChat.nvim', { 'branch': 'canary' }
  Plug 'folke/trouble.nvim'
  Plug 'windwp/nvim-autopairs'

  call plug#end()
]]

require("plugins.movement")
require("plugins.git")
require("plugins.colorscheme")
require("plugins.lsp")
require("plugins.completion")
require("plugins.copilot")
require("plugins.treesitter")
require("plugins.trouble")
