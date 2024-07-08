return { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
        'folke/neodev.nvim',
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'WhoIsSethDaniel/mason-tool-installer.nvim',

        { 'j-hui/fidget.nvim',                           opts = {} },
        { 'ray-x/lsp_signature.nvim' },
        { 'https://git.sr.ht/~whynothugo/lsp_lines.nvim' },
    },
    config = function()
        require 'custom.lsp'
    end,
}
