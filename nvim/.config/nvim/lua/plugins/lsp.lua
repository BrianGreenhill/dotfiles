require("mason").setup()
require("mason-lspconfig").setup()
require("lsp_signature").setup()

local lsp = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local on_attach = function(client, bufnr)
    if client.name == 'ruff' then
        -- Disable hover in favor of Pyright
        client.server_capabilities.hoverProvider = false
    end

    if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = vim.api.nvim_create_augroup("LspFormatting", { clear = true }),
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({ bufnr = bufnr })
            end,
        })
    end

    require("lsp_signature").on_attach()

    -- key mapping
    local opts = { buffer = bufnr, silent = true }
    vim.keymap.set("n", "<leader>M", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "<leader>ld", vim.diagnostic.setqflist, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<leader>D", vim.lsp.buf.declaration, opts)
end

local servers = {
    lua_ls = {},
    gopls = {},
    rust_analyzer = {},
    bashls = {},
    ruby_lsp = {},
    ruff = {},
    pyright = {},
    tsserver = {},
}

for server, config in pairs(servers) do
    config.capabilities = capabilities
    config.on_attach = on_attach
    lsp[server].setup(config)
end
