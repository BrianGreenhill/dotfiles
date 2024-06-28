local colors = require('rose-pine.palette')

local rose_pine_custom = {
    normal = {
        a = { fg = colors.love, bg = 'none' }, -- pink
        b = { fg = colors.rose, bg = 'none' }, -- orange
        c = { fg = colors.subtle, bg = 'none' }
    },
    insert = { a = { fg = colors.love, bg = 'none' } },  -- pink
    visual = { a = { fg = colors.rose, bg = 'none' } },  -- orange
    replace = { a = { fg = colors.love, bg = 'none' } }, -- pink
    inactive = {
        a = { fg = colors.subtle, bg = 'none' },
        b = { fg = colors.subtle, bg = 'none' },
        c = { fg = colors.subtle, bg = 'none' },
    },
}

require('lualine').setup {
    options = {
        theme = rose_pine_custom,
        section_separators = '',
        component_separators = '',
        icons_enabled = true,
    },
}
