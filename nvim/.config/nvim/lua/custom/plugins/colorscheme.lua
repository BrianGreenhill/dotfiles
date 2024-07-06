-- catppuccin
-- https://github.com/catppuccin/nvim

return {
    'catppuccin/nvim',
    as = 'catppuccin',
    priority = 1000,
    init = function()
        vim.cmd.colorscheme 'catppuccin'
        vim.cmd.hi 'Comment gui=none'
    end,
}
