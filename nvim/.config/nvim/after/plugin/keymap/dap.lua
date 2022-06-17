local Remap = require("greenhill.keymap")
local nnoremap = Remap.nnoremap

nnoremap("<F5>", [[<Cmd>lua require('dap').continue()<CR>]], { noremap = true, silent = true })
nnoremap("<F6>", [[<Cmd>lua require('dap').step_over()<CR>]], { noremap = true, silent = true })
nnoremap("<F7>", [[<Cmd>lua require('dap').step_into()<CR>]], { noremap = true, silent = true })
nnoremap("<F8>", [[<Cmd>lua require('dap').step_out()<CR>]], { noremap = true, silent = true })
nnoremap("<Leader>db", [[<Cmd>lua require('dap').toggle_breakpoint()<CR>]], { noremap = true, silent = true })
nnoremap("<Leader>dr", [[<Cmd>lua require('dap').repl.open()<CR>]], { noremap = true, silent = true })
nnoremap("<Leader>dl", [[<Cmd>lua require('dap').run_last()<CR>]], { noremap = true, silent = true })
nnoremap("<Leader>dt", [[<Cmd>lua require('dap-go').debug_test()<CR>]], { noremap = true, silent = true })
nnoremap("<Leader>du", [[<Cmd>lua require("dapui").toggle()<CR>]], { noremap = true, silent = true })
