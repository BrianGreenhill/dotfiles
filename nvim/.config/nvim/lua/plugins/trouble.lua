require("trouble").setup({})

-- Keybindings
vim.api.nvim_set_keymap("n", "<leader>tx", "<cmd>Trouble diagnostics toggle<cr>", { noremap = true, silent = true })
