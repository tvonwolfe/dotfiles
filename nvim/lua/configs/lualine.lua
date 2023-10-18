local lualine = require 'lualine'

local function get_ruby_version()
  local str = vim.fn['rvm#statusline_ft_ruby']()
  return str.match(str, '%[ruby%-(%d+.%d+.%d+)%]')
end

local function get_js_version()
  return nil
end

local function get_lua_version()
  return nil
end

LANGUAGE_LUT = {
  eruby = get_ruby_version,
  ruby = get_ruby_version,
  javascript = get_js_version,
  javascriptreact = get_js_version,
  lua = get_lua_version,
}

local function get_language_version_fn()
  return LANGUAGE_LUT[vim.bo.filetype]()
end

lualine.setup {
  options = {
    component_separators = '',
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_x = {
      'filetype', get_language_version_fn
    }
  }
}
