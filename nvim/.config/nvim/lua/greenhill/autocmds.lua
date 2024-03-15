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
