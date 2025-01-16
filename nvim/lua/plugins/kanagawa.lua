return {
    'rebelot/kanagawa.nvim',
    priority = 1000,
    lazy = false,
    config = function()
      require('kanagawa').setup({
        compile = true,
        colors = {
          theme = {
            all = {
              ui = {
                bg_gutter = "none"
              }
            }
          }
        },
        overrides = function(colors)
          local theme = colors.theme
          local make_diagnostic_color = function(color)
            local c = require('kanagawa.lib.color')
            return { fg = color, bg = c(color):blend(theme.ui.bg, 0.95):to_hex() }
          end

          return {
            DiagnosticVirtualTextHint  = make_diagnostic_color(theme.diag.hint),
            DiagnosticVirtualTextInfo  = make_diagnostic_color(theme.diag.info),
            DiagnosticVirtualTextWarn  = make_diagnostic_color(theme.diag.warning),
            DiagnosticVirtualTextError = make_diagnostic_color(theme.diag.error),
          }
        end
      })

      vim.cmd "colorscheme kanagawa"
    end
}
