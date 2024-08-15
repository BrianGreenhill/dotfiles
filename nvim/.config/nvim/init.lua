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
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.shortmess:append("c")

local set = vim.keymap.set
set("n", "<leader>w", "<cmd>:w<cr>")
set("n", "<leader>q", "<cmd>:q<cr>")
set("v", "<leader>y", '"+y')
set("n", "<leader>Y", '"+Y', { noremap = false })
set("n", "<leader>cr", "<cmd>:so ~/.config/nvim/init.lua<cr>", { desc = "[C]onfig [R]eload" })

local Plug = vim.fn["plug#"]
vim.call("plug#begin")

-- Plug("ibhagwan/fzf-lua", { branch = "main" })
Plug("folke/lazydev.nvim")
Plug("hrsh7th/cmp-nvim-lsp")
Plug("hrsh7th/cmp-buffer")
Plug("hrsh7th/cmp-path")
Plug("hrsh7th/cmp-cmdline")
Plug("hrsh7th/nvim-cmp")
Plug("leoluz/nvim-dap-go")
Plug("mfussenegger/nvim-dap")
Plug("mfussenegger/nvim-lint")
Plug("neovim/nvim-lspconfig")
Plug("nvim-neotest/nvim-nio")
Plug("nvim-treesitter/nvim-treesitter", { ["do"] = ":TSUpdate" })
Plug("nvim-treesitter/nvim-treesitter-context")
Plug("ray-x/lsp_signature.nvim")
Plug("rcarriga/nvim-dap-ui")
Plug("rebelot/kanagawa.nvim")
Plug("stevearc/conform.nvim")
Plug("stevearc/oil.nvim")
Plug("tpope/vim-fugitive")
Plug("zbirenbaum/copilot.lua")
Plug("windwp/nvim-autopairs")
Plug("williamboman/mason.nvim")
Plug("ThePrimeagen/harpoon", { branch = "harpoon2" })
Plug("nvim-lua/plenary.nvim")
Plug("nvim-telescope/telescope-fzf-native.nvim", { ["do"] = "make" })
Plug("nvim-telescope/telescope.nvim", { branch = "0.1.x" })
vim.call("plug#end")

require("kanagawa").setup({ transparent = true })
vim.cmd.colorscheme("kanagawa-dragon")
set("n", "<leader>gs", "<cmd>:G<cr>")
require("oil").setup()
vim.keymap.set("n", "-", "<cmd>:Oil<cr>")
require("nvim-treesitter.configs").setup({
    ensure_installed = { "vimdoc", "markdown", "markdown_inline" },
    sync_install = false,
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
    additional_vim_regex_highlighting = { "markdown", "ruby" },
})
require("mason").setup()
local telescope = require("telescope")
local builtin = require("telescope.builtin")
telescope.setup({
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        },
    },
})
require("telescope").load_extension("fzf")
set("n", "<leader>sf", builtin.find_files)
set("n", "<leader>s/", builtin.live_grep)
set("n", "<leader>sh", builtin.help_tags)
set("n", "<leader>sq", builtin.quickfix)
set("n", "<leader>st", builtin.tags)
set("n", "<leader>sn", function()
    builtin.find_files({ cwd = vim.fn.stdpath("config") })
end)
set("n", "<leader>sd", function()
    builtin.find_files({ cwd = vim.env.HOME .. "/projects/dotfiles" })
end)
set("n", "<leader>so", function()
    builtin.find_files({ cwd = vim.env.HOME .. "/projects/obsidian/hoard" })
end)
-- local fzflua = require("fzf-lua")
-- fzflua.setup({
-- 	"max-perf",
-- 	keymap = { fzf = { ["ctrl-q"] = "select-all+accept" } },
-- })
-- local files_cwd = function(cwd)
-- 	return function()
-- 		fzflua.files(cwd)
-- 	end
-- end
-- set("n", "<leader>sf", fzflua.files)
-- set("n", "<leader>sh", fzflua.help_tags)
-- set("n", "<leader>s/", fzflua.live_grep_native)
-- set("n", "<leader>sq", fzflua.quickfix)
-- set("n", "<leader>sn", files_cwd({ cwd = vim.fn.stdpath("config") }))
-- set("n", "<leader>sd", files_cwd({ cwd = vim.env.HOME .. "/projects/dotfiles" }))
-- set("n", "<leader>so", files_cwd({ cwd = vim.env.HOME .. "/Documents/obsidian/hoard" }))
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
local servers = { "gopls", "yamlls", "sorbet", "tsserver", "lua_ls", "bashls" }
for _, lsp in pairs(servers) do
    lspconfig[lsp].setup({
        capabilities = capabilities,
    })
end

local cmp = require("cmp")
cmp.setup({
    snippet = {
        expand = function(args)
            vim.snippet.expand(args.body)
        end,
    },
    mapping = {
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-y>"] = cmp.mapping(
            cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Insert,
                select = true,
            }),
            { "i", "c" }
        ),
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "buffer" },
        { name = "cmdline" },
    },
})

local lspaucmdcfg = {
    group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
    callback = function(event)
        require("lsp_signature").on_attach()
        local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        map("<leader>le", vim.diagnostic.open_float, "[L]ist [E]rrors")
        map("gd", builtin.lsp_definitions, "[G]oto [D]efinition")
        map("gr", builtin.lsp_references, "[G]oto [R]eferences")
        map("gi", builtin.lsp_implementations, "[G]oto [I]mplementations")
        -- map("gr", fzflua.lsp_references, "[G]oto [R]eferences")
        -- map("gi", fzflua.lsp_implementations, "[G]oto [I]mplementations")
        map("rn", vim.lsp.buf.rename, "[R]e[n]ame")
        map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentFormattingProvider then
            local format_group = vim.api.nvim_create_augroup("LspFormatting", { clear = false })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = format_group,
                buffer = event.buf,
                callback = function()
                    vim.lsp.buf.format({ async = false })
                end,
            })
        end
    end,
}
vim.api.nvim_create_autocmd("LspAttach", lspaucmdcfg)

require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        go = { "gofmt", "goimports" },
    },
})
vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function(args)
        require("conform").format({
            bufnr = args.bufnr,
            lsp_fallback = true,
            quiet = true,
        })
    end,
})
local lint = require("lint")
lint.linters_by_ft = {
    markdown = { "cspell" },
    go = { "golangcilint" },
    ruby = { "rubocop" },
    lua = { "luacheck" },
}
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function()
        lint.try_lint()
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
