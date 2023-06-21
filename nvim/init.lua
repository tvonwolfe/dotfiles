local vim = vim

pcall(function() require('impatient') end)

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

_G.nvim_config = {}

require 'options'
require 'keymaps'
require 'plugins'
require 'autocmds'
require 'configs.colorscheme'
pcall(require, 'lovevery')
