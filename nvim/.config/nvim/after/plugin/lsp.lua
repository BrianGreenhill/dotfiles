local lsp = require("lsp-zero")

lsp.preset("recommended")
lsp.ensure_installed({
	"tsserver",
	"eslint",
	"sumneko_lua",
	"gopls",
	"marksman",
	"bashls",
})
lsp.nvim_workspace()

-- cmp
local cmp = require("cmp")
local cmp_select = { behaviour = cmp.SelectBehavior.Select }

lsp.setup_nvim_cmp({
	sources = {
		{ name = "copilot" },
		{ name = "path" },
		{ name = "nvim_lsp", keyword_length = 3 },
		{ name = "buffer", keyword_length = 3 },
		{ name = "luasnip", keyword_length = 2 },
	},
	mapping = lsp.defaults.cmp_mappings({
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		["<C-e>"] = cmp.mapping.close(),
		["<C-y>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<C-space>"] = cmp.mapping.complete(cmp_select),
		["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
		["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
	}),
})

lsp.setup()

-- null-ls
local null_ls = require("null-ls")
local null_opts = lsp.build_options("null-ls", {})

local sources = {
	-- golang
	null_ls.builtins.diagnostics.golangci_lint,
	null_ls.builtins.formatting.goimports,
	-- protobuf
	null_ls.builtins.formatting.protolint,
	-- javascript
	null_ls.builtins.code_actions.eslint_d,
	null_ls.builtins.formatting.eslint,
	-- lua
	null_ls.builtins.formatting.stylua,
	-- shell
	null_ls.builtins.formatting.shfmt,
}

null_ls.setup({
	on_attach = null_opts.on_attach,
	sources = sources,
})
