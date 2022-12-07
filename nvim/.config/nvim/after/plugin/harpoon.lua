local nnoremap = require("greenhill.keymap").nnoremap
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

local silent = { silent = true }

nnoremap("<leader>a", mark.add_file, silent)
nnoremap("<C-e>", ui.toggle_quick_menu, silent)
nnoremap("<C-h>", function() ui.nav_file(1) end, silent)
nnoremap("<C-j>", function() ui.nav_file(2) end, silent)
nnoremap("<C-k>", function() ui.nav_file(3) end, silent)
nnoremap("<C-l>", function() ui.nav_file(4) end, silent)
