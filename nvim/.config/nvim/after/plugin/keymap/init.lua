local Remap = require("greenhill.keymap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap
local xnoremap = Remap.xnoremap
local nmap = Remap.nmap

-- save and quit
nnoremap("<leader>w", ":w<CR>")
nnoremap("<leader>q", ":q<CR>")

-- file browser
nnoremap("<C-n>", ":Ex<CR>")

-- undo tree
nnoremap("<leader>u", ":UndotreeShow<CR>")

-- quickfix
nnoremap("<leader>n", ":cnext<CR>")
nnoremap("<leader>p", ":cprev<CR>")
nnoremap("<leader>x", ":cclose<CR>")

-- move things around
vnoremap("J", ":m '>+1<CR>gv=gv")
vnoremap("K", ":m '<-2<CR>gv=gv")
nnoremap("J", "mzJ`z")
nnoremap("n", "nzzzv")
nnoremap("N", "Nzzzv")

-- yanking
nnoremap("Y", "yg$")
nnoremap("<leader>y", '"+y')
vnoremap("<leader>y", '"+y')
nmap("<leader>Y", '"+Y')

-- pasting
xnoremap("<leader>p", '"_dP')

-- deleting
nnoremap("<leader>d", '"_d')
vnoremap("<leader>d", '"_d')
vnoremap("<leader>d", '"_d')

-- escape is so far away
inoremap("<C-c>", "<Esc>")

nnoremap("<leader>gt", ":GoTestOnSave<CR>")
nnoremap("<leader>ld", ":GoTestLineDiag<CR>")
