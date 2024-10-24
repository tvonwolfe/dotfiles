local lualine = require 'lualine'
local lsp_progress = require 'lsp-progress'

lsp_progress.setup()

local function get_lsp_progres()
  return lsp_progress.progress()
end

lualine.setup {
  options = {
    component_separators = '',
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_x = {
      get_lsp_progres, 'filetype',
    }
  }
}

vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
vim.api.nvim_create_autocmd("User", {
  group = "lualine_augroup",
  pattern = "LspProgressStatusUpdated",
  callback = lualine.refresh,
})
