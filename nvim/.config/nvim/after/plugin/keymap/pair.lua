local nnoremap = require("greenhill.keymap").nnoremap

nnoremap("<leader>po", function()
	vim.opt.rnu = false
	vim.opt.signcolumn = "no"
	vim.opt.colorcolumn = "800"
end)

nnoremap("<leader>pe", function()
	vim.opt.rnu = true
	vim.opt.signcolumn = "yes"
	vim.opt.colorcolumn = "80"
end)
