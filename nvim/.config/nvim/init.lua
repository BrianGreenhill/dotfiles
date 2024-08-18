local vim = vim
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.nu = true
vim.opt.rnu = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.mouse = "a"
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.signcolumn = "yes"
vim.opt.inccommand = "split"
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"
vim.opt.undolevels = 1000
vim.opt.undoreload = 10000
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 5
vim.opt.wrap = false

local set = vim.keymap.set
set("n", "<leader>w", "<cmd>:w<cr>")
set("n", "<leader>q", "<cmd>:q<cr>")
set("v", "<leader>y", '"+y')
set("n", "<leader>Y", '"+Y', { noremap = false })
set("n", "<leader>cr", "<cmd>:so ~/.config/nvim/init.lua<cr>", { desc = "[C]onfig [R]eload" })

local Plug = vim.fn["plug#"]
vim.call("plug#begin")

Plug("ibhagwan/fzf-lua", { branch = "main" })
Plug("folke/lazydev.nvim")
Plug("folke/tokyonight.nvim")
Plug("hrsh7th/cmp-nvim-lsp")
Plug("hrsh7th/cmp-path")
Plug("hrsh7th/cmp-buffer")
Plug("hrsh7th/cmp-cmdline")
Plug("hrsh7th/nvim-cmp")
Plug("leoluz/nvim-dap-go")
Plug("mbbill/undotree")
Plug("mfussenegger/nvim-dap")
Plug("mfussenegger/nvim-lint")
Plug("neovim/nvim-lspconfig")
Plug("nvim-neotest/nvim-nio")
Plug("nvim-treesitter/nvim-treesitter", { ["do"] = ":TSUpdate" })
Plug("nvim-treesitter/nvim-treesitter-context")
Plug("ray-x/lsp_signature.nvim")
Plug("rcarriga/nvim-dap-ui")
Plug("stevearc/conform.nvim")
Plug("stevearc/oil.nvim")
Plug("tpope/vim-fugitive")
Plug("tpope/vim-rails")
Plug("onsails/lspkind.nvim")
Plug("zbirenbaum/copilot.lua")
Plug("windwp/nvim-autopairs")
Plug("williamboman/mason.nvim")
Plug("nvim-lua/plenary.nvim")
Plug("ThePrimeagen/harpoon", { branch = "harpoon2" })
vim.call("plug#end")

require("tokyonight").setup({
	style = "storm",
	transparent = true,
	styles = {
		comments = { italic = false },
		keywords = { italic = false },
		sidebars = "transparent",
		floats = "transparent",
		plugins = { auto = false },
	},
})
vim.cmd.colorscheme("tokyonight")
set("n", "<leader>gs", "<cmd>:G<cr>")
require("oil").setup()
vim.keymap.set("n", "-", "<cmd>:Oil<cr>")
require("nvim-treesitter.configs").setup({})
require("mason").setup()
local fzflua = require("fzf-lua")
fzflua.setup({
	"max-perf",
	keymap = { fzf = { ["ctrl-q"] = "select-all+accept" } },
	winopts = {
		preview = { hidden = "hidden" },
	},
	files = {
		fd_opts = [[--color=never --type f --hidden --follow --exclude .git --exclude vendor]],
	},
	grep = {
		rg_opts = [[--hidden --column --line-number --no-heading --color=always --smart-case --max-columns=4096 -g !.git/ -g !vendor -e ]],
	},
})
local files_cwd = function(cwd)
	return function()
		fzflua.files(cwd)
	end
end
set("n", "<leader>sf", fzflua.files)
set("n", "<leader>sh", fzflua.help_tags)
set("n", "<leader>s/", fzflua.grep)
set("n", "<leader>sq", fzflua.quickfix)
set("n", "<leader><leader>", fzflua.live_grep_resume)
set("n", "<leader>sn", files_cwd({ cwd = vim.fn.stdpath("config") }))
set("n", "<leader>sd", files_cwd({ cwd = vim.env.HOME .. "/projects/dotfiles" }))
set("n", "<leader>so", files_cwd({ cwd = vim.env.HOME .. "/projects/obsidian/hoard" }))
set("n", "<leader>u", vim.cmd.UndotreeToggle)

