return {
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = function()
			return {
				theme = "rose-pine",
				icons_enabled = false,
				component_separators = "|",
				section_separators = "",
			}
		end,
	},
}
