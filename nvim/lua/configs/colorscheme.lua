local colorscheme = require '../colorscheme'

-- local vim = vim
-- vim.g.everforest_better_performance = 1
-- vim.g.everforest_show_eob = 0

local function on_toggle(_)
  os.execute('flip')
end

colorscheme.setup {
  fallback = 'slate',
  dark = 'catppuccin-macchiato',
  light = 'catppuccin-latte',
  on_toggle = on_toggle,
}
