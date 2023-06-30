local colorscheme = require '../colorscheme'
local vim = vim

vim.g.everforest_better_performance = 1

local function on_toggle(_)
  os.execute('flip')
end

colorscheme.setup {
  fallback = 'slate',
  dark = 'everforest',
  on_toggle = on_toggle,
}
