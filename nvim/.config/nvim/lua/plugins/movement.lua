return {
	{
		"camspiers/snap",
		config = function()
			local snap = require("snap")
			local config = {
				prompt = "",
				reverse = true,
				consumer = "fzf",
				limit = 50000,
			}
			local file = snap.config.file:with(config)
			local vimgrep = snap.config.vimgrep:with(config)
			snap.maps({
				{
					"<C-p>",
					file({
						producer = "ripgrep.file",
						args = { "--hidden", "--ignore", "--iglob", "!*.git" },
						preview_min_width = 0,
						preview = true,
					}),
				},
				{
					"<leader>ff",
					vimgrep({
						producer = "ripgrep.vimgrep",
						args = { "--hidden", "--ignore", "--iglob", "!*.git" },
						preview_min_width = 0,
						preview = true,
					}),
				},
			})
		end,
	},
	{
		"ggandor/leap.nvim",
		config = function()
			vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-forward)")
			vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(leap-backward)")
			vim.keymap.set({ "n", "x", "o" }, "gs", "<Plug>(leap-from-window)")
		end,
	},
}
