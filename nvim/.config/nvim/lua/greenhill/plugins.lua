return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")

	use("folke/zen-mode.nvim")
	use({ "iamcco/markdown-preview.nvim", run = "cd app && yarn install", cmd = "MarkdownPreview" })
	use("folke/trouble.nvim")
	use("gruvbox-community/gruvbox")
	use("hoob3rt/lualine.nvim")

	-- snippets
	use("leoluz/nvim-dap-go")

	-- visual undo history
	use("mbbill/undotree")

	-- debugging protocol
	use("mfussenegger/nvim-dap")
	use("rcarriga/nvim-dap-ui")

	-- lsp
	use("neovim/nvim-lspconfig")
	use("nvim-lua/popup.nvim")
	use("nvim-lua/plenary.nvim")
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
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			{ "nvim-lua/plenary.nvim" },
		},
	})
	use("nvim-telescope/telescope-fzy-native.nvim")
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use("onsails/lspkind-nvim")
	use("kyazdani42/nvim-web-devicons")

	-- github integration octo
	use("pwntester/octo.nvim")

	use("ThePrimeagen/harpoon")
	use("ThePrimeagen/refactoring.nvim")

	use("tpope/vim-commentary")
	use("tpope/vim-fugitive")
	use("tpope/vim-rhubarb")

	use({ "tpope/vim-dispatch", opt = true, cmd = { "Dispatch", "Make", "Focus", "Start" } })

	use("windwp/nvim-autopairs")
end)
