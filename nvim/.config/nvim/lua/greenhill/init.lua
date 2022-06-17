require("greenhill.plugins")
require("greenhill.set")
require("greenhill.keymap")

require("nvim-autopairs").setup({})
require("lualine").setup({ theme = "gruvbox" })
require("fidget").setup({})
require("trouble").setup({})
require("zen-mode").setup({
	window = {
		width = 80,
		options = {
			signcolumn = "no",
			number = false,
			relativenumber = false,
		},
	},
})

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local yank_group = augroup("HighlightYank", {})
autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 40,
		})
	end,
})

local format_group = augroup("my_lsp_format", { clear = true })
autocmd("BufWritePre", {
	group = format_group,
	callback = function()
		vim.lsp.buf.format()
	end,
})
