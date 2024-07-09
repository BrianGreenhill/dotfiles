vim.g.mapleader = ' '      -- set leader to space
vim.g.maplocalleader = ' ' -- set local leader to space

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- Set up lazy, and load my `lua/custom/plugins/` folder
require('lazy').setup({ import = 'custom/plugins' }, {
  change_detection = {
    notify = false,
  },
})
