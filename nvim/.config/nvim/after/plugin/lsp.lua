local lsp = require("lsp-zero")

lsp.preset("recommended")
lsp.ensure_installed({
	"tsserver",
	"eslint",
	"sumneko_lua",
	"gopls",
})
lsp.nvim_workspace()

-- cmp
local cmp = require("cmp")
local cmp_select = { behaviour = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
	["<C-y>"] = cmp.mapping.confirm({ select = true }),
	["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
	["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
	["<C-space>"] = cmp.mapping.complete(),
})

lsp.setup_nvim_cmp({
	sources = {
		{ name = "copilot" },
		{ name = "path" },
		{ name = "nvim_lsp", keyword_length = 3 },
		{ name = "buffer", keyword_length = 3 },
		{ name = "luasnip", keyword_length = 2 },
	},
	mapping = cmp_mappings,
})

lsp.set_preferences({
	sign_icons = {},
})

lsp.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set("n", "gd", function()
		vim.lsp.buf.definition()
	end, opts)
	vim.keymap.set("n", "gr", function()
		vim.lsp.buf.references()
	end, opts)
	vim.keymap.set("n", "rn", function()
		vim.lsp.buf.rename()
	end, opts)
	vim.keymap.set("n", "K", function()
		vim.lsp.buf.hover()
	end, opts)
	vim.keymap.set("n", "<C-k>", function()
		vim.lsp.buf.signature_help()
	end, opts)
	vim.keymap.set("n", "[d", function()
		vim.diagnostic.goto_next()
	end, opts)
	vim.keymap.set("n", "]d", function()
		vim.diagnostic.goto_prev()
	end, opts)
	vim.keymap.set("n", "<leader>vca", function()
		vim.lsp.buf.code_action()
	end, opts)
end)

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
