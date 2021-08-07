local status_line = ""
local git_branch = ""
local avatar = "briangreenhill@github"

local function get_git_info()
    git_branch = vim.fn["fugitive#head"]()
    if not git_branch or git_branch == "" then
        git_branch = 'no git'
    end

    return git_branch
end

local function get_file_name()
    local name = vim.fn.bufname()

    if not name or name == "" then
        return "(no name)"
    end
    return name
  end

local function lsp_info()

    local warnings = vim.lsp.diagnostic.get_count(0, "Warning")
    local errors = vim.lsp.diagnostic.get_count(0, "Error")
    local hints = vim.lsp.diagnostic.get_count(0, "Hint")

    return string.format("Hints %d Warnings %d Errors %d", hints, warnings, errors)
end

local statusline = "%s >> (%s) [%s] | %s | %s"
function StatusLine()
    return string.format(statusline, avatar, get_git_info(), get_file_name(), lsp_info(), status_line)
end

vim.o.statusline = '%!v:lua.StatusLine()'

local M = {}

M.set_status = function(line)
    status_line = line
end

vim.api.nvim_exec([[
augroup GREENHILL_STATUSLINE
    autocmd!
    autocmd BufWritePre * :lua require("greenhill.statusline")
augroup END
 ]], false)

return M
