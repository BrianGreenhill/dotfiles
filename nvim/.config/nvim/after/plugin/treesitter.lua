require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"bash",
		"dockerfile",
		"gitcommit",
		"go",
		"javascript",
		"lua",
		"markdown",
		"sql",
		"typescript",
		"yaml",
	},
	auto_install = true,
})
