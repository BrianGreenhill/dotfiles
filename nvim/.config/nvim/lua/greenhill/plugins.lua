local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")

	use({
		"folke/zen-mode.nvim",
		config = function()
			require("zen-mode").setup({
				window = {
					width = 80,
					options = {
						signcolumn = "no",
						number = false,
						relativenumber = false,
					},
				},
			})
		end,
	})

	use({ "iamcco/markdown-preview.nvim", run = "cd app && yarn install" })

	use({
		"folke/trouble.nvim",
		config = function()
			require("trouble").setup({})
		end,
	})

	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})

	-- colors
	use("gruvbox-community/gruvbox")
	use("folke/tokyonight.nvim")
	use("sainnhe/everforest")

	-- visual undo history
	use("mbbill/undotree")

	-- debugging protocol
	use("mfussenegger/nvim-dap")
	use({
		"theHamsta/nvim-dap-virtual-text",
		config = function()
			require("nvim-dap-virtual-text").setup()
		end,
	})
	use("rcarriga/nvim-dap-ui")
	use("leoluz/nvim-dap-go")

	-- lsp
	use("neovim/nvim-lspconfig")
	use("nvim-lua/popup.nvim")
	use("jose-elias-alvarez/null-ls.nvim")

	use("j-hui/fidget.nvim")

	-- completion
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			{ "L3MON4D3/LuaSnip" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-cmdline" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-path" },
			{ "rafamadriz/friendly-snippets" },
			{ "ray-x/lsp_signature.nvim" },
			{ "saadparwaiz1/cmp_luasnip" },
		},
	})

	-- telescope
	use("nvim-lua/plenary.nvim")
	use("nvim-telescope/telescope.nvim")
	use("nvim-telescope/telescope-fzy-native.nvim")
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use("onsails/lspkind-nvim")
	use("kyazdani42/nvim-web-devicons")

	-- github integration octo
	use({
		"pwntester/octo.nvim",
		requires = {
			"kyazdani42/nvim-web-devicons",
		},
		config = function()
			require("octo").setup()
		end,
	})
	-- copilot
	use("github/copilot.vim")

	use("ThePrimeagen/harpoon")
	use("ThePrimeagen/refactoring.nvim")

	use("tpope/vim-commentary")
	use("tpope/vim-fugitive")
	use("tpope/vim-rhubarb")

	use({ "tpope/vim-dispatch", opt = true, cmd = { "Dispatch", "Make", "Focus", "Start" } })

	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require("packer").sync()
	end
end)
