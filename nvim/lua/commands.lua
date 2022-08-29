local vim = vim
local colorscheme = require 'colorscheme'

vim.api.nvim_create_user_command('Flip', colorscheme.toggle_colorscheme, {})
