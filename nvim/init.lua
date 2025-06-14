-- Share non-plugin bindings between nvim and vim
vim.cmd(string.format("source $HOME/.vim/vimrc", vim.fn.stdpath("config")))

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("lazy").setup("plugins")

local builtin = require('telescope.builtin')
local opts = { noremap=true, silent=true }

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.keymap.set('n', '<leader>ff', builtin.find_files, opts)
vim.keymap.set('n', '<leader>fg', builtin.git_files, opts)
vim.keymap.set('n', '<leader>ag', builtin.live_grep, opts)
vim.keymap.set("n", "<leader>n", ":tabnew<CR>", { desc = "New tab with empty buffer" })
vim.keymap.set("n", "<leader>q", ":quit<CR>", { desc = "New tab with empty buffer" })

vim.keymap.set("n", "<leader>p", function()
    require("telescope").extensions.project.project()
end, { desc = "Telescope: Projects" })

local project_actions = require("telescope._extensions.project.actions")
require('telescope').setup {
    extensions = {
        project = {
            mappings = {
                n = {
                  ['d'] = project_actions.delete_project,
                  ['r'] = project_actions.rename_project,
                  ['c'] = project_actions.add_project,
                  ['C'] = project_actions.add_project_cwd,
                  ['f'] = project_actions.find_project_files,
                  ['b'] = project_actions.browse_project_files,
                  ['s'] = project_actions.search_in_project_files,
                  ['R'] = project_actions.recent_project_files,
                  ['w'] = project_actions.change_working_directory,
                  ['o'] = project_actions.next_cd_scope,
                },
            },
        },
    },
}

for i = 1, 9 do
    vim.keymap.set('n', '<leader>' .. i, function()
        vim.cmd(i .. 'tabnext')
    end, { desc = 'Go to tab ' .. i })
end

vim.o.showtabline = 2  -- always show tabline

vim.o.tabline = "%!v:lua.TabLine()"

function _G.TabLine()
    local s = ""
    for i = 1, vim.fn.tabpagenr('$') do
        local winnr = vim.fn.tabpagewinnr(i)
        local buflist = vim.fn.tabpagebuflist(i)
        local bufnr = buflist[winnr]
        local name = vim.fn.fnamemodify(vim.fn.bufname(bufnr), ":t")
        if name == "" then name = "[No Name]" end
        local hl = (i == vim.fn.tabpagenr()) and "%#TabLineSel#" or "%#TabLine#"
        s = s .. hl .. " " .. i .. ": " .. name .. " "
    end
    return s .. "%#TabLineFill#"
end

-- <leader>oc
-- <leader>oa
-- https://github.com/nvim-orgmode/orgmode/blob/master/docs/tutorial.org
local org = require('orgmode')
org.setup({
    org_agenda_files = {'~/org/**/*'},
    org_default_notes_file = '~/org/refile.org',

    org_capture_templates = {
        t = {
            description = 'Todo',
            template = '* TODO %?\n  SCHEDULED: %t',
            target = '~/org/todo.org',
        },
        n = {
            description = 'Note',
            template = '* %u %?\n',
            target = '~/org/notes.org',
        },
    }
})
