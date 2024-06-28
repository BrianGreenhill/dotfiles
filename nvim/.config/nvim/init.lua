require("core.options")
require("core.keymap")

-- Install vim-plug if not already installed
local plug_install_path = vim.fn.stdpath('data') .. '/site/autoload/plug.vim'
if vim.fn.empty(vim.fn.glob(plug_install_path)) > 0 then
    vim.fn.system({
        'sh', '-c',
        'curl -fLo ' .. plug_install_path .. ' --create-dirs ' ..
        'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    })
    vim.cmd [[autocmd VimEnter * PlugInstall | source $MYVIMRC]]
end

require("plugins")
