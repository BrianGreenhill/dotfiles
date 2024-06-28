require("nvim-treesitter.configs").setup({
    sync_install = false,
    ignore_install = {},
    modules = {},
    auto_install = false,
    ensure_installed = { "go", "lua", "rust", "bash", "typescript", "javascript", "ruby" },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true,
        disable = { "yaml" },
    },
})
