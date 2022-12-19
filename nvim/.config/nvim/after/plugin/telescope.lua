require("telescope").setup()
pcall(require("telescope").load_extention, "fzf")

vim.keymap.set("n", "<C-p>", require("telescope.builtin").git_files)
vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files)
vim.keymap.set("n", "<leader>pl", require("telescope.builtin").live_grep)
vim.keymap.set("n", "<leader>pw", require("telescope.builtin").grep_string)
vim.keymap.set("n", "<leader>ht", require("telescope.builtin").help_tags)
vim.keymap.set("n", "<leader><space>", require("telescope.builtin").buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>/", function()
	-- You can pass additional configuration to telescope to change theme, layout, etc.
	require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "[/] Fuzzily search in current buffer]" })
