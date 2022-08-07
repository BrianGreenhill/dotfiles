local nnoremap = require("greenhill.keymap").nnoremap

nnoremap("<leader>zo", function()
	vim.opt.wrap = true
	vim.opt.linebreak = true
	vim.opt.signcolumn = "no"
	vim.opt.colorcolumn = "800"
	vim.cmd(":ZenMode")
end)

nnoremap("<leader>ze", function()
	vim.cmd(":ZenMode")
	vim.opt.wrap = false
	vim.opt.linebreak = false
	vim.opt.signcolumn = "yes"
	vim.opt.colorcolumn = "80"
end)
