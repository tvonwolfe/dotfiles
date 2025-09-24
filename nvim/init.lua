pcall(require, 'impatient')

-- enable the Lua module loader for faster startup
vim.loader.enable()

local work_ok, work = pcall(require, 'config.work')
if work_ok then work.setup() end

require 'config.options'
require 'config.lazy'
require('config.keymaps').setup()
require 'config.autocmds'
require 'config.macros'
require 'config.lsp'
