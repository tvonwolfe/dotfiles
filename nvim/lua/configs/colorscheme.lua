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

colorscheme.setup {
  fallback = 'slate',
  dark = 'tokyonight-storm',
  light = 'tokyonight-day',
  on_toggle = on_toggle,
  bg_detect_fn = read_bg,
}
