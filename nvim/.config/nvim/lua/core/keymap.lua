-- save and quit
vim.keymap.set("n", "<leader>w", ":w<CR>")
vim.keymap.set("n", "<leader>q", ":q<CR>")

-- file browser
vim.keymap.set("n", "<C-n>", ":Ex<CR>")

-- quickfix
vim.keymap.set("n", "<leader>n", ":cnext<CR>")
vim.keymap.set("n", "<leader>p", ":cprev<CR>")
vim.keymap.set("n", "<leader>x", ":cclose<CR>")

-- move things around
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- scrolling
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")

-- yanking
vim.keymap.set("n", "Y", "yg$")
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y', { noremap = false })

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<leader>po", "<cmd>silent !tmux neww tmux2<CR>")
vim.keymap.set("n", "<leader>f", function()
	vim.lsp.buf.format()
end)

-- pasting
vim.keymap.set("x", "<leader>p", '"_dP')

-- deleting
vim.keymap.set("n", "<leader>d", '"_d')
vim.keymap.set("v", "<leader>d", '"_d')

-- escape is so far away
vim.keymap.set("i", "<C-c>", "<Esc>")

-- fugitive
vim.keymap.set("n", "<leader>gs", ":Git<CR>")
