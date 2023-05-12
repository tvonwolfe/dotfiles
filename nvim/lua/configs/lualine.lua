local vim = vim
local lualine = require 'lualine'

local get_ruby_version = function()
  local str = vim.fn['rvm#statusline_ft_ruby']()
  return str.match(str, '%[ruby%-(%d+.%d+.%d+)%]')
end

lualine.setup {
  options = {
    component_separators = '',
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_x = {
      'filetype', get_ruby_version
    }
  }
}
