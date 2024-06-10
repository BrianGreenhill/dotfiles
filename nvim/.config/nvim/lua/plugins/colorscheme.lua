return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		priority = 1000,
		opts = {
			variant = "moon",
			highlight_groups = {
				Comment = { italic = true },
			},
			styles = {
				transparency = true,
				italic = true,
				bold = true,
			},
		},
		config = function(_, opts)
			require("rose-pine").setup(opts)
			vim.cmd("colorscheme rose-pine")
		end,
	},
}
