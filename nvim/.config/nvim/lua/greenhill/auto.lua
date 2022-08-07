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

-- local dapui_group = augroup("dapui_group", { clear = true })
-- autocmd("dapui_no_status", {
-- 	group = dapui_group,
-- 	pattern = "dapui*",
-- 	callback = function()
-- 		vim.set.statusline = "\\"
-- 	end,
-- })
-- autocmd("dap_repl_no_status", {
-- 	group = dapui_group,
-- 	pattern = "dap-repl",
-- 	callback = function()
-- 		vim.set.statusline = "\\"
-- 	end,
-- })
