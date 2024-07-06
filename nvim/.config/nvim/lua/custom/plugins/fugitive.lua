-- vim-fugitive
-- https://github.com/tpope/vim-fugitive

return {
	'tpope/vim-fugitive',
	cmd = {
		"Git",
	},
	keys = {
		{ "<leader>gs", "<cmd>G<CR>", desc = "[G]it [S]tatus" },
	},
}
