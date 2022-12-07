local bind = function(op, outer_opts)
	outer_opts = outer_opts or { noremap = true }
	return function(lhs, rhs, opts)
		opts = vim.tbl_extend("force", outer_opts or {}, opts or {})
		vim.keymap.set(op, lhs, rhs, opts)
	end
end

local M = {}

M.nmap = bind("n", { noremap = false })
M.nnoremap = bind("n")
M.vnoremap = bind("v")
M.xnoremap = bind("x")
M.inoremap = bind("i")
M.snoremap = bind("s")

return M
