local dap = require("dap")
require("dap-go").setup()
local dapui = require("dapui")
require("nvim-dap-virtual-text").setup({
	virt_text_pos = vim.fn.has 'nvim-0.10' == 1 and 'inline' or 'eol',
})

dapui.setup({
	icons = { expanded = "▾", collapsed = "▸" },
	layouts = {
		{
			elements = {
				"scopes",
				"stacks",
				"watches",
			},
			size = 40,
			position = "left",
		},
		{
			elements = {
				"console",
			},
			size = 10,
			position = "bottom",
		},
	},
	mappings = {
		-- Use a table to apply multiple mappings
		expand = { "<CR>", "<2-LeftMouse>" },
		open = "o",
		remove = "d",
		edit = "e",
		repl = "r",
		toggle = "t",
	},
	-- Expand lines larger than the window
	-- Requires >= 0.7
	expand_lines = vim.fn.has("nvim-0.7"),
	floating = {
		max_height = nil, -- These can be integers or a float between 0 and 1.
		max_width = nil, -- Floats will be treated as percentage of your screen.
		border = "single", -- Border style. Can be "single", "double" or "rounded"
		mappings = {
			close = { "q", "<Esc>" },
		},
	},
	windows = { indent = 1 },
	render = {
		max_type_length = nil, -- Can be integer or nil.
	},
})

-- dap ui events
-- close and open based on whether a debug session is running
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

-- Keymaps

local silent = { silent = true }

vim.keymap.set("n", "<F5>", [[<Cmd>lua require('dap').continue()<CR>]], silent)
vim.keymap.set("n", "<F6>", [[<Cmd>lua require('dap').step_over()<CR>]], silent)
vim.keymap.set("n", "<F7>", [[<Cmd>lua require('dap').step_into()<CR>]], silent)
vim.keymap.set("n", "<F8>", [[<Cmd>lua require('dap').step_out()<CR>]], silent)
vim.keymap.set("n", "<leader>rc", [[<Cmd>lua require('dap').run_to_cursor()<CR>]], silent)
vim.keymap.set("n", "<Leader>db", [[<Cmd>lua require('dap').toggle_breakpoint()<CR>]], silent)
vim.keymap.set("n", "<Leader>du", [[<Cmd>lua require("dapui").toggle()<CR>]], silent)
vim.keymap.set("n", "<Leader>dt", [[<Cmd>lua require('dap-go').debug_test()<CR>]], silent)
