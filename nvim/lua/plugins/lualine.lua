return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'linrongbin16/lsp-progress.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    local lualine = require('lualine')
    local lsp_progress = require('lsp-progress')
    lsp_progress.setup()

    lualine.setup({
      options = {
        component_separators = '',
        section_separators = '',
        -- section_separators = { left = '', right = '' },
      },
      sections = {
        lualine_x = {
          lsp_progress.progress,
          'filetype',
        }
      }
    })

    vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
    vim.api.nvim_create_autocmd("User", {
      group = "lualine_augroup",
      pattern = "LspProgressStatusUpdated",
      callback = require('lualine').refresh,
    })
  end
}
