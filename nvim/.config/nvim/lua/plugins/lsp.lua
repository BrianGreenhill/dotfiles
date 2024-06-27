return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            { "williamboman/mason.nvim",           opts = {} },
            { "williamboman/mason-lspconfig.nvim", opts = {} },
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            local lsp = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            lsp.lua_ls.setup({
                capabilities = capabilities,
                settings = {
                    Lua = {
                        workspace = { checkThirdParty = false },
                        completion = { callSnippet = "Replace" },
                    },
                },
            })
            lsp.gopls.setup({ capabilities = capabilities })
            lsp.rust_analyzer.setup({ capabilities = capabilities })
            lsp.tsserver.setup({ capabilities = capabilities })
            lsp.bashls.setup({ capabilities = capabilities })
            lsp.ruby_lsp.setup({ capabilities = capabilities })
            lsp.pyright.setup({ capabilities = capabilities })

            vim.keymap.set("n", "<leader>M", vim.diagnostic.open_float)
            vim.keymap.set("n", "<leader>ld", vim.diagnostic.setqflist)
            vim.keymap.set("n", "[d", vim.diagnostic.goto_next)
            vim.keymap.set("n", "]d", vim.diagnostic.goto_prev)

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = ev.buf })
                    vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = ev.buf })
                    vim.keymap.set("n", "rn", vim.lsp.buf.rename, { buffer = ev.buf })
                    vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, { buffer = ev.buf })
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = ev.buf })
                    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { buffer = ev.buf })
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = ev.buf })
                    vim.keymap.set("n", "gD", vim.lsp.buf.type_definition, { buffer = ev.buf })
                    vim.keymap.set("n", "<leader>D", vim.lsp.buf.declaration, { buffer = ev.buf })

                    require("lsp_signature").on_attach({}, ev.buf)
                end,
            })
        end,
    },
    { "folke/lazydev.nvim", ft = "lua", opts = {} },
    {
        "stevearc/conform.nvim",
        event = "BufWritePre",
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                go = { { "gopls", "goimports" } },
                typescript = { "prettier" },
                rust = { "rustfmt" },
                ruby = { "rufo" },
                python = { "ruff_format" }
            },
            format_on_save = { timeout_ms = 500, lsp_fallback = true },
            notify_on_error = false,
        },
    },
}
