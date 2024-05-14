local lualine = require 'lualine'
local lsp_progress = require 'lsp-progress'

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

lsp_progress.setup()

lualine.setup {
  options = {
    component_separators = '',
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_x = {
      function() return lsp_progress.progress() end, 'filetype', get_language_version_fn
    }
  }
}

vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
vim.api.nvim_create_autocmd("User", {
  group = "lualine_augroup",
  pattern = "LspProgressStatusUpdated",
  callback = lualine.refresh,
})
