pcall(require, 'impatient')

-- enable the Lua module loader for faster startup
vim.loader.enable()

-- optionally require anything config that's specific to the current device
-- (e.g. work machine) that isn't needed/wanted everywhere else
pcall(require, 'config.device-specific')

require 'config.options'
require 'config.lazy'
require 'config.keymaps'
require 'config.autocmds'
require 'config.macros'
require 'config.lsp'
