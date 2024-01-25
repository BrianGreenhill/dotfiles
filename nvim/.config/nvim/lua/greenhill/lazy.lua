local lazypath = vim.fn.stdpath('data') .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git', '--branch=stable',
		lazypath
	})
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
	{ "rose-pine/neovim", lazy = false, priority = 1000, config = function()
		vim.cmd([[colorscheme rose-pine]])
	end },
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	"nvim-treesitter/nvim-treesitter-context",
	"theprimeagen/harpoon",
	"mbbill/undotree",
	"nvim-lualine/lualine.nvim",
	"github/copilot.vim",
	{
		"jellydn/CopilotChat.nvim",
		opts = {
			mode = "split",
			prompts = {
				Explain  = "Explain how it works.",
				Review   = "Review the follwing code and provide concise suggestions.",
				Tests    = "Briefly explain how the selected code works, then generate unit tests.",
				Refactor = "Refactor the code to improve clarity and readability."
			},
		},
		build = function()
			vim.defer_fn(function()
				vim.cmd("UpdateRemotePlugins")
				vim.notify("CopilotChat - Updated Remote plugins. Please restart Neovim.")
			end, 3000)
		end,
		event = "VeryLazy",
		keys = {
			{ "<leader>cce", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - Explain code" },
			{ "<leader>cct", "<cmd>CopilotChatTests<cr>", desc = "CopilotChat - Generate tests" },
			{ "<leader>ccr", "<cmd>CopilotChatReview<cr>", desc = "CopilotChat - Review code" },
			{ "<leader>ccR", "<cmd>CopilotChatRefactor<cr>", desc = "CopilotChat - Refactor code" },
		}
	},
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = { 'nvim-lua/plenary.nvim', 'nvim-tree/nvim-web-devicons' }
	},
	{ "VonHeikemen/lsp-zero.nvim", branch = "v1.x" },
	{ "neovim/nvim-lspconfig" },
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"folke/lsp-colors.nvim",
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lua",
		},
	},
	"mfussenegger/nvim-dap",
	"leoluz/nvim-dap-go",
	"rcarriga/nvim-dap-ui",
	"theHamsta/nvim-dap-virtual-text",
	"onsails/lspkind-nvim",
	"L3MON4D3/LuaSnip",
	"rafamadriz/friendly-snippets",

	"tpope/vim-commentary",
	"tpope/vim-fugitive",
	"tpope/vim-sleuth",
}

local opts = {}

require("lazy").setup(plugins, opts)
