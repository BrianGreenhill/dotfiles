return {
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		opts = function()
			local cmp = require("cmp")
			local cmp_select = { behaviour = cmp.SelectBehavior.Select }
			return {
				snippet = {
					expand = function(args)
						vim.snippet.expand(args.body)
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
				sources = cmp.config.sources({ { name = "nvim_lsp" } }),
			}
		end,
	},
	{
		"altermo/ultimate-autopair.nvim",
		event = { "InsertEnter", "CmdlineEnter" },
		opts = {},
	},
}
