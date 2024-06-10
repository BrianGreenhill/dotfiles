return {
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"saadparwaiz1/cmp_luasnip",
			"L3MON4D3/LuaSnip",
		},
		event = "InsertEnter",
		opts = function()
			local cmp = require("cmp")
			local cmp_select = { behaviour = cmp.SelectBehavior.Select }
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
					{ name = "cmp-cmdline" },
				}),
			})
			return {
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				window = {
					completion = { border = "rounded", scrollbar = false },
					documentation = { border = "rounded", scrollbar = false },
				},
				completion = { completeopt = "menu,menuone,noinsert" },
				mapping = {
					["<C-y>"] = cmp.mapping.confirm({ select = true }),
					["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
					["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
					["<C-space>"] = cmp.mapping.complete(),
				},
				formatting = { fields = { "kind", "abbr", "menu" } },
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "nvim_lua" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
				}),
			}
		end,
	},
	{
		"altermo/ultimate-autopair.nvim",
		event = { "InsertEnter", "CmdlineEnter" },
		opts = {},
	},
	{
		"ray-x/lsp_signature.nvim",
		event = "VeryLazy",
		opts = {},
		config = function(_, opts)
			require("lsp_signature").setup(opts)
		end,
	},
}
