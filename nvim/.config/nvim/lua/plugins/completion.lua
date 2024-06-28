-- Configuration for nvim-cmp
local cmp = require("cmp")
local cmp_select = { behaviour = cmp.SelectBehavior.Select }
cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "path" },
        { name = "cmdline" },
    }),
})

cmp.setup {
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    window = {
        completion = { border = "rounded", scrollbar = false },
        documentation = { border = "rounded", scrollbar = false },
    },
    completion = { completeopt = "menu,menuone,noinsert" },
    mapping = {
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
        ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
        ["<C-space>"] = cmp.mapping.complete(),
    },
    formatting = { fields = { "kind", "abbr", "menu" } },
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
    }),
}
require("nvim-autopairs").setup {}
require("lsp_signature").setup({})
