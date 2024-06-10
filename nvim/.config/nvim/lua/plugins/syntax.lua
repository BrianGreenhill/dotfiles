return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		auto_install = false,
		indent = { enable = true, disable = { "yaml" } },
		highlight = { enable = true, additional_vim_regex_highlighting = false },
		ensure_installed = { "go", "lua", "rust", "bash", "typescript", "javascript", "ruby" },
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
}
