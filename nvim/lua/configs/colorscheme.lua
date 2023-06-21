local colorscheme = require '../colorscheme'
local vim = vim

-- vim.g.everforest_better_performance = 1
-- vim.g.everforest_background = 'medium'

local function toggle(background)
  if background == 'light' then
    vim.opt.background = 'dark'
  else
    vim.opt.background = 'light'
  end
  os.execute('flip')
end

local function get_from_config_file()
  local filename = os.getenv('HOME') .. '/.flip'
  local f = assert(io.open(filename, 'r'))
  local contents = assert(f:read("*all"))
  f:close()

  local state = string.gsub(contents, "%s+", "")

  return state
end

colorscheme.setup {
  fallback = 'slate',
  default = 'tokyonight-storm',
  alternate = 'tokyonight-day',
  toggle_callback = toggle,
  on_startup = get_from_config_file,
}
