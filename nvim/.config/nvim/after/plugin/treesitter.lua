require("nvim-treesitter.configs").setup({
	ensure_installed = { "go", "python", "ruby", "typescript", "bash", "yaml" }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = { "c", "rust" }, -- list of language that will be disabled
	},
})

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.markdown.filetype_to_parsername = "octo"
