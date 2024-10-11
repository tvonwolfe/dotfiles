pcall(require, 'impatient')

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

_G.nvim_config = {}

local work_ok, work = pcall(require, 'work')
if work_ok then work.setup_work_commands() end

require 'plugins'
require 'options'
require 'keymaps'
require 'autocmds'
require 'plugins.colorscheme'
