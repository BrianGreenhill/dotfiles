require("rose-pine").setup({
    variant = "moon",
    highlight_groups = {
        Comment = { italic = true },
    },
    styles = {
        transparency = true,
        italic = true,
        bold = true,
    },
})

vim.cmd('colorscheme rose-pine')
