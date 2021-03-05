local actions = require('telescope.actions')

require'nvim-web-devicons'.setup {default = true;}

require('telescope').setup {
  defaults = {
    file_sorter = require('telescope.sorters').get_fzy_sorter,
    prompt_prefix = ' >',
    color_devicons = true,
    file_previewer = require('telescope.previewers').vim_buffer_cat.new,
    grep_previewer   = require('telescope.previewers').vim_buffer_vimgrep.new,
    qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
    mappings = {
      i = {
        ["<C-x>"] = false,
        ["<C-q>"] = actions.send_to_qflist,
      },
    },
    file_ignore_patters = {
      '.git/*',
      'node_modules/*',
      '.DS_Store',
      'vendor/*'
    }
  },
  extensions = {
    fzy_native = {
      override_generic_sorter = true,
      override_file_sorter = true,
    }
  },
}
require('telescope').load_extension('fzy_native')

local M = {}
M.search_dotfiles = function()
    require("telescope.builtin").find_files({
        prompt_title = "< ~dotfiles~ >",
        cwd = "$HOME/dotfiles",
    })
end

M.delete_branches = function()
  require ('telescope.builtin').git_branches({
    attach_mappings = function(prompt_bufnr, map)
      map('i', '<c-d>', actions.git_delete_branch)
      map('n', '<c-d>', actions.git_delete_branch)
      return true
    end
  })
end

return M
