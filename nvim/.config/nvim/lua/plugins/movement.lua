return {
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
    },
    {
        "nvim-telescope/telescope.nvim",
        requires = {
            { "nvim-lua/popup.nvim" },
            { "nvim-lua/plenary.nvim" },
        },
        config = function()
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
        end,
    },
    -- {
    --     "camspiers/snap",
    --     config = function()
    --         local snap = require("snap")
    --         local config = {
    --             prompt = "",
    --             reverse = true,
    --             consumer = "fzf",
    --             limit = 50000,
    --         }
    --         local file = snap.config.file:with(config)
    --         local vimgrep = snap.config.vimgrep:with(config)
    --         snap.maps({
    --             {
    --                 "<C-p>",
    --                 file({
    --                     producer = "ripgrep.file",
    --                     args = { "--hidden", "--ignore", "--iglob", "!*.git" },
    --                     preview_min_width = 0,
    --                     preview = true,
    --                 }),
    --             },
    --             {
    --                 "<leader>ff",
    --                 vimgrep({
    --                     producer = "ripgrep.vimgrep",
    --                     args = { "--hidden", "--ignore", "--iglob", "!*.git" },
    --                     preview_min_width = 0,
    --                     preview = true,
    --                 }),
    --             },
    --         })
    --     end,
    -- },
    {
        "ggandor/leap.nvim",
        config = function()
            vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-forward)")
            vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(leap-backward)")
            vim.keymap.set({ "n", "x", "o" }, "gs", "<Plug>(leap-from-window)")
        end,
    },
}
