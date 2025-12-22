return {
  dir = '~/.config/nvim/lua/plugin/colorscheme',
  dependencies = {
    'rebelot/kanagawa.nvim',
    'rose-pine/neovim',
  },
  priority = 1000,
  lazy = false,
  config = function()
    -- set up dark theme
    local kanagawa = require('kanagawa')
    kanagawa.setup({
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

    -- set up light theme
    require('rose-pine').setup({
      highlight_groups = {
        Comment = { italic = true },
        ["@keyword"] = { italic = true },
        ["@variable"] = { italic = false },
        ["@function"] = { italic = false },
        ["@property"] = { italic = false },
        ["@variable.parameter"] = { italic = false },
        ["@parameter"] = { italic = false },
      }
    })

    require('plugin.colorscheme').setup({
      dark = 'kanagawa',
      light = 'rose-pine'
    })
  end
}
