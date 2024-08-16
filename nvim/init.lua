pcall(require, 'impatient')

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

_G.nvim_config = {}

require 'plugins'
require 'options'
require 'keymaps'
require 'autocmds'
require 'configs.colorscheme'
pcall(require, 'lovevery')
