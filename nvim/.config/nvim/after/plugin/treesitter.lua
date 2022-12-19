require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
	},
	ensure_installed = {
		"help",
		"bash",
		"go",
		"lua",
		"javascript",
		"typescript",
	},
	auto_install = true,
	sync_install = false,
	additional_vim_regex_highlighting = false,
})
