-- Load plugins

-- Configuration for Telescope
require("telescope").setup {
    defaults = {
        file_ignore_patterns = {},
    },
    pickers = {
        find_files = {
            find_command = { "rg", "--files", "--hidden", "--glob", "!*.git" },
        },
        live_grep = {
            additional_args = function()
                return { "--hidden", "--ignore", "--glob", "!*.git" }
            end
        },
        current_buffer_fuzzy_find = {
            previewer = false,
        },
    },
    extensions = {
        fzf = {
            override_generic_sorter = false,
            override_file_sorter = true,
            case_mode = "smart_case",
        },
    },
}
require("telescope").load_extension("fzf")

vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd>Telescope live_grep<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-p>", "<cmd>Telescope find_files<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { noremap = true })
