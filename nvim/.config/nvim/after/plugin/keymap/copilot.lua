local Remap = require("greenhill.keymap")
local nnoremap = Remap.nnoremap

nnoremap("<leader>co", ":Copilot enable<CR>")
nnoremap("<leader>cd", ":Copilot disable<CR>")