local harpoon = require("harpoon")
harpoon:setup()
vim.keymap.set("n", "<leader>a", function()
	harpoon:list():add()
end)
vim.keymap.set("n", "<C-e>", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end)

require("copilot").setup({
	suggestion = {
		auto_trigger = true,
		keymap = { accept = "<C-j>" },
	},
	filetypes = {
		yaml = true,
		markdown = true,
	},
})

require("lazydev").setup()
require("nvim-autopairs").setup({})

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")
local opts = { capabilities = capabilities }
lspconfig.gopls.setup(opts)
lspconfig.yamlls.setup(opts)
lspconfig.sorbet.setup(opts)
lspconfig.tsserver.setup(opts)
lspconfig.bashls.setup(opts)
lspconfig.lua_ls.setup({
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
				path = vim.split(package.path, ";"),
			},
			diagnostics = {
				globals = { "vim", "require" },
				disable = { "missing-fields" },
			},
		},
	},
})
local lspkind = require("lspkind")
local cmp = require("cmp")
cmp.setup({
	completion = {
		completeopt = "menu,menuone,preview,noinsert",
	},
	snippet = {
		expand = function(args)
			vim.snippet.expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-y>"] = cmp.mapping.confirm({ select = false }),
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		["<C-e>"] = cmp.mapping.abort(),
		["<C-space>"] = cmp.mapping.complete(),
	}),
	formatting = {
		format = lspkind.cmp_format({
			maxwidth = 50,
			ellipsis_char = "...",
		}),
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "buffer", keyword_length = 3 },
		{ name = "path" },
	}),
})

cmp.setup.cmdline("/", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "buffer" },
	}),
})

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{
			name = "cmdline",
			option = {
				ignore_cmds = { "Man", "!" },
			},
		},
	}),
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(event)
		require("lsp_signature").on_attach()
		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		map("<leader>le", vim.diagnostic.open_float, "[L]ist [E]rrors")
		map("gd", fzflua.lsp_definitions, "[G]oto [D]efinition")
		map("gr", fzflua.lsp_references, "[G]oto [R]eferences")
		map("gi", fzflua.lsp_implementations, "[G]oto [I]mplementations")
		map("rn", vim.lsp.buf.rename, "[R]e[n]ame")
		map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
	end,
})

require("conform").setup({
	format_on_save = {
		async = false,
		timeout_ms = 500,
		lsp_format = "fallback",
	},
	formatters_by_ft = {
		lua = { "stylua" },
		go = { "gofmt", "goimports" },
	},
})
require("lint").linters_by_ft = {
	markdown = { "cspell" },
	go = { "golangcilint" },
	ruby = { "rubocop" },
	lua = { "luacheck" },
}
local lintaugroup = vim.api.nvim_create_augroup("lint", { clear = true })
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	group = lintaugroup,
	callback = function()
		require("lint").try_lint()
	end,
})

require("dapui").setup()
require("dap-go").setup()
local dap = require("dap")
local ui = require("dapui")
set("n", "<leader>db", dap.toggle_breakpoint)
set("n", "dt", require("dap-go").debug_test)
set("n", "dlt", require("dap-go").debug_last_test)
set("n", "<F5>", dap.continue)
set("n", "<F6>", dap.step_over)
set("n", "<F7>", dap.step_into)
set("n", "<F8>", dap.step_out)
set("n", "<F9>", dap.step_back)
set("n", "<F10>", dap.restart)
dap.listeners.before.attach.dapui_config = function()
	ui.open()
end
dap.listeners.before.launch.dapui_config = function()
	ui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	ui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	ui.close()
end
