vim.g.greenhill_colorscheme = "gruvbox"

vim.g.gruvbox_contrast_dark = "hard"
vim.g.tokyonight_transparent_sidebar = true
vim.g.tokyonight_transparent = true
vim.g.tokyonight_hide_inactive_statusline = true
vim.g.gruvbox_invert_selection = "0"
vim.opt.background = "dark"

vim.cmd("colorscheme " .. vim.g.greenhill_colorscheme)

local hl = function(val, settings)
	vim.api.nvim_set_hl(0, val, settings)
end

hl("SignColumn", { bg = "none" })
hl("ColorColumn", { ctermbg = 0, bg = "#555555" })
hl("Normal", { bg = "none" })
hl("CursorLineNr", { bg = "none" })
hl("LineNr", { fg = "#5eacd3" })
hl("netrwDir", { fg = "#5eacd3" })
