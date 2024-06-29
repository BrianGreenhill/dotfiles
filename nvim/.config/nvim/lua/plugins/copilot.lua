require("copilot").setup({
    filetypes = {
        yaml = true,
    },
    suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
            accept = "<C-j>",
            dismiss = "<C-]>",
        },
    },
})
