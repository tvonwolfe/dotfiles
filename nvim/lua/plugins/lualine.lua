return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'linrongbin16/lsp-progress.nvim',
    'nvim-tree/nvim-web-devicons',
    'AndreM222/copilot-lualine'
  },
  config = function()
    local lualine = require('lualine')
    local lsp_progress = require('lsp-progress')
    lsp_progress.setup()

    local fmt = function(hide_width)
      return function(str)
        local width = vim.fn.winwidth(0)
        if width < hide_width then
          return ''
        end
        return str
      end
    end

    lualine.setup({
      options = {
        component_separators = '',
        section_separators = '',
        disabled_filetypes = {
          'Avante',
          'AvanteInput',
          'AvanteSelectedFiles',
          'AvanteTodos',
          'neotest-summary',
          'NvimTree'
        }
      },
      sections = {
        lualine_b = {
          { 'branch',      fmt = fmt(120) },
          { 'diff',        fmt = fmt(80) },
          { 'diagnostics', fmt = fmt(80) }
        },
        lualine_c = {
          {
            'filename',
            symbols = {
              modified = ' ',
              readonly = ' ',
            },
          },
        },
        lualine_x = {
          { 'copilot',             fmt = fmt(70) },
          { lsp_progress.progress, fmt = fmt(70) },
          { 'filetype',            fmt = fmt(50) }
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
