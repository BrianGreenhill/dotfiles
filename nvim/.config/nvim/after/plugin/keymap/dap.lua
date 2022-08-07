local Remap = require("greenhill.keymap")
local nnoremap = Remap.nnoremap

local silent = { silent = true }

nnoremap("<F5>", [[<Cmd>lua require('dap').continue()<CR>]], silent)
nnoremap("<F6>", [[<Cmd>lua require('dap').step_over()<CR>]], silent)
nnoremap("<F7>", [[<Cmd>lua require('dap').step_into()<CR>]], silent)
nnoremap("<F8>", [[<Cmd>lua require('dap').step_out()<CR>]], silent)
nnoremap("<leader>rc", [[<Cmd>lua require('dap').run_to_cursor()<CR>]], silent)
nnoremap("<Leader>db", [[<Cmd>lua require('dap').toggle_breakpoint()<CR>]], silent)
nnoremap("<Leader>du", [[<Cmd>lua require("dapui").toggle()<CR>]], silent)
nnoremap("<Leader>dt", [[<Cmd>lua require('dap-go').debug_test()<CR>]], silent)
