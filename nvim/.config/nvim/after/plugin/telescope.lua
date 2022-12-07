local nnoremap = require("greenhill.keymap").nnoremap
local ok, t = pcall(require, "telescope")
local ok, builtin = pcall(require, "telescope.builtin")
if not ok then
	return
end

t.setup();
t.load_extension('fzf')

nnoremap("<C-p>", builtin.git_files)
nnoremap("<leader>ff", builtin.find_files)
nnoremap("<leader>pl", builtin.live_grep)
nnoremap("<leader>pb", builtin.buffers)
nnoremap("<leader>ht", builtin.help_tags)
