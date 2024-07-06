return { -- Fuzzy Finder (files, lsp, etc)
	'nvim-telescope/telescope.nvim',
	event = 'VimEnter',
	branch = '0.1.x',
	dependencies = {
		'nvim-lua/plenary.nvim',
		{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
		'nvim-telescope/telescope-ui-select.nvim',
		{ 'nvim-tree/nvim-web-devicons',              enabled = true },
	},
	config = function()
		require 'custom.telescope'
	end,
}
