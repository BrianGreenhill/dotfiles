local null_ls = require("null-ls")

local sources = {
	-- general
	null_ls.builtins.code_actions.gitsigns,
	null_ls.builtins.completion.spell,
	-- golang
	null_ls.builtins.diagnostics.golangci_lint,
	null_ls.builtins.formatting.goimports,
	-- protobuf
	null_ls.builtins.formatting.protolint,
	-- python
	null_ls.builtins.formatting.black,
	null_ls.builtins.diagnostics.flake8,
	-- javascript
	null_ls.builtins.code_actions.eslint_d,
	null_ls.builtins.formatting.prettier,
	-- lua
	null_ls.builtins.formatting.stylua,
	-- shell
	null_ls.builtins.formatting.shfmt,
}

null_ls.setup({ sources = sources })
