local M = {}

local defaults = {
  dark = 'default',
  light = 'default',
  on_toggle = nil,
  on_set_colorscheme = nil,
}

local function set_colorscheme()
  local theme = M.options[vim.o.background]
  if type(theme) == 'function' then
    theme()
  elseif type(theme) == 'string' then
    vim.cmd("colorscheme " .. theme)
  else
    vim.notify("Invalid colorscheme: " .. vim.inspect(theme), vim.log.levels.ERROR)
  end
  local callback = M.options.on_set_colorscheme
  if (type(callback) == "function") then callback() end
end

local last_background = {}
local function background_did_change(r, g, b)
  local last_r, last_g, last_b = last_background
  local all_match = (last_r == r and last_g == g and last_b == b)

  if not all_match then
    last_background = { r, g, b }
    return true
  end

  return false
end

local function setup_autocmds()
  vim.api.nvim_create_autocmd("TermResponse", {
    callback = function(event)
      local resp = event.data.sequence
      local r, g, b = resp:match("\027%]11;rgb:(%w+)/(%w+)/(%w+)")

      if background_did_change(r, g, b) then set_colorscheme() end
    end
  })
end

M.options = {}

function M.setup(opts)
  M.options = vim.tbl_deep_extend("force", {}, defaults, opts or {})

  setup_autocmds()
end

return M
