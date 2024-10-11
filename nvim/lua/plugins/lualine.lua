local lualine = require 'lualine'
local lsp_progress = require 'lsp-progress'

local function get_ruby_version()
  local str = vim.fn['rvm#statusline_ft_ruby']()
  return str.match(str, '%[ruby%-(%d+.%d+.%d+)%]')
end

local function get_node_version()
  local str = io.popen('node -v'):read('*a')
  return str:gsub('[\n\r]', '')
end

local function get_lua_version()
  return nil
end

LANGUAGE_LUT = {
  eruby = get_ruby_version,
  ruby = get_ruby_version,
  javascript = get_node_version,
  javascriptreact = get_node_version,
  typescript = get_node_version,
  typescriptreact = get_node_version,
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
