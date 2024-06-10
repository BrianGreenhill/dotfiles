return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				filetypes = {
					yaml = true,
				},
				suggestion = {
					enabled = true,
					auto_trigger = true,
					debounce = 75,
					keymap = {
						accept = "<C-j>",
						dismiss = "<C-]>",
					},
				},
			})
		end,
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			"zbirenbaum/copilot.lua",
			"nvim-lua/plenary.nvim",
		},
		branch = "canary",
		opts = {
			debug = true,
		},
	},
}
