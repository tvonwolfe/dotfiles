local colorscheme = require '../colorscheme'

vim.g.everforest_better_performance = 1
vim.g.everforest_show_eob = 0

local function on_toggle(_)
  os.execute('flip')
end

local function read_bg()
  local home_dir = os.getenv("HOME")
  local file_open_ok, f = pcall(assert, io.open(home_dir .. "/.flip", "r"))

  if not file_open_ok then return 'dark' end

  local scheme = f:read("*l")
  f:close()

  if scheme == 'alternate' then return 'light' end

  return 'dark'
end

-- require('rose-pine').setup({
--   highlight_groups = {
--     Comment = { italic = true },
--     ["@keyword"] = { italic = true },
--     ["@variable"] = { italic = false },
--     ["@function"] = { italic = false },
--     ["@property"] = { italic = false },
--     ["@variable.parameter"] = { italic = false },
--     ["@parameter"] = { italic = false },
--   }
-- })

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

colorscheme.setup {
  fallback = 'slate',
  dark = 'kanagawa',
  light = 'rose-pine-dawn',
  on_toggle = on_toggle,
  get_bg = read_bg,
}
