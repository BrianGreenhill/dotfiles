vim.keymap.set("n", "<leader>po", function()
	vim.opt.rnu = false
	vim.opt.signcolumn = "no"
	vim.opt.colorcolumn = "800"
end)


vim.keymap.set("n", "<leader>pe", function()
	vim.opt.rnu = true
	vim.opt.signcolumn = "yes"
	vim.opt.colorcolumn = "80"
end)
