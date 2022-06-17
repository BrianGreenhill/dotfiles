-- sets
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.guicursor = ""
vim.opt.rnu = true
vim.opt.nu = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.hidden = true
vim.opt.errorbells = false
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"
vim.opt.updatetime = 50
vim.opt.shortmess:append("c")
vim.opt.mouse = "a"
vim.opt.cmdheight = 1
vim.opt.linebreak = true
vim.opt.winbar = "%=%m\\ %f"
vim.opt.termguicolors = true
vim.opt.listchars = { eol = "↲", tab = "▸ ", trail = "·" }
vim.o.completeopt = "menuone,noinsert,noselect"

-- set leader
vim.g.mapleader = " "

-- netrw
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

-- gruvbox
vim.opt.background = "dark"
vim.g.gruvbox_contrast_dark = "hard"
vim.cmd("colorscheme gruvbox")

-- highlight column
local hl = function(val, settings)
	vim.api.nvim_set_hl(0, val, settings)
end

hl("SignColumn", { bg = "none" })
hl("ColorColumn", { ctermbg = 0, bg = "#555555" })
hl("Normal", { bg = "none" })
hl("CursorLineNr", { bg = "none" })
hl("LineNr", { fg = "#5eacd3" })
hl("netrwDir", { fg = "#5eacd3" })
