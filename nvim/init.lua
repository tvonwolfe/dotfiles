pcall(require, 'impatient')

vim.loader.enable()

_G.nvim_config = {}

local work_ok, work = pcall(require, 'work')
if work_ok then work.setup_work_commands() end

require 'options'
require('config.lazy')
require('keymaps').setup()
require 'autocmds'

-- local colorscheme = require('colorscheme')

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

-- colorscheme.setup {
--   fallback = 'slate',
--   dark = 'kanagawa',
--   light = 'rose-pine-dawn',
--   on_toggle = on_toggle,
--   get_bg = read_bg,
-- }
