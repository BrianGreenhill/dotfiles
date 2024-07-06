require('nvim-treesitter').setup {
  ensure_install = { 'core', 'stable' },
  ensure_installed = { 'go', 'rust', 'ruby', 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'vim', 'vimdoc' },
  -- Autoinstall languages that are not installed
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = { 'ruby' },
  },
  indent = { enable = true, disable = { 'ruby' } },
}

require('nvim-treesitter.install').prefer_git = true
