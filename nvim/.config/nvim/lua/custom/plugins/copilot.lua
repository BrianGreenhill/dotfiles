-- copilot
-- https://github.com/zbirenbaum/copilot.lua

return {
	'zbirenbaum/copilot.lua',
	cmd = 'Copilot',
	event = 'InsertEnter',
	config = function()
		require('copilot').setup({
			filetypes = { yaml = true },
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
}
