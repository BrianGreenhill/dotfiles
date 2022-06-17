local system_name = "macOS"
local sumneko_root_path = "/Users/briangreenhill/Personal/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/" .. system_name .. "/lua-language-server"

require("nvim-treesitter.configs").setup({
	ensure_installed = { "go", "python", "ruby", "typescript", "bash", "yaml" }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = { "c", "rust" }, -- list of language that will be disabled
	},
})

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem.snippetSupport = true
local function config(_config)
	return vim.tbl_deep_extend("force", {
		capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
	}, _config or {})
end

require("lspconfig").gopls.setup({
	on_attach = function()
		require("lsp_signature").on_attach()
		config()
	end,
})
-- require'lspconfig'.golangci_lint_ls.setup(config())
require("lspconfig").tsserver.setup(config())
require("lspconfig").bashls.setup(config())
require("lspconfig").yamlls.setup(config())
require("lspconfig").solargraph.setup(config({
	on_attach = config,
	settings = {
		solargraph = {
			diagnostics = { true },
		},
	},
}))
require("lspconfig").pylsp.setup(config())
require("lspconfig").rust_analyzer.setup({})

require("lspconfig").sumneko_lua.setup(config({
	cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
	on_attach = config,
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
				path = vim.split(package.path, ";"),
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
				},
			},
		},
	},
}))

local snippets_paths = function()
	local plugins = { "friendly-snippets" }
	local paths = {}
	local path
	local root_path = vim.env.HOME .. "/.vim/plugged/"
	for _, plug in ipairs(plugins) do
		path = root_path .. plug
		if vim.fn.isdirectory(path) ~= 0 then
			table.insert(paths, path)
		end
	end
	return paths
end

require("luasnip.loaders.from_vscode").lazy_load({
	paths = snippets_paths(),
	include = nil, -- Load all languages
	exclude = {},
})
