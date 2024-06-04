return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = "nvim-treesitter/nvim-treesitter-textobjects",
    opts = {
        auto_install = false,
        highlight = { enable = true, additional_vim_regex_highlighting = false },
        ensure_installed = {
            "vimdoc",
            "bash",
            "json",
            "toml",
            "yaml",
            "markdown",
            "markdown_inline",
            "go",
            "javascript",
            "typescript",
            "rust",
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<C-space>",
                node_incremental = "<C-space>",
                scope_incremental = false,
                node_decremental = "<bs>",
            },
        },
        textobjects = {
            move = {
                enable = true,
                goto_next_start = { ["]f"] = "@function.outer", ["]o"] = "@class.outer" },
                goto_next_end = { ["]F"] = "@function.outer", ["]O"] = "@class.outer" },
                goto_previous_start = { ["[f"] = "@function.outer", ["[o"] = "@class.outer" },
                goto_previous_end = { ["[F"] = "@function.outer", ["[O"] = "@class.outer" },
            },
            select = {
                enable = true,
                lookahead = true,
                include_surrounding_whitespace = true,
                keymaps = {
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["ao"] = "@class.outer",
                    ["io"] = "@class.inner",
                },
            },
            swap = {
                enable = true,
                swap_next = { ["<leader>a"] = "@parameter.inner" },
                swap_previous = { ["<leader>A"] = "@parameter.inner" },
            },
        },
    },
    config = function(_, opts) require("nvim-treesitter.configs").setup(opts) end,
}
