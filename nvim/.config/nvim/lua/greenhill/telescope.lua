local telescope = require("telescope")
local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")

require("nvim-web-devicons").setup({ default = true })

telescope.setup({
	defaults = {
		file_sorter = require("telescope.sorters").get_fzy_sorter,
		prompt_prefix = " >",
		color_devicons = true,
		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
		mappings = {
			i = {
				["<C-x>"] = false,
				["<C-q>"] = actions.send_to_qflist,
				["<C-t>"] = trouble.open_with_trouble,
			},
			n = {
				["<C-t>"] = trouble.open_with_trouble,
			},
		},
		file_ignore_patterns = {
			"^.git/",
			"^node_modules/*",
			"%.DS_Store",
			"^vendor/",
			"^clients/",
			"%.pb.go",
			"%pb2_twirp.py",
		},
	},
	pickers = {
		git_files = { theme = "ivy" },
		live_grep = { theme = "ivy" },
		lsp_references = { theme = "ivy" },
		grep_string = { theme = "ivy" },
	},
	extensions = {
		fzy_native = {
			override_generic_sorter = true,
			override_file_sorter = true,
		},
	},
})
require("telescope").load_extension("fzy_native")

local M = {}
M.search_dotfiles = function()
	require("telescope.builtin").git_files({
		prompt_title = "< ~dotfiles~ >",
		cwd = "$DOTFILES",
	})
end

return M
