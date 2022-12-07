local keymap = require("greenhill.keymap")
local nnoremap = keymap.nnoremap
local vnoremap = keymap.vnoremap
local xnoremap = keymap.xnoremap
local inoremap = keymap.inoremap
local nmap = keymap.nmap

-- save and quit
nnoremap("<leader>w", ":w<CR>")
nnoremap("<leader>q", ":q<CR>")

-- file browser
nnoremap("<C-n>", ":Ex<CR>")

-- undotree
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

-- scrolling
nnoremap("<C-u>", "<C-u>zz")
nnoremap("<C-d>", "<C-d>zz")

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

-- fugitive
nnoremap("<leader>gs", ":Git<CR>")
