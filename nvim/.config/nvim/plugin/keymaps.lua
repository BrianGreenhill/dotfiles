local set = vim.keymap.set
set('n', '<leader>w', ':w<CR>', { desc = "[W]rite file" })
set('n', '<leader>q', ':q<CR>', { desc = "[Q]uit to close buffer and vim" })
set('v', 'J', ":m '>+1<CR>gv=gv") -- J to move lines in visual mode
set('v', 'K', ":m '<-2<CR>gv=gv") -- K to move lines in visual mode
set('n', 'J', 'mzJ`z')            -- J in normal mode pulls the line below up
set('n', 'n', 'nzzzv')            -- n in normal mode centers the screen
set('n', 'N', 'Nzzzv')            -- N in normal mode centers the screen
set('n', '<C-u>', '<C-u>zz')      -- <C-u> and <C-d> to scroll half a page up and down
set('n', '<C-d>', '<C-d>zz')
set('x', '<leader>p', '"_dP')     -- <leader>p in execute pode to paste from clipboard
set('n', '<leader>y', '"+y')      -- <leader>y in all modes to copy to clipboard
set('i', '<C-c>', '<Esc>')        -- remaps escape to <C-c>
set('n', 'Y', 'yg$')              -- Y to yank to end of line
set('v', '<leader>y', '"+y')      -- <leader>y in vis/norm mode to copy to clipboard
set('n', '<leader>Y', '"+Y', { noremap = false })
set('n', '<leader>d', '"_d')
set('v', '<leader>d', '"_d')
